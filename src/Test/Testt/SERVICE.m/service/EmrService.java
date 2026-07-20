package com.sunsheen.hearken.Sunsheen_system.tcm.service;

import com.sunsheen.hearken.Sunsheen_system.tcm.model.dto.request.EmrCreateRequest;
import com.sunsheen.hearken.Sunsheen_system.tcm.model.dto.response.EmrResponse;

import java.util.List;

public interface EmrService {
    List<EmrResponse> listEmrs(Long patientId, String status, int skip, int limit);
    EmrResponse getEmr(Long id);
    EmrResponse createEmr(EmrCreateRequest request);
    EmrResponse updateEmr(Long id, EmrCreateRequest request);
    void deleteEmr(Long id);
    List<EmrResponse> getHistoryRecords(Long emrId);
}
