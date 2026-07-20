package com.sunsheen.hearken.Sunsheen_system.tcm.model.entity;

import jakarta.persistence.*;

@Entity
@Table(name = "herb_incompatibility", uniqueConstraints = {
    @UniqueConstraint(columnNames = {"herb_a_id", "herb_b_id", "type"}, name = "uk_herb_pair")
})
public class HerbIncompatibility {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(name = "herb_a_id", nullable = false)
    private Long herbAId;

    @Column(name = "herb_b_id", nullable = false)
    private Long herbBId;

    @Column(nullable = false, length = 20)
    private String type;

    @Column(length = 20)
    private String severity = "medium";

    @Column(length = 500)
    private String detail;

    public Long getId() { return id; }
    public void setId(Long id) { this.id = id; }
    public Long getHerbAId() { return herbAId; }
    public void setHerbAId(Long herbAId) { this.herbAId = herbAId; }
    public Long getHerbBId() { return herbBId; }
    public void setHerbBId(Long herbBId) { this.herbBId = herbBId; }
    public String getType() { return type; }
    public void setType(String type) { this.type = type; }
    public String getSeverity() { return severity; }
    public void setSeverity(String severity) { this.severity = severity; }
    public String getDetail() { return detail; }
    public void setDetail(String detail) { this.detail = detail; }
}
