package com.sunsheen.hearken.Sunsheen_system.tcm.controller;

import com.sunsheen.hearken.Sunsheen_system.login.common.constant.R;
import com.sunsheen.hearken.Sunsheen_system.tcm.model.dto.request.PrescriptionCreateRequest;
import com.sunsheen.hearken.Sunsheen_system.tcm.model.dto.response.PrescriptionResponse;
import com.sunsheen.hearken.Sunsheen_system.tcm.service.PrescriptionService;
import org.springframework.web.bind.annotation.*;

import java.util.List;

import static com.sunsheen.hearken.Sunsheen_system.tcm.common.constant.TcmConst.API_PREFIX;

@RestController
@RequestMapping(API_PREFIX + "/prescriptions")
public class PrescriptionController {

    private final PrescriptionService prescriptionService;

    public PrescriptionController(PrescriptionService prescriptionService) {
        this.prescriptionService = prescriptionService;
    }

    @GetMapping("/")
    public R<List<PrescriptionResponse>> listPrescriptions(
            @RequestParam(required = false) String status,
            @RequestParam(required = false) Long patientId) {
        return R.success(prescriptionService.listPrescriptions(status, patientId));
    }

    @GetMapping("/{id}")
    public R<PrescriptionResponse> getPrescription(@PathVariable Long id) {
        try {
            return R.success(prescriptionService.getPrescription(id));
        } catch (RuntimeException e) {
            return R.failed(null, e.getMessage(), null, null);
        }
    }

    @PostMapping("/")
    public R<PrescriptionResponse> createPrescription(@RequestBody PrescriptionCreateRequest request) {
        try {
            return R.success(prescriptionService.createPrescription(request));
        } catch (RuntimeException e) {
            return R.failed(null, e.getMessage(), null, null);
        }
    }
}
