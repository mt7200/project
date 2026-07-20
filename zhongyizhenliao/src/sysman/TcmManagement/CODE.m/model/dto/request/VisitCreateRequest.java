package com.sunsheen.hearken.Sunsheen_system.tcm.model.dto.request;

import java.time.LocalDate;

public class VisitCreateRequest {
    private Long patientId;
    private Long doctorId;
    private LocalDate visitDate;
    private String chiefComplaint;
    private String presentIllness;
    private String pastHistory;
    private String allergyHistory;
    private String personalHistory;
    private String tongueImage;
    private String pulseImage;
    private String otherExams;

    public Long getPatientId() { return patientId; }
    public void setPatientId(Long patientId) { this.patientId = patientId; }
    public Long getDoctorId() { return doctorId; }
    public void setDoctorId(Long doctorId) { this.doctorId = doctorId; }
    public LocalDate getVisitDate() { return visitDate; }
    public void setVisitDate(LocalDate visitDate) { this.visitDate = visitDate; }
    public String getChiefComplaint() { return chiefComplaint; }
    public void setChiefComplaint(String chiefComplaint) { this.chiefComplaint = chiefComplaint; }
    public String getPresentIllness() { return presentIllness; }
    public void setPresentIllness(String presentIllness) { this.presentIllness = presentIllness; }
    public String getPastHistory() { return pastHistory; }
    public void setPastHistory(String pastHistory) { this.pastHistory = pastHistory; }
    public String getAllergyHistory() { return allergyHistory; }
    public void setAllergyHistory(String allergyHistory) { this.allergyHistory = allergyHistory; }
    public String getPersonalHistory() { return personalHistory; }
    public void setPersonalHistory(String personalHistory) { this.personalHistory = personalHistory; }
    public String getTongueImage() { return tongueImage; }
    public void setTongueImage(String tongueImage) { this.tongueImage = tongueImage; }
    public String getPulseImage() { return pulseImage; }
    public void setPulseImage(String pulseImage) { this.pulseImage = pulseImage; }
    public String getOtherExams() { return otherExams; }
    public void setOtherExams(String otherExams) { this.otherExams = otherExams; }
}
