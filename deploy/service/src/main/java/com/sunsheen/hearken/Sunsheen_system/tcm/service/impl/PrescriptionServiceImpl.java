package com.sunsheen.hearken.Sunsheen_system.tcm.service.impl;

import com.sunsheen.hearken.Sunsheen_system.tcm.model.dto.request.PrescriptionCreateRequest;
import com.sunsheen.hearken.Sunsheen_system.tcm.model.dto.response.PrescriptionResponse;
import com.sunsheen.hearken.Sunsheen_system.tcm.model.entity.*;
import com.sunsheen.hearken.Sunsheen_system.tcm.repository.*;
import com.sunsheen.hearken.Sunsheen_system.tcm.service.PrescriptionService;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.math.BigDecimal;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.*;

@Service
public class PrescriptionServiceImpl implements PrescriptionService {

    private final PrescriptionRepository prescriptionRepository;
    private final PrescriptionItemRepository itemRepository;
    private final HerbRepository herbRepository;
    private final ReviewServiceImpl reviewService;

    public PrescriptionServiceImpl(PrescriptionRepository prescriptionRepository,
                                   PrescriptionItemRepository itemRepository,
                                   HerbRepository herbRepository,
                                   ReviewServiceImpl reviewService) {
        this.prescriptionRepository = prescriptionRepository;
        this.itemRepository = itemRepository;
        this.herbRepository = herbRepository;
        this.reviewService = reviewService;
    }

    @Override
    public List<PrescriptionResponse> listPrescriptions(String status, Long patientId) {
        List<Prescription> list;
        if (status != null && !status.isEmpty()) {
            list = prescriptionRepository.findByStatusOrderByCreatedAtDesc(status);
        } else if (patientId != null) {
            list = prescriptionRepository.findByPatientIdOrderByCreatedAtDesc(patientId);
        } else {
            list = prescriptionRepository.findAllByOrderByCreatedAtDesc();
        }
        return list.stream().map(this::toResponse).toList();
    }

    @Override
    public PrescriptionResponse getPrescription(Long id) {
        Prescription rx = prescriptionRepository.findById(id)
                .orElseThrow(() -> new RuntimeException("处方不存在"));
        return toResponse(rx);
    }

    @Override
    @Transactional
    public PrescriptionResponse createPrescription(PrescriptionCreateRequest request) {
        // Generate prescription_no
        String prefix = "RX" + LocalDate.now().format(DateTimeFormatter.ofPattern("yyyyMMdd"));
        long count = prescriptionRepository.countByPrescriptionNoLike(prefix + "%");
        String rxNo = prefix + String.format("%03d", count + 1);

        Prescription rx = new Prescription();
        rx.setPrescriptionNo(rxNo);
        rx.setVisitId(request.getVisitId());
        rx.setPatientId(request.getPatientId());
        rx.setDoctorId(request.getDoctorId());
        rx.setFormulaId(request.getFormulaId());
        rx.setDiagnosis(request.getDiagnosis());
        rx.setSyndrome(request.getSyndrome());
        rx.setNotes(request.getNotes());
        rx.setStatus("draft");
        rx.setCreatedAt(LocalDateTime.now());
        rx.setUpdatedAt(LocalDateTime.now());
        rx = prescriptionRepository.save(rx);

        List<Map<String, Object>> herbsForCheck = new ArrayList<>();
        for (int idx = 0; idx < request.getItems().size(); idx++) {
            var item = request.getItems().get(idx);
            Optional<Herb> herbOpt = herbRepository.findById(item.getHerbId());
            PrescriptionItem pi = new PrescriptionItem();
            pi.setPrescriptionId(rx.getId());
            pi.setHerbId(item.getHerbId());
            pi.setHerbName(herbOpt.map(Herb::getName).orElse("未知"));
            pi.setDosage(item.getDosage());
            pi.setUnit(item.getUnit() != null ? item.getUnit() : "g");
            pi.setSortOrder(idx);
            itemRepository.save(pi);

            if (herbOpt.isPresent()) {
                Herb h = herbOpt.get();
                Map<String, Object> checkItem = new HashMap<>();
                checkItem.put("id", h.getId());
                checkItem.put("name", h.getName());
                checkItem.put("current_dosage", item.getDosage());
                herbsForCheck.add(checkItem);
            }
        }

        reviewService.runAutoReview(rx, herbsForCheck);

        rx = prescriptionRepository.findById(rx.getId()).orElse(rx);
        return toResponse(rx);
    }

    PrescriptionResponse toResponse(Prescription rx) {
        PrescriptionResponse r = new PrescriptionResponse();
        r.setId(rx.getId());
        r.setPrescriptionNo(rx.getPrescriptionNo());
        r.setPatientId(rx.getPatientId());
        r.setDoctorId(rx.getDoctorId());
        r.setVisitId(rx.getVisitId());
        r.setFormulaId(rx.getFormulaId());
        r.setDiagnosis(rx.getDiagnosis());
        r.setSyndrome(rx.getSyndrome());
        r.setNotes(rx.getNotes());
        r.setStatus(rx.getStatus());
        r.setCreatedAt(rx.getCreatedAt());

        // Attach review info if available
        reviewService.attachReviewInfo(r, rx.getId());

        return r;
    }
}
