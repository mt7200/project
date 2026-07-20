package com.sunsheen.hearken.Sunsheen_system.tcm.service.impl;

import com.sunsheen.hearken.Sunsheen_system.tcm.model.dto.request.VisitCreateRequest;
import com.sunsheen.hearken.Sunsheen_system.tcm.model.dto.response.VisitResponse;
import com.sunsheen.hearken.Sunsheen_system.tcm.model.entity.Visit;
import com.sunsheen.hearken.Sunsheen_system.tcm.repository.VisitRepository;
import com.sunsheen.hearken.Sunsheen_system.tcm.service.VisitService;
import org.springframework.stereotype.Service;

import java.time.LocalDateTime;
import java.util.List;

@Service
public class VisitServiceImpl implements VisitService {

    private final VisitRepository visitRepository;

    public VisitServiceImpl(VisitRepository visitRepository) {
        this.visitRepository = visitRepository;
    }

    @Override
    public List<VisitResponse> listVisits(Long patientId, String status, int skip, int limit) {
        List<Visit> visits;
        if (patientId != null) {
            visits = visitRepository.findByPatientIdOrderByVisitDateDesc(patientId);
        } else if (status != null) {
            visits = visitRepository.findByStatusOrderByVisitDateDesc(status);
        } else {
            visits = visitRepository.findAll();
        }
        return visits.stream().skip(skip).limit(limit).map(this::toResponse).toList();
    }

    @Override
    public VisitResponse getVisit(Long id) {
        Visit visit = visitRepository.findById(id)
                .orElseThrow(() -> new RuntimeException("就诊记录不存在"));
        return toResponse(visit);
    }

    @Override
    public VisitResponse createVisit(VisitCreateRequest request) {
        Visit visit = new Visit();
        visit.setPatientId(request.getPatientId());
        visit.setDoctorId(request.getDoctorId());
        visit.setVisitDate(request.getVisitDate());
        visit.setChiefComplaint(request.getChiefComplaint());
        visit.setPresentIllness(request.getPresentIllness());
        visit.setPastHistory(request.getPastHistory());
        visit.setAllergyHistory(request.getAllergyHistory());
        visit.setPersonalHistory(request.getPersonalHistory());
        visit.setTongueImage(request.getTongueImage());
        visit.setPulseImage(request.getPulseImage());
        visit.setOtherExams(request.getOtherExams());
        visit.setStatus("ongoing");
        visit.setCreatedAt(LocalDateTime.now());
        visit.setUpdatedAt(LocalDateTime.now());
        visit = visitRepository.save(visit);
        return toResponse(visit);
    }

    @Override
    public VisitResponse updateVisit(Long id, VisitCreateRequest request) {
        Visit visit = visitRepository.findById(id)
                .orElseThrow(() -> new RuntimeException("就诊记录不存在"));
        if (request.getChiefComplaint() != null) visit.setChiefComplaint(request.getChiefComplaint());
        if (request.getPresentIllness() != null) visit.setPresentIllness(request.getPresentIllness());
        if (request.getPastHistory() != null) visit.setPastHistory(request.getPastHistory());
        if (request.getAllergyHistory() != null) visit.setAllergyHistory(request.getAllergyHistory());
        if (request.getPersonalHistory() != null) visit.setPersonalHistory(request.getPersonalHistory());
        if (request.getTongueImage() != null) visit.setTongueImage(request.getTongueImage());
        if (request.getPulseImage() != null) visit.setPulseImage(request.getPulseImage());
        if (request.getOtherExams() != null) visit.setOtherExams(request.getOtherExams());
        visit.setUpdatedAt(LocalDateTime.now());
        visit = visitRepository.save(visit);
        return toResponse(visit);
    }

    @Override
    public void deleteVisit(Long id) {
        if (!visitRepository.existsById(id)) {
            throw new RuntimeException("就诊记录不存在");
        }
        visitRepository.deleteById(id);
    }

    private VisitResponse toResponse(Visit visit) {
        VisitResponse r = new VisitResponse();
        r.setId(visit.getId());
        r.setPatientId(visit.getPatientId());
        r.setDoctorId(visit.getDoctorId());
        r.setVisitDate(visit.getVisitDate());
        r.setChiefComplaint(visit.getChiefComplaint());
        r.setPresentIllness(visit.getPresentIllness());
        r.setPastHistory(visit.getPastHistory());
        r.setAllergyHistory(visit.getAllergyHistory());
        r.setPersonalHistory(visit.getPersonalHistory());
        r.setTongueImage(visit.getTongueImage());
        r.setPulseImage(visit.getPulseImage());
        r.setOtherExams(visit.getOtherExams());
        r.setStatus(visit.getStatus());
        r.setCreatedAt(visit.getCreatedAt());
        r.setUpdatedAt(visit.getUpdatedAt());
        return r;
    }
}
