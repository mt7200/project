package com.sunsheen.hearken.Sunsheen_system.tcm.service.impl;

import com.sunsheen.hearken.Sunsheen_system.tcm.model.dto.request.ReviewActionRequest;
import com.sunsheen.hearken.Sunsheen_system.tcm.model.dto.response.PrescriptionResponse;
import com.sunsheen.hearken.Sunsheen_system.tcm.model.dto.response.ReviewItemResponse;
import com.sunsheen.hearken.Sunsheen_system.tcm.model.dto.response.ReviewOutResponse;
import com.sunsheen.hearken.Sunsheen_system.tcm.model.entity.*;
import com.sunsheen.hearken.Sunsheen_system.tcm.repository.*;
import com.sunsheen.hearken.Sunsheen_system.tcm.service.IncompatibilityService;
import com.sunsheen.hearken.Sunsheen_system.tcm.service.ReviewService;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.math.BigDecimal;
import java.time.LocalDateTime;
import java.util.*;

@Service
public class ReviewServiceImpl implements ReviewService {

    private static final Map<String, List<String>> VALID_TRANSITIONS = Map.of(
        "draft", List.of("pending"),
        "pending", List.of("approved", "rejected"),
        "rejected", List.of("pending"),
        "approved", List.of()
    );

    private static final Map<String, String> RISK_LABEL = Map.of(
        "low", "低风险", "medium", "中风险", "high", "高风险", "critical", "极高风险"
    );

    private final PrescriptionRepository prescriptionRepository;
    private final PrescriptionItemRepository itemRepository;
    private final PrescriptionReviewRepository reviewRepository;
    private final PatientRepository patientRepository;
    private final HerbRepository herbRepository;

    public ReviewServiceImpl(PrescriptionRepository prescriptionRepository,
                             PrescriptionItemRepository itemRepository,
                             PrescriptionReviewRepository reviewRepository,
                             PatientRepository patientRepository,
                             HerbRepository herbRepository) {
        this.prescriptionRepository = prescriptionRepository;
        this.itemRepository = itemRepository;
        this.reviewRepository = reviewRepository;
        this.patientRepository = patientRepository;
        this.herbRepository = herbRepository;
    }

    Map<String, Object> runAutoReview(Prescription rx, List<Map<String, Object>> herbsForCheck) {
        if (herbsForCheck == null || herbsForCheck.isEmpty()) {
            List<Map<String, Object>> items = new ArrayList<>();
            itemRepository.findByPrescriptionIdOrderById(rx.getId()).forEach(it -> {
                Map<String, Object> m = new HashMap<>();
                m.put("id", it.getHerbId());
                m.put("name", it.getHerbName());
                m.put("current_dosage", it.getDosage());
                items.add(m);
            });
            herbsForCheck = items;
        }

        Map<String, Object> dosageResult = validateDosage(herbsForCheck);
        List<Map<String, Object>> conflicts = IncompatibilityService.checkIncompatibility(herbsForCheck);

        int dosageScore = (Integer) dosageResult.getOrDefault("score", 0);
        int score = dosageScore + conflicts.size() * 11;
        boolean hasCritical = (Boolean) dosageResult.getOrDefault("has_critical", false);
        String riskLevel = determineRiskLevel(score, hasCritical, !conflicts.isEmpty());

        List<String> dosageMsgs = new ArrayList<>();
        ((List<Map<String, Object>>) dosageResult.getOrDefault("warnings", List.of()))
                .forEach(w -> dosageMsgs.add((String) w.get("message")));
        ((List<Map<String, Object>>) dosageResult.getOrDefault("high_risks", List.of()))
                .forEach(h -> dosageMsgs.add((String) h.get("message")));
        ((List<Map<String, Object>>) dosageResult.getOrDefault("critical_risks", List.of()))
                .forEach(c -> dosageMsgs.add((String) c.get("message")));

        String dosageCheckStr = dosageMsgs.isEmpty() ? "通过" : String.join("；", dosageMsgs);

        List<String> incompatibilityMsgs = conflicts.stream()
                .map(c -> c.get("herb_a") + "-" + c.get("herb_b") + "（" + c.get("type") + "）")
                .toList();
        String incompatibilityCheckStr = incompatibilityMsgs.isEmpty() ? "通过" : String.join("；", incompatibilityMsgs);

        List<String> risks = new ArrayList<>();
        List<String> suggestions = new ArrayList<>();
        dosageMsgs.forEach(m -> risks.add("[剂量超限] " + m));
        incompatibilityMsgs.forEach(m -> risks.add("[配伍禁忌] " + m));
        if (!((List<?>) dosageResult.getOrDefault("warnings", List.of())).isEmpty())
            suggestions.add("请核对低于最小剂量的药材，确认是否需要调整");
        if (!((List<?>) dosageResult.getOrDefault("high_risks", List.of())).isEmpty()
                || !((List<?>) dosageResult.getOrDefault("critical_risks", List.of())).isEmpty())
            suggestions.add("存在超量用药，建议调整剂量或更换药材");
        if (!conflicts.isEmpty())
            suggestions.add("检测到十八反/十九畏配伍，建议立即调整处方");
        if (risks.isEmpty()) risks.add("无风险项");

        PrescriptionReview review = new PrescriptionReview();
        review.setPrescriptionId(rx.getId());
        review.setReviewerId(rx.getDoctorId() != null ? rx.getDoctorId() : 1L);
        review.setReviewStatus("auto_reviewed");
        review.setReviewComment(RISK_LABEL.getOrDefault(riskLevel, riskLevel));
        review.setRiskScore(score);
        review.setDosageWarnings(truncate(dosageCheckStr, 200));
        review.setIncompatibilityFound(truncate(incompatibilityCheckStr, 500));
        review.setCreatedAt(LocalDateTime.now());
        reviewRepository.save(review);

        Map<String, Object> result = new HashMap<>();
        result.put("review_id", review.getId());
        result.put("risk_level", riskLevel);
        result.put("risk_score", score);
        result.put("dosage_check", dosageCheckStr);
        result.put("incompatibility_check", incompatibilityCheckStr);
        result.put("risks", risks);
        result.put("suggestions", suggestions);
        result.put("compatibility_risk", !conflicts.isEmpty());
        result.put("dosage_risk", !dosageMsgs.isEmpty());
        result.put("contraindication_risk", !conflicts.isEmpty());
        return result;
    }

    @Override
    public List<ReviewItemResponse> listReviews(String status) {
        List<Prescription> prescriptions;
        if (status != null && !status.isEmpty()) {
            prescriptions = prescriptionRepository.findByStatusOrderByCreatedAtDesc(status);
        } else {
            prescriptions = prescriptionRepository.findAllByOrderByCreatedAtDesc();
        }
        return prescriptions.stream().map(this::buildReviewItem).toList();
    }

    @Override
    @Transactional
    public ReviewOutResponse submitForReview(Long prescriptionId) {
        Prescription rx = prescriptionRepository.findById(prescriptionId)
                .orElseThrow(() -> new RuntimeException("处方不存在"));

        String current = rx.getStatus() != null ? rx.getStatus() : "draft";
        if (VALID_TRANSITIONS.getOrDefault(current, List.of()).contains("pending")) {
            rx.setStatus("pending");
            rx.setUpdatedAt(LocalDateTime.now());
            prescriptionRepository.save(rx);
        }

        PrescriptionReview review = new PrescriptionReview();
        review.setPrescriptionId(rx.getId());
        review.setReviewerId(rx.getDoctorId() != null ? rx.getDoctorId() : 1L);
        review.setReviewStatus("pending");
        review.setCreatedAt(LocalDateTime.now());
        reviewRepository.save(review);

        return toReviewOut(review, rx.getId(), "low");
    }

    @Override
    @Transactional
    public ReviewOutResponse processReview(Long reviewId, ReviewActionRequest request) {
        PrescriptionReview review = reviewRepository.findById(reviewId)
                .orElseThrow(() -> new RuntimeException("审核记录不存在"));

        Prescription rx = prescriptionRepository.findById(review.getPrescriptionId())
                .orElseThrow(() -> new RuntimeException("处方不存在"));

        String currentStatus = rx.getStatus() != null ? rx.getStatus() : "pending";
        String targetAction = request.getAction();
        List<String> allowed = VALID_TRANSITIONS.getOrDefault(currentStatus, List.of());

        if (!allowed.contains(targetAction)) {
            ReviewOutResponse err = new ReviewOutResponse();
            err.setId(reviewId);
            err.setPrescriptionId(rx.getId());
            err.setRiskLevel("low");
            err.setReviewStatus(review.getReviewStatus());
            err.setComment("不允许从 [" + currentStatus + "] 执行 [" + targetAction + "]");
            return err;
        }

        rx.setStatus(targetAction);
        rx.setUpdatedAt(LocalDateTime.now());
        prescriptionRepository.save(rx);

        review.setReviewStatus(targetAction);
        review.setReviewComment(request.getComment());
        review.setReviewedAt(LocalDateTime.now());
        reviewRepository.save(review);

        String riskLevel = determineRiskLevel(review.getRiskScore() != null ? review.getRiskScore() : 0, false, false);
        return toReviewOut(review, rx.getId(), riskLevel);
    }

    void attachReviewInfo(PrescriptionResponse r, Long prescriptionId) {
        List<PrescriptionReview> reviews = reviewRepository.findByPrescriptionIdOrderByCreatedAtDesc(prescriptionId);
        if (reviews.isEmpty()) return;

        PrescriptionReview latest = reviews.get(0);
        r.setRiskScore(latest.getRiskScore() != null ? latest.getRiskScore() : 0);
        int score = latest.getRiskScore() != null ? latest.getRiskScore() : 0;
        r.setRiskLevel(determineRiskLevel(score, false, false));
        r.setReviewer(String.valueOf(latest.getReviewerId()));

        if (latest.getDosageWarnings() != null && !"通过".equals(latest.getDosageWarnings())) {
            r.setDosageRisk(true);
        }
        if (latest.getIncompatibilityFound() != null && !"通过".equals(latest.getIncompatibilityFound())) {
            r.setCompatibilityRisk(true);
            r.setContraindicationRisk(true);
        }
    }

    private ReviewItemResponse buildReviewItem(Prescription rx) {
        ReviewItemResponse item = new ReviewItemResponse();
        item.setId(rx.getId());

        patientRepository.findById(rx.getPatientId()).ifPresent(p -> item.setPatientName(p.getName()));

        item.setDiagnosis(rx.getDiagnosis());
        item.setSyndrome(rx.getSyndrome());

        List<String> herbNames = itemRepository.findByPrescriptionIdOrderById(rx.getId())
                .stream().map(PrescriptionItem::getHerbName).toList();
        item.setHerbs(herbNames);
        item.setStatus(rx.getStatus() != null ? rx.getStatus() : "pending");
        item.setCreatedAt(rx.getCreatedAt());

        List<PrescriptionReview> reviews = reviewRepository.findByPrescriptionIdOrderByCreatedAtDesc(rx.getId());
        List<String> risks = new ArrayList<>();
        List<String> suggestions = new ArrayList<>();
        String riskLevel = "low";
        int riskScore = 0;
        boolean compatibilityRisk = false;
        boolean dosageRisk = false;
        boolean contraindicationRisk = false;
        String reviewer = null;
        LocalDateTime reviewedAt = null;

        if (!reviews.isEmpty()) {
            PrescriptionReview review = reviews.get(0);
            riskScore = review.getRiskScore() != null ? review.getRiskScore() : 0;
            riskLevel = determineRiskLevel(riskScore, false, false);
            reviewer = review.getReviewerId() != null ? String.valueOf(review.getReviewerId()) : null;
            reviewedAt = review.getReviewedAt();

            if (review.getDosageWarnings() != null && !"通过".equals(review.getDosageWarnings())) {
                dosageRisk = true;
                risks.add("[剂量] " + review.getDosageWarnings());
            }
            if (review.getIncompatibilityFound() != null && !"通过".equals(review.getIncompatibilityFound())) {
                compatibilityRisk = true;
                contraindicationRisk = true;
                risks.add("[配伍] " + review.getIncompatibilityFound());
            }
            if (review.getReviewComment() != null) {
                suggestions.add(review.getReviewComment());
            }
        } else if (!herbNames.isEmpty()) {
            List<Map<String, Object>> herbsForCheck = itemRepository.findByPrescriptionIdOrderById(rx.getId())
                    .stream().map(it -> {
                        Map<String, Object> m = new HashMap<>();
                        m.put("id", it.getHerbId());
                        m.put("name", it.getHerbName());
                        m.put("current_dosage", it.getDosage());
                        return m;
                    }).toList();

            Map<String, Object> auto = runAutoReview(rx, herbsForCheck);
            riskLevel = (String) auto.get("risk_level");
            riskScore = (Integer) auto.get("risk_score");
            risks = (List<String>) auto.get("risks");
            suggestions = (List<String>) auto.get("suggestions");
            compatibilityRisk = (Boolean) auto.get("compatibility_risk");
            dosageRisk = (Boolean) auto.get("dosage_risk");
            contraindicationRisk = (Boolean) auto.get("contraindication_risk");
            reviewedAt = LocalDateTime.now();
        }

        item.setRiskLevel(riskLevel);
        item.setRiskScore(riskScore);
        item.setCompatibilityRisk(compatibilityRisk);
        item.setDosageRisk(dosageRisk);
        item.setContraindicationRisk(contraindicationRisk);
        item.setRisks(risks);
        item.setSuggestions(suggestions);
        item.setReviewer(reviewer);
        item.setReviewedAt(reviewedAt);

        return item;
    }

    private Map<String, Object> validateDosage(List<Map<String, Object>> herbs) {
        List<Map<String, Object>> warnings = new ArrayList<>();
        List<Map<String, Object>> highRisks = new ArrayList<>();
        List<Map<String, Object>> criticalRisks = new ArrayList<>();
        int score = 0;

        for (Map<String, Object> herb : herbs) {
            Object idObj = herb.get("id");
            if (idObj == null) continue;
            Long herbId;
            if (idObj instanceof Number n) herbId = n.longValue();
            else herbId = Long.valueOf(idObj.toString());

            String name = (String) herb.getOrDefault("name", "未知");
            BigDecimal dosage;
            Object dObj = herb.get("current_dosage");
            if (dObj instanceof BigDecimal bd) dosage = bd;
            else if (dObj instanceof Number n) dosage = BigDecimal.valueOf(n.doubleValue());
            else dosage = BigDecimal.ZERO;

            Optional<Herb> hOpt = herbRepository.findById(herbId);
            if (hOpt.isEmpty()) continue;
            Herb h = hOpt.get();

            BigDecimal minD = h.getMinDosage() != null ? h.getMinDosage() : BigDecimal.ZERO;
            BigDecimal maxD = h.getMaxDosage() != null ? h.getMaxDosage() : BigDecimal.valueOf(999);

            if (dosage.compareTo(minD) < 0) {
                Map<String, Object> w = new HashMap<>();
                w.put("herb_name", name);
                w.put("message", name + " 用量 (" + dosage + "g) 低于最小剂量 (" + minD + "g)");
                warnings.add(w);
                score += 1;
            } else if (dosage.compareTo(maxD.multiply(BigDecimal.valueOf(1.5))) > 0) {
                Map<String, Object> c = new HashMap<>();
                c.put("herb_name", name);
                c.put("message", name + " 用量 (" + dosage + "g) 超过最大剂量 1.5 倍 (" + maxD.multiply(BigDecimal.valueOf(1.5)) + "g)");
                criticalRisks.add(c);
                score += 11;
            } else if (dosage.compareTo(maxD) > 0) {
                Map<String, Object> h2 = new HashMap<>();
                h2.put("herb_name", name);
                h2.put("message", name + " 用量 (" + dosage + "g) 超过最大剂量 (" + maxD + "g)");
                highRisks.add(h2);
                score += 5;
            }
        }

        Map<String, Object> result = new HashMap<>();
        result.put("warnings", warnings);
        result.put("high_risks", highRisks);
        result.put("critical_risks", criticalRisks);
        result.put("has_critical", !criticalRisks.isEmpty());
        result.put("score", score);
        return result;
    }

    private String determineRiskLevel(int score, boolean hasCritical, boolean hasIncompatibility) {
        if (hasCritical || hasIncompatibility || score >= 11) return "high";
        if (score >= 6) return "medium";
        return "low";
    }

    private ReviewOutResponse toReviewOut(PrescriptionReview review, Long prescriptionId, String riskLevel) {
        ReviewOutResponse r = new ReviewOutResponse();
        r.setId(review.getId());
        r.setPrescriptionId(prescriptionId);
        r.setRiskLevel(riskLevel);
        r.setReviewStatus(review.getReviewStatus());
        r.setComment(review.getReviewComment());
        r.setReviewedAt(review.getReviewedAt());
        return r;
    }

    private String truncate(String s, int maxLen) {
        if (s == null) return null;
        return s.length() <= maxLen ? s : s.substring(0, maxLen);
    }
}
