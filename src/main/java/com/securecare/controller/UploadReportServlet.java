package com.securecare.controller;

import com.securecare.dao.ReportDAO;
import com.securecare.model.Report;
import com.securecare.model.User;
import com.securecare.util.EncryptionUtil;
import com.securecare.util.StegoUtil;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet("/upload_report")
public class UploadReportServlet extends HttpServlet {

    private ReportDAO reportDAO = new ReportDAO();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        User user = (User) session.getAttribute("user");
        if (!"doctor".equals(user.getRole())) {
            response.sendRedirect("login.jsp");
            return;
        }

        String patientName = request.getParameter("patientName");
        String patientEmail = request.getParameter("patientEmail");
        String secretData = request.getParameter("secretData");
        
        // Standard medical carrier text
        String carrierText = "Standard Medical Disclaimer: This document contains confidential patient information intended solely for the authorized recipient. Unauthorized disclosure or use is strictly prohibited under HIPAA regulations. Please handle with care and ensure proper disposal if printed.";

        try {
            // 1. Encrypt Data
            String encryptedData = EncryptionUtil.encrypt(secretData);
            
            // 2. Hide within Carrier
            String stegoText = StegoUtil.hideData(carrierText, encryptedData);
            
            // 3. Save to DB
            Report report = new Report();
            report.setDoctorId(user.getId());
            report.setPatientName(patientName);
            report.setPatientEmail(patientEmail);
            report.setStegoText(stegoText);
            
            if (reportDAO.saveReport(report)) {
                response.sendRedirect("doctor_dashboard.jsp?success=Report uploaded and secured successfully.");
            } else {
                response.sendRedirect("doctor_dashboard.jsp?error=Failed to process report.");
            }
            
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("doctor_dashboard.jsp?error=Encryption failed.");
        }
    }
}
