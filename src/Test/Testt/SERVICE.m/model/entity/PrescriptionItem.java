package com.sunsheen.hearken.Sunsheen_system.tcm.model.entity;

import java.math.BigDecimal;
import jakarta.persistence.*;

@Entity
@Table(name = "prescription_item")
public class PrescriptionItem {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(name = "prescription_id", nullable = false)
    private Long prescriptionId;

    @Column(name = "herb_id", nullable = false)
    private Long herbId;

    @Column(name = "herb_name", nullable = false, length = 50)
    private String herbName;

    @Column(precision = 5, scale = 1)
    private BigDecimal dosage;

    @Column(length = 5)
    private String unit = "g";

    @Column(name = "sort_order")
    private Integer sortOrder = 0;

    public Long getId() { return id; }
    public void setId(Long id) { this.id = id; }
    public Long getPrescriptionId() { return prescriptionId; }
    public void setPrescriptionId(Long prescriptionId) { this.prescriptionId = prescriptionId; }
    public Long getHerbId() { return herbId; }
    public void setHerbId(Long herbId) { this.herbId = herbId; }
    public String getHerbName() { return herbName; }
    public void setHerbName(String herbName) { this.herbName = herbName; }
    public BigDecimal getDosage() { return dosage; }
    public void setDosage(BigDecimal dosage) { this.dosage = dosage; }
    public String getUnit() { return unit; }
    public void setUnit(String unit) { this.unit = unit; }
    public Integer getSortOrder() { return sortOrder; }
    public void setSortOrder(Integer sortOrder) { this.sortOrder = sortOrder; }
}
