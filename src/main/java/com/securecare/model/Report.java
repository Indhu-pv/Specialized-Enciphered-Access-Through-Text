package com.securecare.model;

import java.sql.Timestamp;

public class Report {
    private int id;
    private int doctorId;
    private String patientEmail;
    private String patientName;
    private String stegoText;
    private Timestamp createdAt;

    public Report() {}

    public Report(int id, int doctorId, String patientEmail, String patientName, String stegoText, Timestamp createdAt) {
        this.id = id;
        this.doctorId = doctorId;
        this.patientEmail = patientEmail;
        this.patientName = patientName;
        this.stegoText = stegoText;
        this.createdAt = createdAt;
    }

    public int getId() { return id; }
    public void setId(int id) { this.id = id; }
    public int getDoctorId() { return doctorId; }
    public void setDoctorId(int doctorId) { this.doctorId = doctorId; }
    public String getPatientEmail() { return patientEmail; }
    public void setPatientEmail(String patientEmail) { this.patientEmail = patientEmail; }
    public String getPatientName() { return patientName; }
    public void setPatientName(String patientName) { this.patientName = patientName; }
    public String getStegoText() { return stegoText; }
    public void setStegoText(String stegoText) { this.stegoText = stegoText; }
    public Timestamp getCreatedAt() { return createdAt; }
    public void setCreatedAt(Timestamp createdAt) { this.createdAt = createdAt; }
}
