package com.sunsheen.hearken.Sunsheen_system.tcm.model.dto.response;

import java.math.BigDecimal;

public class HerbResponse {
    private Long id;
    private String name;
    private String category;
    private String nature;
    private String taste;
    private String meridian;
    private BigDecimal minDosage;
    private BigDecimal maxDosage;
    private String unit = "g";
    private Boolean isToxic = false;
    private String functions;
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
    public Boolean getIsToxic() { return isToxic; }
    public void setIsToxic(Boolean isToxic) { this.isToxic = isToxic; }
    public String getFunctions() { return functions; }
    public void setFunctions(String functions) { this.functions = functions; }
    public String getIndications() { return indications; }
    public void setIndications(String indications) { this.indications = indications; }
}
