package com.sunsheen.hearken.Sunsheen_system.tcm.model.entity;

import java.time.LocalDateTime;
import jakarta.persistence.*;

@Entity
@Table(name = "syndrome_pattern")
public class SyndromePattern {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(name = "pattern_name", nullable = false, unique = true, length = 100)
    private String patternName;

    @Column(name = "pattern_code", length = 20)
    private String patternCode;

    @Column(length = 50)
    private String category;

    @Column(length = 200)
    private String etiology;

    @Column(length = 200)
    private String pathogenesis;

    @Column(name = "key_symptoms", columnDefinition = "TEXT")
    private String keySymptoms;

    @Column(name = "pulse_pattern", length = 100)
    private String pulsePattern;

    @Column(name = "tongue_pattern", length = 100)
    private String tonguePattern;

    @Column(columnDefinition = "TEXT")
    private String differentiation;

    @Column(name = "treatment_method", length = 200)
    private String treatmentMethod;

    @Column(name = "recommended_formula", length = 100)
    private String recommendedFormula;

    @Column(name = "related_diagnosis", length = 200)
    private String relatedDiagnosis;

    @Column(name = "sort_order")
    private Integer sortOrder = 0;

    @Column(name = "created_at")
    private LocalDateTime createdAt;

    @Column(name = "updated_at")
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
