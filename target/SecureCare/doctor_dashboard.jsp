<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.securecare.model.User" %>
<%@ page import="com.securecare.model.Report" %>
<%@ page import="com.securecare.dao.ReportDAO" %>
<%@ page import="java.util.List" %>
<%
    User user = (User) session.getAttribute("user");
    if (user == null || !"doctor".equals(user.getRole())) {
        response.sendRedirect("login.jsp");
        return;
    }
    
    ReportDAO reportDAO = new ReportDAO();
    List<Report> reports = reportDAO.getReportsByDoctor(user.getId());
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Doctor Dashboard - SecureCare</title>
    <link rel="stylesheet" href="css/styles.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
</head>
<body class="dashboard-layout fade-in">

    <aside class="sidebar">
        <a href="#" class="brand" style="color: white; margin-bottom: 2rem;">
            <i class="fa-solid fa-shield-halved" style="color: var(--accent);"></i>
            SecureCare
        </a>
        <div style="padding-bottom: 1rem; border-bottom: 1px solid var(--surface-border); margin-bottom: 1rem;">
            <p style="font-size: 0.9rem; color: #CBD5E1;">Welcome, Dr.</p>
            <p style="font-weight: 600;"><%= user.getName() %></p>
        </div>
        <ul class="sidebar-menu">
            <li><a href="#" class="active"><i class="fa-solid fa-chart-line"></i> Dashboard</a></li>
            <li><a href="#uploadSection"><i class="fa-solid fa-upload"></i> Upload Report</a></li>
            <li style="margin-top: auto;"><a href="logout" style="color: var(--error);"><i class="fa-solid fa-arrow-right-from-bracket"></i> Logout</a></li>
        </ul>
    </aside>

    <main class="main-content">
        <header style="display: flex; justify-content: space-between; align-items: center; margin-bottom: 2rem;">
            <h2>Overview</h2>
        </header>

        <% if (request.getParameter("success") != null) { %>
            <div class="alert alert-success"><%= request.getParameter("success") %></div>
        <% } %>
        <% if (request.getParameter("error") != null) { %>
            <div class="alert alert-error"><%= request.getParameter("error") %></div>
        <% } %>

        <div class="card-grid">
            <div class="stat-card">
                <div class="stat-icon"><i class="fa-solid fa-file-shield"></i></div>
                <div>
                    <h3 style="font-size: 1.5rem; margin-bottom: 0.25rem;"><%= reports.size() %></h3>
                    <p style="color: var(--secondary); font-size: 0.9rem;">Secured Reports</p>
                </div>
            </div>
            <div class="stat-card" style="border-left-color: var(--accent);">
                <div class="stat-icon" style="background-color: rgba(34,197,94,0.1); color: var(--accent);"><i class="fa-solid fa-lock"></i></div>
                <div>
                    <h3 style="font-size: 1.5rem; margin-bottom: 0.25rem;">Active</h3>
                    <p style="color: var(--secondary); font-size: 0.9rem;">AES-128 Encryption</p>
                </div>
            </div>
        </div>

        <div style="display: grid; grid-template-columns: 1fr 1fr; gap: 2rem;">
            <!-- Upload Section -->
            <div class="glass-panel" id="uploadSection">
                <h3 style="margin-bottom: 1.5rem;"><i class="fa-solid fa-cloud-arrow-up" style="color: var(--highlight); margin-right: 8px;"></i> Upload Secure Report</h3>
                <form action="upload_report" method="POST">
                    <div class="form-group">
                        <label class="form-label">Patient Name</label>
                        <input type="text" name="patientName" class="form-control" required>
                    </div>
                    <div class="form-group">
                        <label class="form-label">Patient Email</label>
                        <input type="email" name="patientEmail" class="form-control" required>
                    </div>
                    <div class="form-group">
                        <label class="form-label">Confidential Medical Data</label>
                        <textarea name="secretData" class="form-control" rows="5" required placeholder="Enter diagnoses, prescriptions, or sensitive remarks here. It will be encrypted and hidden."></textarea>
                    </div>
                    <button type="submit" class="btn btn-primary" style="width: 100%;">
                        Encrypt & Secure Data <i class="fa-solid fa-lock" style="margin-left: 8px;"></i>
                    </button>
                </form>
            </div>

            <!-- Recent Reports -->
            <div class="glass-panel">
                <h3 style="margin-bottom: 1.5rem;"><i class="fa-solid fa-clock-rotate-left" style="color: var(--highlight); margin-right: 8px;"></i> Recent Securings</h3>
                <div style="overflow-y: auto; max-height: 400px; padding-right: 10px;">
                    <% if (reports.isEmpty()) { %>
                        <p style="color: var(--secondary); text-align: center; margin-top: 2rem;">No reports uploaded yet.</p>
                    <% } else { 
                        for (Report r : reports) {
                    %>
                        <div style="padding: 1rem; border: 1px solid var(--surface-border); border-radius: 8px; margin-bottom: 1rem; background: #fff;">
                            <div style="display: flex; justify-content: space-between; margin-bottom: 0.5rem;">
                                <strong><%= r.getPatientName() %></strong>
                                <span style="font-size: 0.8rem; color: #94A3B8;"><%= r.getCreatedAt() %></span>
                            </div>
                            <p style="font-size: 0.85rem; color: var(--secondary);"><%= r.getPatientEmail() %></p>
                            <div style="margin-top: 0.8rem; font-size: 0.8rem; padding: 0.5rem; background: #F1F5F9; border-radius: 4px; border-left: 2px solid var(--accent);">
                                Carrier text securely injected with AES payload.
                            </div>
                        </div>
                    <%  }
                       } %>
                </div>
            </div>
        </div>
    </main>
</body>
</html>
