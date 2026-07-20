package com.sunsheen.hearken.Sunsheen_system.tcm.model.entity;

import jakarta.persistence.*;

@Entity
@Table(name = "formula_herb", uniqueConstraints = {
    @UniqueConstraint(columnNames = {"formula_id", "herb_id"}, name = "uk_formula_herb")
})
public class FormulaHerb {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(name = "formula_id", nullable = false)
    private Long formulaId;

    @Column(name = "herb_id", nullable = false)
    private Long herbId;

    @Column(length = 50)
    private String dosage;

    @Column(name = "sort_order")
    private Integer sortOrder = 0;

    @Column(length = 10)
    private String unit = "g";

    @Column(name = "usage_note", length = 200)
    private String usageNote;

    public Long getId() { return id; }
    public void setId(Long id) { this.id = id; }
    public Long getFormulaId() { return formulaId; }
    public void setFormulaId(Long formulaId) { this.formulaId = formulaId; }
    public Long getHerbId() { return herbId; }
    public void setHerbId(Long herbId) { this.herbId = herbId; }
    public String getDosage() { return dosage; }
    public void setDosage(String dosage) { this.dosage = dosage; }
    public Integer getSortOrder() { return sortOrder; }
    public void setSortOrder(Integer sortOrder) { this.sortOrder = sortOrder; }
    public String getUnit() { return unit; }
    public void setUnit(String unit) { this.unit = unit; }
    public String getUsageNote() { return usageNote; }
    public void setUsageNote(String usageNote) { this.usageNote = usageNote; }
}
