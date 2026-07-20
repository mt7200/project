package com.sunsheen.hearken.Sunsheen_system.tcm.service;

import com.sunsheen.hearken.Sunsheen_system.tcm.model.dto.request.PrescriptionCreateRequest;
import com.sunsheen.hearken.Sunsheen_system.tcm.model.dto.response.PrescriptionResponse;

import java.util.List;

public interface PrescriptionService {
    List<PrescriptionResponse> listPrescriptions(String status, Long patientId);
    PrescriptionResponse getPrescription(Long id);
    PrescriptionResponse createPrescription(PrescriptionCreateRequest request);
}
