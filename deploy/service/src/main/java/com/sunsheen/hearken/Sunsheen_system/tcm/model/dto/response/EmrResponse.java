package com.sunsheen.hearken.Sunsheen_system.tcm.model.dto.response;

import java.time.LocalDate;
import java.time.LocalDateTime;

public class EmrResponse {
    private Long id;
    private Long patientId;
    private Long visitId;
    private Long prescriptionId;
    private LocalDate visitDate;
    private String chiefComplaint;
    private String presentIllness;
    private String pastHistory;
    private String tongueImage;
    private String pulseImage;
    private String complexion;
    private String voice;
    private String syndrome;
    private String diagnosis;
    private String treatmentPrinciple;
    private String prescriptionText;
    private String notes;
    private String treatmentResult;
    private String followUp;
    private Long doctorId;
    private String status;
    private LocalDateTime createdAt;
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
