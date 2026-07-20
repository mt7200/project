package com.sunsheen.hearken.Sunsheen_system.tcm.model.entity;

import java.time.LocalDate;
import java.time.LocalDateTime;
import jakarta.persistence.*;

@Entity
@Table(name = "emr")
public class Emr {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(name = "patient_id", nullable = false)
    private Long patientId;

    @Column(name = "visit_id")
    private Long visitId;

    @Column(name = "prescription_id")
    private Long prescriptionId;

    @Column(name = "visit_date", nullable = false)
    private LocalDate visitDate;

    @Column(name = "chief_complaint", columnDefinition = "TEXT")
    private String chiefComplaint;

    @Column(name = "present_illness", columnDefinition = "TEXT")
    private String presentIllness;

    @Column(name = "past_history", columnDefinition = "TEXT")
    private String pastHistory;

    @Column(name = "tongue_image", columnDefinition = "TEXT")
    private String tongueImage;

    @Column(name = "pulse_image", columnDefinition = "TEXT")
    private String pulseImage;

    @Column(length = 50)
    private String complexion;

    @Column(length = 50)
    private String voice;

    @Column(length = 200)
    private String syndrome;

    @Column(length = 200)
    private String diagnosis;

    @Column(name = "treatment_principle", length = 200)
    private String treatmentPrinciple;

    @Column(name = "prescription_text", columnDefinition = "TEXT")
    private String prescriptionText;

    @Column(columnDefinition = "TEXT")
    private String notes;

    @Column(name = "treatment_result", length = 20)
    private String treatmentResult;

    @Column(name = "follow_up", length = 100)
    private String followUp;

    @Column(name = "doctor_id", nullable = false)
    private Long doctorId;

    @Column(length = 20)
    private String status = "active";

    @Column(name = "created_at")
    private LocalDateTime createdAt;

    @Column(name = "updated_at")
    private LocalDateTime updatedAt;

    public Long getId() { return id; }
    public void setId(Long id) { this.id = id; }
    public Long getPatientId() { return patientId; }
    public void setPatientId(Long patientId) { this.patientId = patientId; }
    public Long getVisitId() { return visitId; }
    public void setVisitId(Long visitId) { this.visitId = visitId; }
    public Long getPrescriptionId() { return prescriptionId; }
    public void setPrescriptionId(Long prescriptionId) { this.prescriptionId = prescriptionId; }
    public LocalDate getVisitDate() { return visitDate; }
    public void setVisitDate(LocalDate visitDate) { this.visitDate = visitDate; }
    public String getChiefComplaint() { return chiefComplaint; }
    public void setChiefComplaint(String chiefComplaint) { this.chiefComplaint = chiefComplaint; }
    public String getPresentIllness() { return presentIllness; }
    public void setPresentIllness(String presentIllness) { this.presentIllness = presentIllness; }
    public String getPastHistory() { return pastHistory; }
    public void setPastHistory(String pastHistory) { this.pastHistory = pastHistory; }
    public String getTongueImage() { return tongueImage; }
    public void setTongueImage(String tongueImage) { this.tongueImage = tongueImage; }
    public String getPulseImage() { return pulseImage; }
    public void setPulseImage(String pulseImage) { this.pulseImage = pulseImage; }
    public String getComplexion() { return complexion; }
    public void setComplexion(String complexion) { this.complexion = complexion; }
    public String getVoice() { return voice; }
    public void setVoice(String voice) { this.voice = voice; }
    public String getSyndrome() { return syndrome; }
    public void setSyndrome(String syndrome) { this.syndrome = syndrome; }
    public String getDiagnosis() { return diagnosis; }
    public void setDiagnosis(String diagnosis) { this.diagnosis = diagnosis; }
    public String getTreatmentPrinciple() { return treatmentPrinciple; }
    public void setTreatmentPrinciple(String treatmentPrinciple) { this.treatmentPrinciple = treatmentPrinciple; }
    public String getPrescriptionText() { return prescriptionText; }
    public void setPrescriptionText(String prescriptionText) { this.prescriptionText = prescriptionText; }
    public String getNotes() { return notes; }
    public void setNotes(String notes) { this.notes = notes; }
    public String getTreatmentResult() { return treatmentResult; }
    public void setTreatmentResult(String treatmentResult) { this.treatmentResult = treatmentResult; }
    public String getFollowUp() { return followUp; }
    public void setFollowUp(String followUp) { this.followUp = followUp; }
    public Long getDoctorId() { return doctorId; }
    public void setDoctorId(Long doctorId) { this.doctorId = doctorId; }
    public String getStatus() { return status; }
    public void setStatus(String status) { this.status = status; }
    public LocalDateTime getCreatedAt() { return createdAt; }
    public void setCreatedAt(LocalDateTime createdAt) { this.createdAt = createdAt; }
    public LocalDateTime getUpdatedAt() { return updatedAt; }
    public void setUpdatedAt(LocalDateTime updatedAt) { this.updatedAt = updatedAt; }
}
