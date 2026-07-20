package com.sunsheen.hearken.Sunsheen_system.tcm.service;

import com.sunsheen.hearken.Sunsheen_system.tcm.model.dto.request.PatientCreateRequest;
import com.sunsheen.hearken.Sunsheen_system.tcm.model.dto.request.PatientUpdateRequest;
import com.sunsheen.hearken.Sunsheen_system.tcm.model.dto.response.PatientResponse;

import java.util.List;

public interface PatientService {
    List<PatientResponse> listPatients(int skip, int limit);
    PatientResponse getPatient(Long id);
    PatientResponse createPatient(PatientCreateRequest request);
    PatientResponse updatePatient(Long id, PatientUpdateRequest request);
    void deletePatient(Long id);
}
