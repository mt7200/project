package com.sunsheen.hearken.Sunsheen_system.tcm.model.dto.response;

import java.time.LocalDateTime;

public class SymptomDictResponse {
    private Long id;
    private String category;
    private String subCategory;
    private String label;
    private Integer sortOrder;
    private Integer isCommon;
    private Integer weight;
    private LocalDateTime createdAt;

    public Long getId() { return id; }
    public void setId(Long id) { this.id = id; }
    public String getCategory() { return category; }
    public void setCategory(String category) { this.category = category; }
    public String getSubCategory() { return subCategory; }
    public void setSubCategory(String subCategory) { this.subCategory = subCategory; }
    public String getLabel() { return label; }
    public void setLabel(String label) { this.label = label; }
    public Integer getSortOrder() { return sortOrder; }
    public void setSortOrder(Integer sortOrder) { this.sortOrder = sortOrder; }
    public Integer getIsCommon() { return isCommon; }
    public void setIsCommon(Integer isCommon) { this.isCommon = isCommon; }
    public Integer getWeight() { return weight; }
    public void setWeight(Integer weight) { this.weight = weight; }
    public LocalDateTime getCreatedAt() { return createdAt; }
    public void setCreatedAt(LocalDateTime createdAt) { this.createdAt = createdAt; }
}
