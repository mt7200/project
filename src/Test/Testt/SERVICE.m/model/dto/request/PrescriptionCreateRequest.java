package com.sunsheen.hearken.Sunsheen_system.tcm.model.dto.request;

import java.math.BigDecimal;
import java.util.List;

public class PrescriptionCreateRequest {
    private Long patientId;
    private Long doctorId;
    private Long visitId;
    private Long formulaId;
    private String diagnosis;
    private String syndrome;
    private String notes;
    private List<PrescriptionItemRequest> items;

    public Long getPatientId() { return patientId; }
    public void setPatientId(Long patientId) { this.patientId = patientId; }
    public Long getDoctorId() { return doctorId; }
    public void setDoctorId(Long doctorId) { this.doctorId = doctorId; }
    public Long getVisitId() { return visitId; }
    public void setVisitId(Long visitId) { this.visitId = visitId; }
    public Long getFormulaId() { return formulaId; }
    public void setFormulaId(Long formulaId) { this.formulaId = formulaId; }
    public String getDiagnosis() { return diagnosis; }
    public void setDiagnosis(String diagnosis) { this.diagnosis = diagnosis; }
    public String getSyndrome() { return syndrome; }
    public void setSyndrome(String syndrome) { this.syndrome = syndrome; }
    public String getNotes() { return notes; }
    public void setNotes(String notes) { this.notes = notes; }
    public List<PrescriptionItemRequest> getItems() { return items; }
    public void setItems(List<PrescriptionItemRequest> items) { this.items = items; }

    public static class PrescriptionItemRequest {
        private Long herbId;
        private BigDecimal dosage;
        private String unit = "g";

        public Long getHerbId() { return herbId; }
        public void setHerbId(Long herbId) { this.herbId = herbId; }
        public BigDecimal getDosage() { return dosage; }
        public void setDosage(BigDecimal dosage) { this.dosage = dosage; }
        public String getUnit() { return unit; }
        public void setUnit(String unit) { this.unit = unit; }
    }
}
