package com.sunsheen.hearken.Sunsheen_system.tcm.model.dto.response;

import java.time.LocalDateTime;

public class SyndromePatternResponse {
    private Long id;
    private String patternName;
    private String patternCode;
    private String category;
    private String etiology;
    private String pathogenesis;
    private String keySymptoms;
    private String pulsePattern;
    private String tonguePattern;
    private String differentiation;
    private String treatmentMethod;
    private String recommendedFormula;
    private String relatedDiagnosis;
    private Integer sortOrder;
    private LocalDateTime createdAt;
    private LocalDateTime updatedAt;

    public Long getId() { return id; }
    public void setId(Long id) { this.id = id; }
    public String getPatternName() { return patternName; }
    public void setPatternName(String patternName) { this.patternName = patternName; }
    public String getPatternCode() { return patternCode; }
    public void setPatternCode(String patternCode) { this.patternCode = patternCode; }
    public String getCategory() { return category; }
    public void setCategory(String category) { this.category = category; }
    public String getEtiology() { return etiology; }
    public void setEtiology(String etiology) { this.etiology = etiology; }
    public String getPathogenesis() { return pathogenesis; }
    public void setPathogenesis(String pathogenesis) { this.pathogenesis = pathogenesis; }
    public String getKeySymptoms() { return keySymptoms; }
    public void setKeySymptoms(String keySymptoms) { this.keySymptoms = keySymptoms; }
    public String getPulsePattern() { return pulsePattern; }
    public void setPulsePattern(String pulsePattern) { this.pulsePattern = pulsePattern; }
    public String getTonguePattern() { return tonguePattern; }
    public void setTonguePattern(String tonguePattern) { this.tonguePattern = tonguePattern; }
    public String getDifferentiation() { return differentiation; }
    public void setDifferentiation(String differentiation) { this.differentiation = differentiation; }
    public String getTreatmentMethod() { return treatmentMethod; }
    public void setTreatmentMethod(String treatmentMethod) { this.treatmentMethod = treatmentMethod; }
    public String getRecommendedFormula() { return recommendedFormula; }
    public void setRecommendedFormula(String recommendedFormula) { this.recommendedFormula = recommendedFormula; }
    public String getRelatedDiagnosis() { return relatedDiagnosis; }
    public void setRelatedDiagnosis(String relatedDiagnosis) { this.relatedDiagnosis = relatedDiagnosis; }
    public Integer getSortOrder() { return sortOrder; }
    public void setSortOrder(Integer sortOrder) { this.sortOrder = sortOrder; }
    public LocalDateTime getCreatedAt() { return createdAt; }
    public void setCreatedAt(LocalDateTime createdAt) { this.createdAt = createdAt; }
    public LocalDateTime getUpdatedAt() { return updatedAt; }
    public void setUpdatedAt(LocalDateTime updatedAt) { this.updatedAt = updatedAt; }
}
