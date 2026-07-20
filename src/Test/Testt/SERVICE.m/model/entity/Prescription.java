package com.sunsheen.hearken.Sunsheen_system.tcm.model.entity;

import java.time.LocalDateTime;
import jakarta.persistence.*;

@Entity
@Table(name = "prescription")
public class Prescription {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(name = "prescription_no", length = 50, unique = true)
    private String prescriptionNo;

    @Column(name = "patient_id", nullable = false)
    private Long patientId;

    @Column(name = "visit_id")
    private Long visitId;

    @Column(name = "doctor_id", nullable = false)
    private Long doctorId;

    @Column(name = "formula_id")
    private Long formulaId;

    @Column(length = 200)
    private String diagnosis;

    @Column(length = 200)
    private String syndrome;

    @Column(columnDefinition = "TEXT")
    private String notes;

    @Column(length = 20)
    private String status = "draft";

    @Column(name = "created_at")
    private LocalDateTime createdAt;

    @Column(name = "updated_at")
    private LocalDateTime updatedAt;

    public Long getId() { return id; }
    public void setId(Long id) { this.id = id; }
    public String getPrescriptionNo() { return prescriptionNo; }
    public void setPrescriptionNo(String prescriptionNo) { this.prescriptionNo = prescriptionNo; }
    public Long getPatientId() { return patientId; }
    public void setPatientId(Long patientId) { this.patientId = patientId; }
    public Long getVisitId() { return visitId; }
    public void setVisitId(Long visitId) { this.visitId = visitId; }
    public Long getDoctorId() { return doctorId; }
    public void setDoctorId(Long doctorId) { this.doctorId = doctorId; }
    public Long getFormulaId() { return formulaId; }
    public void setFormulaId(Long formulaId) { this.formulaId = formulaId; }
    public String getDiagnosis() { return diagnosis; }
    public void setDiagnosis(String diagnosis) { this.diagnosis = diagnosis; }
    public String getSyndrome() { return syndrome; }
    public void setSyndrome(String syndrome) { this.syndrome = syndrome; }
    public String getNotes() { return notes; }
    public void setNotes(String notes) { this.notes = notes; }
    public String getStatus() { return status; }
    public void setStatus(String status) { this.status = status; }
    public LocalDateTime getCreatedAt() { return createdAt; }
    public void setCreatedAt(LocalDateTime createdAt) { this.createdAt = createdAt; }
    public LocalDateTime getUpdatedAt() { return updatedAt; }
    public void setUpdatedAt(LocalDateTime updatedAt) { this.updatedAt = updatedAt; }
}
