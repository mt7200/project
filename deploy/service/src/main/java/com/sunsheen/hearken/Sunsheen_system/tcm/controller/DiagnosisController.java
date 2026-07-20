package com.sunsheen.hearken.Sunsheen_system.tcm.controller;

import com.sunsheen.hearken.Sunsheen_system.login.common.constant.R;
import com.sunsheen.hearken.Sunsheen_system.tcm.model.dto.response.DiagnosisResponse;
import com.sunsheen.hearken.Sunsheen_system.tcm.service.DiagnosisService;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.Map;

import static com.sunsheen.hearken.Sunsheen_system.tcm.common.constant.TcmConst.API_PREFIX;

@RestController
@RequestMapping(API_PREFIX + "/diagnoses")
public class DiagnosisController {

    private final DiagnosisService diagnosisService;

    public DiagnosisController(DiagnosisService diagnosisService) {
        this.diagnosisService = diagnosisService;
    }

    @GetMapping("/")
    public R<List<DiagnosisResponse>> listDiagnoses(
            @RequestParam(required = false) Long visitId) {
        if (visitId == null) {
            return R.success(List.of());
        }
        return R.success(diagnosisService.listDiagnoses(visitId));
    }

    @PostMapping("/")
    public R<DiagnosisResponse> createDiagnosis(@RequestBody Map<String, Object> payload) {
        Long visitId = payload.get("visit_id") != null ? Long.valueOf(payload.get("visit_id").toString()) : null;
        String patternName = (String) payload.get("pattern_name");
        String patternCode = (String) payload.get("pattern_code");
        Integer confidence = payload.get("confidence") != null ? Integer.valueOf(payload.get("confidence").toString()) : null;
        String analysis = (String) payload.get("analysis");
        String treatmentPrinciple = (String) payload.get("treatment_principle");
        return R.success(diagnosisService.createDiagnosis(visitId, patternName, patternCode, confidence, analysis, treatmentPrinciple));
    }
}
