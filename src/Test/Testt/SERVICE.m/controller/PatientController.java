package com.sunsheen.hearken.Sunsheen_system.tcm.controller;

import com.sunsheen.hearken.Sunsheen_system.login.common.constant.R;
import com.sunsheen.hearken.Sunsheen_system.tcm.model.dto.request.PatientCreateRequest;
import com.sunsheen.hearken.Sunsheen_system.tcm.model.dto.request.PatientUpdateRequest;
import com.sunsheen.hearken.Sunsheen_system.tcm.model.dto.response.PatientResponse;
import com.sunsheen.hearken.Sunsheen_system.tcm.service.PatientService;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.Map;

import static com.sunsheen.hearken.Sunsheen_system.tcm.common.constant.TcmConst.API_PREFIX;

@RestController
@RequestMapping(API_PREFIX + "/patients")
public class PatientController {

    private final PatientService patientService;

    public PatientController(PatientService patientService) {
        this.patientService = patientService;
    }

    @GetMapping("/")
    public R<List<PatientResponse>> listPatients(
            @RequestParam(defaultValue = "0") int skip,
            @RequestParam(defaultValue = "50") int limit) {
        return R.success(patientService.listPatients(skip, limit));
    }

    @GetMapping("/{id}")
    public R<PatientResponse> getPatient(@PathVariable Long id) {
        try {
            return R.success(patientService.getPatient(id));
        } catch (RuntimeException e) {
            return R.failed(null, e.getMessage(), null, null);
        }
    }

    @PostMapping("/")
    public R<PatientResponse> createPatient(@RequestBody PatientCreateRequest request) {
        return R.success(patientService.createPatient(request));
    }

    @PutMapping("/{id}")
    public R<PatientResponse> updatePatient(@PathVariable Long id, @RequestBody PatientUpdateRequest request) {
        try {
            return R.success(patientService.updatePatient(id, request));
        } catch (RuntimeException e) {
            return R.failed(null, e.getMessage(), null, null);
        }
    }

    @DeleteMapping("/{id}")
    public R<Map<String, String>> deletePatient(@PathVariable Long id) {
        try {
            patientService.deletePatient(id);
            return R.success(Map.of("message", "已删除"));
        } catch (RuntimeException e) {
            return R.failed(null, e.getMessage(), null, null);
        }
    }
}
