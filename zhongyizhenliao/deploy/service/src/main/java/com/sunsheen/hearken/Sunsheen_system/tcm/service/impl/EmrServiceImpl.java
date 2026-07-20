package com.sunsheen.hearken.Sunsheen_system.tcm.service.impl;

import com.sunsheen.hearken.Sunsheen_system.tcm.model.dto.request.EmrCreateRequest;
import com.sunsheen.hearken.Sunsheen_system.tcm.model.dto.response.EmrResponse;
import com.sunsheen.hearken.Sunsheen_system.tcm.model.entity.Emr;
import com.sunsheen.hearken.Sunsheen_system.tcm.repository.EmrRepository;
import com.sunsheen.hearken.Sunsheen_system.tcm.service.EmrService;
import org.springframework.stereotype.Service;

import java.time.LocalDateTime;
import java.util.List;

@Service
public class EmrServiceImpl implements EmrService {

    private final EmrRepository emrRepository;

    public EmrServiceImpl(EmrRepository emrRepository) {
        this.emrRepository = emrRepository;
    }

    @Override
    public List<EmrResponse> listEmrs(Long patientId, String status, int skip, int limit) {
        List<Emr> records;
        if (patientId != null) {
            records = emrRepository.findByPatientIdOrderByVisitDateDesc(patientId);
        } else if (status != null) {
            records = emrRepository.findByStatusOrderByVisitDateDesc(status);
        } else {
            records = emrRepository.findAll();
        }
        return records.stream().skip(skip).limit(limit).map(this::toResponse).toList();
    }

    @Override
    public EmrResponse getEmr(Long id) {
        Emr record = emrRepository.findById(id)
                .orElseThrow(() -> new RuntimeException("病历不存在"));
        return toResponse(record);
    }

    @Override
    public EmrResponse createEmr(EmrCreateRequest request) {
        Emr record = new Emr();
        copyFields(record, request);
        record.setCreatedAt(LocalDateTime.now());
        record.setUpdatedAt(LocalDateTime.now());
        record = emrRepository.save(record);
        return toResponse(record);
    }

    @Override
    public EmrResponse updateEmr(Long id, EmrCreateRequest request) {
        Emr record = emrRepository.findById(id)
                .orElseThrow(() -> new RuntimeException("病历不存在"));
        copyFields(record, request);
        record.setUpdatedAt(LocalDateTime.now());
        record = emrRepository.save(record);
        return toResponse(record);
    }

    @Override
    public void deleteEmr(Long id) {
        if (!emrRepository.existsById(id)) {
            throw new RuntimeException("病历不存在");
        }
        emrRepository.deleteById(id);
    }

    @Override
    public List<EmrResponse> getHistoryRecords(Long emrId) {
        Emr current = emrRepository.findById(emrId)
                .orElseThrow(() -> new RuntimeException("病历不存在"));
        return emrRepository.findByPatientIdOrderByVisitDateDesc(current.getPatientId())
                .stream().filter(e -> !e.getId().equals(emrId))
                .map(this::toResponse).toList();
    }

    private void copyFields(Emr record, EmrCreateRequest r) {
        record.setPatientId(r.getPatientId());
        record.setVisitDate(r.getVisitDate());
        record.setDoctorId(r.getDoctorId());
        record.setVisitId(r.getVisitId());
        record.setPrescriptionId(r.getPrescriptionId());
        record.setChiefComplaint(r.getChiefComplaint());
        record.setPresentIllness(r.getPresentIllness());
        record.setPastHistory(r.getPastHistory());
        record.setTongueImage(r.getTongueImage());
        record.setPulseImage(r.getPulseImage());
        record.setComplexion(r.getComplexion());
        record.setVoice(r.getVoice());
        record.setSyndrome(r.getSyndrome());
        record.setDiagnosis(r.getDiagnosis());
        record.setTreatmentPrinciple(r.getTreatmentPrinciple());
        record.setPrescriptionText(r.getPrescriptionText());
        record.setNotes(r.getNotes());
        record.setTreatmentResult(r.getTreatmentResult());
        record.setFollowUp(r.getFollowUp());
        record.setStatus(r.getStatus() != null ? r.getStatus() : "active");
    }

    private EmrResponse toResponse(Emr record) {
        EmrResponse r = new EmrResponse();
        r.setId(record.getId());
        r.setPatientId(record.getPatientId());
        r.setVisitId(record.getVisitId());
        r.setPrescriptionId(record.getPrescriptionId());
        r.setVisitDate(record.getVisitDate());
        r.setChiefComplaint(record.getChiefComplaint());
        r.setPresentIllness(record.getPresentIllness());
        r.setPastHistory(record.getPastHistory());
        r.setTongueImage(record.getTongueImage());
        r.setPulseImage(record.getPulseImage());
        r.setComplexion(record.getComplexion());
        r.setVoice(record.getVoice());
        r.setSyndrome(record.getSyndrome());
        r.setDiagnosis(record.getDiagnosis());
        r.setTreatmentPrinciple(record.getTreatmentPrinciple());
        r.setPrescriptionText(record.getPrescriptionText());
        r.setNotes(record.getNotes());
        r.setTreatmentResult(record.getTreatmentResult());
        r.setFollowUp(record.getFollowUp());
        r.setDoctorId(record.getDoctorId());
        r.setStatus(record.getStatus());
        r.setCreatedAt(record.getCreatedAt());
        r.setUpdatedAt(record.getUpdatedAt());
        return r;
    }
}
