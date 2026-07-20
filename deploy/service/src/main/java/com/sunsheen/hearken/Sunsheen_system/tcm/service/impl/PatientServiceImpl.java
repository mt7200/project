package com.sunsheen.hearken.Sunsheen_system.tcm.service.impl;

import com.sunsheen.hearken.Sunsheen_system.tcm.model.dto.request.PatientCreateRequest;
import com.sunsheen.hearken.Sunsheen_system.tcm.model.dto.request.PatientUpdateRequest;
import com.sunsheen.hearken.Sunsheen_system.tcm.model.dto.response.PatientResponse;
import com.sunsheen.hearken.Sunsheen_system.tcm.model.entity.Patient;
import com.sunsheen.hearken.Sunsheen_system.tcm.repository.PatientRepository;
import com.sunsheen.hearken.Sunsheen_system.tcm.service.PatientService;
import org.springframework.data.domain.PageRequest;
import org.springframework.stereotype.Service;

import java.time.LocalDateTime;
import java.util.List;

@Service
public class PatientServiceImpl implements PatientService {

    private final PatientRepository patientRepository;

    public PatientServiceImpl(PatientRepository patientRepository) {
        this.patientRepository = patientRepository;
    }

    @Override
    public List<PatientResponse> listPatients(int skip, int limit) {
        return patientRepository.findAll(PageRequest.of(skip / limit, limit))
                .stream().map(this::toResponse).toList();
    }

    @Override
    public PatientResponse getPatient(Long id) {
        Patient patient = patientRepository.findById(id)
                .orElseThrow(() -> new RuntimeException("患者不存在"));
        return toResponse(patient);
    }

    @Override
    public PatientResponse createPatient(PatientCreateRequest request) {
        Patient patient = new Patient();
        patient.setName(request.getName());
        patient.setGender(request.getGender());
        patient.setAge(request.getAge());
        patient.setPhone(request.getPhone());
        patient.setIdCard(request.getIdCard());
        patient.setAddress(request.getAddress());
        patient.setBloodType(request.getBloodType());
        patient.setHeight(request.getHeight());
        patient.setWeight(request.getWeight());
        patient.setAllergyInfo(request.getAllergyInfo());
        patient.setStatus(request.getStatus());
        patient.setCreatedAt(LocalDateTime.now());
        patient.setUpdatedAt(LocalDateTime.now());
        patient = patientRepository.save(patient);
        return toResponse(patient);
    }

    @Override
    public PatientResponse updatePatient(Long id, PatientUpdateRequest request) {
        Patient patient = patientRepository.findById(id)
                .orElseThrow(() -> new RuntimeException("患者不存在"));
        if (request.getName() != null) patient.setName(request.getName());
        if (request.getGender() != null) patient.setGender(request.getGender());
        if (request.getAge() != null) patient.setAge(request.getAge());
        if (request.getPhone() != null) patient.setPhone(request.getPhone());
        if (request.getAddress() != null) patient.setAddress(request.getAddress());
        if (request.getAllergyInfo() != null) patient.setAllergyInfo(request.getAllergyInfo());
        if (request.getStatus() != null) patient.setStatus(request.getStatus());
        patient.setUpdatedAt(LocalDateTime.now());
        patient = patientRepository.save(patient);
        return toResponse(patient);
    }

    @Override
    public void deletePatient(Long id) {
        if (!patientRepository.existsById(id)) {
            throw new RuntimeException("患者不存在");
        }
        patientRepository.deleteById(id);
    }

    private PatientResponse toResponse(Patient patient) {
        PatientResponse r = new PatientResponse();
        r.setId(patient.getId());
        r.setName(patient.getName());
        r.setGender(patient.getGender());
        r.setAge(patient.getAge());
        r.setPhone(patient.getPhone());
        r.setIdCard(patient.getIdCard());
        r.setAddress(patient.getAddress());
        r.setBloodType(patient.getBloodType());
        r.setHeight(patient.getHeight());
        r.setWeight(patient.getWeight());
        r.setAllergyInfo(patient.getAllergyInfo());
        r.setStatus(patient.getStatus());
        r.setCreatedBy(patient.getCreatedBy());
        r.setCreatedAt(patient.getCreatedAt());
        r.setUpdatedAt(patient.getUpdatedAt());
        return r;
    }
}
