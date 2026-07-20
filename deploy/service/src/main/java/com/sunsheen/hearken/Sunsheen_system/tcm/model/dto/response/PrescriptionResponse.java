package com.sunsheen.hearken.Sunsheen_system.tcm.model.dto.response;

import java.time.LocalDateTime;
import java.util.List;

public class PrescriptionResponse {
    private Long id;
    private String prescriptionNo;
    private Long patientId;
    private Long doctorId;
    private Long visitId;
    private Long formulaId;
    private String diagnosis;
    private String syndrome;
    private String status;
    private String riskLevel = "low";
    private Integer riskScore = 0;
    private Boolean compatibilityRisk = false;
    private Boolean dosageRisk = false;
    private Boolean contraindicationRisk = false;
    private List<String> risks;
    private List<String> suggestions;
    private String notes;
    private String reviewer;
    private LocalDateTime createdAt;
    private LocalDateTime reviewedAt;

    public Long getId() { return id; }
    public void setId(Long id) { this.id = id; }
    public String getPrescriptionNo() { return prescriptionNo; }
    public void setPrescriptionNo(String prescriptionNo) { this.prescriptionNo = prescriptionNo; }
    public Long getPatientId() { return patientId; }
    public void setPatientId(Long patientId) { this.patientId = patientId; }
    public Long getDoctorId() { return doctorId; }
    public void setDoctorId(Long doctorId) { this.doctorId = doctorId; }
    public Long getVisitId() { return visitId; }
    public void setVisitId(Long visitId) { this.visitId = visitId; }
    public Long getFormulaId() { return formulaId; }
    public void setFormulaId(Long formulaId) { this.formulaId = formulaId; }
    public String getDiagnosis() { return diagnosis; }
    public void setDiagnosis(String diagnosis) { this.diagnosis = diagnosis; }
    public String getSyndrome() { return syndrome; }
    public void setSyndrome(String syndrome) { this.syndrome = syndrome; }
    public String getStatus() { return status; }
    public void setStatus(String status) { this.status = status; }
    public String getRiskLevel() { return riskLevel; }
    public void setRiskLevel(String riskLevel) { this.riskLevel = riskLevel; }
    public Integer getRiskScore() { return riskScore; }
    public void setRiskScore(Integer riskScore) { this.riskScore = riskScore; }
    public Boolean getCompatibilityRisk() { return compatibilityRisk; }
    public void setCompatibilityRisk(Boolean compatibilityRisk) { this.compatibilityRisk = compatibilityRisk; }
    public Boolean getDosageRisk() { return dosageRisk; }
    public void setDosageRisk(Boolean dosageRisk) { this.dosageRisk = dosageRisk; }
    public Boolean getContraindicationRisk() { return contraindicationRisk; }
    public void setContraindicationRisk(Boolean contraindicationRisk) { this.contraindicationRisk = contraindicationRisk; }
    public List<String> getRisks() { return risks; }
    public void setRisks(List<String> risks) { this.risks = risks; }
    public List<String> getSuggestions() { return suggestions; }
    public void setSuggestions(List<String> suggestions) { this.suggestions = suggestions; }
    public String getNotes() { return notes; }
    public void setNotes(String notes) { this.notes = notes; }
    public String getReviewer() { return reviewer; }
    public void setReviewer(String reviewer) { this.reviewer = reviewer; }
    public LocalDateTime getCreatedAt() { return createdAt; }
    public void setCreatedAt(LocalDateTime createdAt) { this.createdAt = createdAt; }
    public LocalDateTime getReviewedAt() { return reviewedAt; }
    public void setReviewedAt(LocalDateTime reviewedAt) { this.reviewedAt = reviewedAt; }
}
