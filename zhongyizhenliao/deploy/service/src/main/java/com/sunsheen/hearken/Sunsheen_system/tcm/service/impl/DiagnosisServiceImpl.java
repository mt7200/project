package com.sunsheen.hearken.Sunsheen_system.tcm.service.impl;

import com.sunsheen.hearken.Sunsheen_system.tcm.model.dto.response.DiagnosisResponse;
import com.sunsheen.hearken.Sunsheen_system.tcm.model.entity.DiagnosisResult;
import com.sunsheen.hearken.Sunsheen_system.tcm.repository.DiagnosisResultRepository;
import com.sunsheen.hearken.Sunsheen_system.tcm.service.DiagnosisService;
import org.springframework.stereotype.Service;

import java.time.LocalDateTime;
import java.util.List;

@Service
public class DiagnosisServiceImpl implements DiagnosisService {

    private final DiagnosisResultRepository diagnosisResultRepository;

    public DiagnosisServiceImpl(DiagnosisResultRepository diagnosisResultRepository) {
        this.diagnosisResultRepository = diagnosisResultRepository;
    }

    @Override
    public List<DiagnosisResponse> listDiagnoses(Long visitId) {
        return diagnosisResultRepository.findByVisitId(visitId).stream()
                .map(this::toResponse).toList();
    }

    @Override
    public DiagnosisResponse createDiagnosis(Long visitId, String patternName, String patternCode,
                                              Integer confidence, String analysis, String treatmentPrinciple) {
        DiagnosisResult dr = new DiagnosisResult();
        dr.setVisitId(visitId);
        dr.setPatternName(patternName);
        dr.setPatternCode(patternCode);
        dr.setConfidence(confidence);
        dr.setDifferentiation(analysis);
        dr.setTreatmentPrinciple(treatmentPrinciple);
        dr.setCreatedAt(LocalDateTime.now());
        dr.setUpdatedAt(LocalDateTime.now());
        dr = diagnosisResultRepository.save(dr);
        return toResponse(dr);
    }

    private DiagnosisResponse toResponse(DiagnosisResult dr) {
        DiagnosisResponse r = new DiagnosisResponse();
        r.setId(dr.getId());
        r.setVisitId(dr.getVisitId());
        r.setPatternName(dr.getPatternName());
        r.setPatternCode(dr.getPatternCode());
        r.setConfidence(dr.getConfidence());
        r.setAnalysis(dr.getDifferentiation());
        r.setTreatmentPrinciple(dr.getTreatmentPrinciple());
        r.setCreatedAt(dr.getCreatedAt());
        return r;
    }
}
