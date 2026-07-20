package com.sunsheen.hearken.Sunsheen_system.tcm.service;

import com.sunsheen.hearken.Sunsheen_system.tcm.model.dto.request.VisitCreateRequest;
import com.sunsheen.hearken.Sunsheen_system.tcm.model.dto.response.VisitResponse;

import java.util.List;

public interface VisitService {
    List<VisitResponse> listVisits(Long patientId, String status, int skip, int limit);
    VisitResponse getVisit(Long id);
    VisitResponse createVisit(VisitCreateRequest request);
    VisitResponse updateVisit(Long id, VisitCreateRequest request);
    void deleteVisit(Long id);
}
