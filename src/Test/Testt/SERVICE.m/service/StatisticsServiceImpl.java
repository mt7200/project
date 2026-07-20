package com.sunsheen.hearken.Sunsheen_system.tcm.service.impl;

import com.sunsheen.hearken.Sunsheen_system.tcm.repository.*;
import com.sunsheen.hearken.Sunsheen_system.tcm.service.StatisticsService;
import org.springframework.stereotype.Service;

import java.util.*;

@Service
public class StatisticsServiceImpl implements StatisticsService {

    private final VisitRepository visitRepository;
    private final PrescriptionRepository prescriptionRepository;
    private final EmrRepository emrRepository;
    private final DiagnosisResultRepository diagnosisResultRepository;
    private final PrescriptionItemRepository prescriptionItemRepository;

    public StatisticsServiceImpl(VisitRepository visitRepository,
                                 PrescriptionRepository prescriptionRepository,
                                 EmrRepository emrRepository,
                                 DiagnosisResultRepository diagnosisResultRepository,
                                 PrescriptionItemRepository prescriptionItemRepository) {
        this.visitRepository = visitRepository;
        this.prescriptionRepository = prescriptionRepository;
        this.emrRepository = emrRepository;
        this.diagnosisResultRepository = diagnosisResultRepository;
        this.prescriptionItemRepository = prescriptionItemRepository;
    }

    @Override
    public Map<String, Object> getSummary() {
        long totalVisits = visitRepository.count();
        long totalPrescriptions = prescriptionRepository.count();

        long reviewedCount = prescriptionRepository.findByStatusInOrderByCreatedAtDesc(List.of("approved", "rejected")).size();
        long approvedCount = prescriptionRepository.findByStatusInOrderByCreatedAtDesc(List.of("approved")).size();
        double reviewPassRate = reviewedCount > 0 ? Math.round((double) approvedCount / reviewedCount * 10000.0) / 10000.0 : 0.0;

        long totalEmrs = emrRepository.countTotal();
        long effectiveCount = emrRepository.countEffective();
        double effectiveRate = totalEmrs > 0 ? Math.round((double) effectiveCount / totalEmrs * 10000.0) / 10000.0 : 0.0;

        Map<String, Object> summary = new LinkedHashMap<>();
        summary.put("total_visits", totalVisits);
        summary.put("total_prescriptions", totalPrescriptions);
        summary.put("review_pass_rate", reviewPassRate);
        summary.put("effective_rate", effectiveRate);
        return summary;
    }

    @Override
    public List<Map<String, Object>> getVisitCountByMonth() {
        List<Object[]> rows = visitRepository.countByMonth();
        return rows.stream().map(row -> {
            Map<String, Object> m = new LinkedHashMap<>();
            m.put("month", row[0]);
            m.put("count", row[1]);
            return m;
        }).toList();
    }

    @Override
    public List<Map<String, Object>> getSyndromeDistribution() {
        List<Object[]> rows = diagnosisResultRepository.countByPatternName();
        return rows.stream().map(row -> {
            Map<String, Object> m = new LinkedHashMap<>();
            m.put("name", row[0]);
            m.put("count", row[1]);
            return m;
        }).toList();
    }

    @Override
    public List<Map<String, Object>> getHerbRanking() {
        List<Object[]> rows = prescriptionItemRepository.countByHerbName();
        return rows.stream().map(row -> {
            Map<String, Object> m = new LinkedHashMap<>();
            m.put("name", row[0]);
            m.put("count", row[1]);
            return m;
        }).toList();
    }

    @Override
    public List<Map<String, Object>> getTreatmentResults() {
        List<Object[]> rows = emrRepository.countByTreatmentResult();
        return rows.stream().map(row -> {
            Map<String, Object> m = new LinkedHashMap<>();
            m.put("name", row[0]);
            m.put("count", row[1]);
            return m;
        }).toList();
    }
}
