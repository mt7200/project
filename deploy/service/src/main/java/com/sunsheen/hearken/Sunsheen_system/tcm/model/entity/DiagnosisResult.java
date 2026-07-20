package com.sunsheen.hearken.Sunsheen_system.tcm.model.entity;

import java.time.LocalDateTime;
import jakarta.persistence.*;

@Entity
@Table(name = "diagnosis_result")
public class DiagnosisResult {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(name = "visit_id", nullable = false)
    private Long visitId;

    @Column(name = "patient_id", nullable = false)
    private Long patientId;

    @Column(name = "doctor_id", nullable = false)
    private Long doctorId;

    @Column(name = "syndrome_pattern_id")
    private Long syndromePatternId;

    @Column(name = "pattern_name", length = 100)
    private String patternName;

    @Column(name = "pattern_code", length = 20)
    private String patternCode;

    private Integer confidence;

    @Column(length = 200)
    private String syndrome;

    @Column(length = 200)
    private String diagnosis;

    @Column(columnDefinition = "TEXT")
    private String differentiation;

    @Column(name = "treatment_principle", columnDefinition = "TEXT")
    private String treatmentPrinciple;

    @Column(name = "diagnosis_type", length = 50)
    private String diagnosisType;

    @Column(columnDefinition = "TEXT")
    private String notes;

    @Column(length = 20)
    private String status = "confirmed";

    @Column(name = "created_at")
    private LocalDateTime createdAt;

    @Column(name = "updated_at")
    private LocalDateTime updatedAt;

    public Long getId() { return id; }
    public void setId(Long id) { this.id = id; }
    public Long getVisitId() { return visitId; }
    public void setVisitId(Long visitId) { this.visitId = visitId; }
    public Long getPatientId() { return patientId; }
    public void setPatientId(Long patientId) { this.patientId = patientId; }
    public Long getDoctorId() { return doctorId; }
    public void setDoctorId(Long doctorId) { this.doctorId = doctorId; }
    public Long getSyndromePatternId() { return syndromePatternId; }
    public void setSyndromePatternId(Long syndromePatternId) { this.syndromePatternId = syndromePatternId; }
    public String getPatternName() { return patternName; }
    public void setPatternName(String patternName) { this.patternName = patternName; }
    public String getPatternCode() { return patternCode; }
    public void setPatternCode(String patternCode) { this.patternCode = patternCode; }
    public Integer getConfidence() { return confidence; }
    public void setConfidence(Integer confidence) { this.confidence = confidence; }
    public String getSyndrome() { return syndrome; }
    public void setSyndrome(String syndrome) { this.syndrome = syndrome; }
    public String getDiagnosis() { return diagnosis; }
    public void setDiagnosis(String diagnosis) { this.diagnosis = diagnosis; }
    public String getDifferentiation() { return differentiation; }
    public void setDifferentiation(String differentiation) { this.differentiation = differentiation; }
    public String getTreatmentPrinciple() { return treatmentPrinciple; }
    public void setTreatmentPrinciple(String treatmentPrinciple) { this.treatmentPrinciple = treatmentPrinciple; }
    public String getDiagnosisType() { return diagnosisType; }
    public void setDiagnosisType(String diagnosisType) { this.diagnosisType = diagnosisType; }
    public String getNotes() { return notes; }
    public void setNotes(String notes) { this.notes = notes; }
    public String getStatus() { return status; }
    public void setStatus(String status) { this.status = status; }
    public LocalDateTime getCreatedAt() { return createdAt; }
    public void setCreatedAt(LocalDateTime createdAt) { this.createdAt = createdAt; }
    public LocalDateTime getUpdatedAt() { return updatedAt; }
    public void setUpdatedAt(LocalDateTime updatedAt) { this.updatedAt = updatedAt; }
}
