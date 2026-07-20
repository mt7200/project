package com.sunsheen.hearken.Sunsheen_system.tcm.model.dto.response;

import java.time.LocalDateTime;
import java.util.List;

public class ReviewItemResponse {
    private Long id;
    private String patientName;
    private String diagnosis;
    private String syndrome;
    private List<String> herbs;
    private String riskLevel;
    private Integer riskScore;
    private String status;
    private Boolean compatibilityRisk;
    private Boolean dosageRisk;
    private Boolean contraindicationRisk;
    private List<String> risks;
    private List<String> suggestions;
    private String reviewer;
    private LocalDateTime createdAt;
    private LocalDateTime reviewedAt;

    public Long getId() { return id; }
    public void setId(Long id) { this.id = id; }
    public String getPatientName() { return patientName; }
    public void setPatientName(String patientName) { this.patientName = patientName; }
    public String getDiagnosis() { return diagnosis; }
    public void setDiagnosis(String diagnosis) { this.diagnosis = diagnosis; }
    public String getSyndrome() { return syndrome; }
    public void setSyndrome(String syndrome) { this.syndrome = syndrome; }
    public List<String> getHerbs() { return herbs; }
    public void setHerbs(List<String> herbs) { this.herbs = herbs; }
    public String getRiskLevel() { return riskLevel; }
    public void setRiskLevel(String riskLevel) { this.riskLevel = riskLevel; }
    public Integer getRiskScore() { return riskScore; }
    public void setRiskScore(Integer riskScore) { this.riskScore = riskScore; }
    public String getStatus() { return status; }
    public void setStatus(String status) { this.status = status; }
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
    public String getReviewer() { return reviewer; }
    public void setReviewer(String reviewer) { this.reviewer = reviewer; }
    public LocalDateTime getCreatedAt() { return createdAt; }
    public void setCreatedAt(LocalDateTime createdAt) { this.createdAt = createdAt; }
    public LocalDateTime getReviewedAt() { return reviewedAt; }
    public void setReviewedAt(LocalDateTime reviewedAt) { this.reviewedAt = reviewedAt; }
}
