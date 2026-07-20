package com.sunsheen.hearken.Sunsheen_system.tcm.service;

import com.sunsheen.hearken.Sunsheen_system.tcm.model.dto.response.DiagnosisResponse;

import java.util.List;

public interface DiagnosisService {
    List<DiagnosisResponse> listDiagnoses(Long visitId);
    DiagnosisResponse createDiagnosis(Long visitId, String patternName, String patternCode, Integer confidence, String analysis, String treatmentPrinciple);
}
