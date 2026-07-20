package com.sunsheen.hearken.Sunsheen_system.tcm.model.entity;

import java.math.BigDecimal;
import jakarta.persistence.*;

@Entity
@Table(name = "herb")
public class Herb {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(nullable = false, unique = true, length = 50)
    private String name;

    @Column(nullable = false, length = 50)
    private String category;

    @Column(length = 20)
    private String nature;

    @Column(length = 20)
    private String taste;

    @Column(length = 100)
    private String meridian;

    @Column(name = "min_dosage", precision = 5, scale = 1)
    private BigDecimal minDosage;

    @Column(name = "max_dosage", precision = 5, scale = 1)
    private BigDecimal maxDosage;

    @Column(length = 5)
    private String unit = "g";

    @Column(name = "is_toxic")
    private Integer isToxic = 0;

    @Column(columnDefinition = "TEXT")
    private String functions;

    @Column(columnDefinition = "TEXT")
    private String indications;

    public Long getId() { return id; }
    public void setId(Long id) { this.id = id; }
    public String getName() { return name; }
    public void setName(String name) { this.name = name; }
    public String getCategory() { return category; }
    public void setCategory(String category) { this.category = category; }
    public String getNature() { return nature; }
    public void setNature(String nature) { this.nature = nature; }
    public String getTaste() { return taste; }
    public void setTaste(String taste) { this.taste = taste; }
    public String getMeridian() { return meridian; }
    public void setMeridian(String meridian) { this.meridian = meridian; }
    public BigDecimal getMinDosage() { return minDosage; }
    public void setMinDosage(BigDecimal minDosage) { this.minDosage = minDosage; }
    public BigDecimal getMaxDosage() { return maxDosage; }
    public void setMaxDosage(BigDecimal maxDosage) { this.maxDosage = maxDosage; }
    public String getUnit() { return unit; }
    public void setUnit(String unit) { this.unit = unit; }
    public Integer getIsToxic() { return isToxic; }
    public void setIsToxic(Integer isToxic) { this.isToxic = isToxic; }
    public String getFunctions() { return functions; }
    public void setFunctions(String functions) { this.functions = functions; }
    public String getIndications() { return indications; }
    public void setIndications(String indications) { this.indications = indications; }
}
