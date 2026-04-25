package com.securecare.dao;

import com.securecare.model.Report;
import com.securecare.util.DBConnection;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class ReportDAO {

    public boolean saveReport(Report report) {
        String sql = "INSERT INTO reports (doctor_id, patient_email, patient_name, stego_text) VALUES (?, ?, ?, ?)";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
             
            stmt.setInt(1, report.getDoctorId());
            stmt.setString(2, report.getPatientEmail());
            stmt.setString(3, report.getPatientName());
            stmt.setString(4, report.getStegoText());
            
            return stmt.executeUpdate() > 0;
            
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    public List<Report> getReportsByDoctor(int doctorId) {
        List<Report> reports = new ArrayList<>();
        String sql = "SELECT * FROM reports WHERE doctor_id = ? ORDER BY created_at DESC";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
             
            stmt.setInt(1, doctorId);
            ResultSet rs = stmt.executeQuery();
            
            while (rs.next()) {
                Report r = new Report();
                r.setId(rs.getInt("id"));
                r.setDoctorId(rs.getInt("doctor_id"));
                r.setPatientEmail(rs.getString("patient_email"));
                r.setPatientName(rs.getString("patient_name"));
                r.setStegoText(rs.getString("stego_text"));
                r.setCreatedAt(rs.getTimestamp("created_at"));
                reports.add(r);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return reports;
    }

    public List<Report> getReportsByPatient(String patientEmail) {
        List<Report> reports = new ArrayList<>();
        String sql = "SELECT * FROM reports WHERE patient_email = ? ORDER BY created_at DESC";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
             
            stmt.setString(1, patientEmail);
            ResultSet rs = stmt.executeQuery();
            
            while (rs.next()) {
                Report r = new Report();
                r.setId(rs.getInt("id"));
                r.setDoctorId(rs.getInt("doctor_id"));
                r.setPatientEmail(rs.getString("patient_email"));
                r.setPatientName(rs.getString("patient_name"));
                r.setStegoText(rs.getString("stego_text"));
                r.setCreatedAt(rs.getTimestamp("created_at"));
                reports.add(r);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return reports;
    }
}
