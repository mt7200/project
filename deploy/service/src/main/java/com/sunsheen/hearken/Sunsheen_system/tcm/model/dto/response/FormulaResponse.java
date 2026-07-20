package com.sunsheen.hearken.Sunsheen_system.tcm.model.dto.response;

import java.util.List;

public class FormulaResponse {
    private Long id;
    private String name;
    private String categoryL1;
    private String categoryL2;
    private String functions;
    private String indications;
    private String modifications;
    private String source;
    private List<String> herbs;

    public Long getId() { return id; }
    public void setId(Long id) { this.id = id; }
    public String getName() { return name; }
    public void setName(String name) { this.name = name; }
    public String getCategoryL1() { return categoryL1; }
    public void setCategoryL1(String categoryL1) { this.categoryL1 = categoryL1; }
    public String getCategoryL2() { return categoryL2; }
    public void setCategoryL2(String categoryL2) { this.categoryL2 = categoryL2; }
    public String getFunctions() { return functions; }
    public void setFunctions(String functions) { this.functions = functions; }
    public String getIndications() { return indications; }
    public void setIndications(String indications) { this.indications = indications; }
    public String getModifications() { return modifications; }
    public void setModifications(String modifications) { this.modifications = modifications; }
    public String getSource() { return source; }
    public void setSource(String source) { this.source = source; }
    public List<String> getHerbs() { return herbs; }
    public void setHerbs(List<String> herbs) { this.herbs = herbs; }
}
