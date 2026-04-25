<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.securecare.model.User" %>
<%@ page import="com.securecare.model.Report" %>
<%@ page import="com.securecare.dao.ReportDAO" %>
<%@ page import="java.util.List" %>
<%
    User user = (User) session.getAttribute("user");
    if (user == null || !"patient".equals(user.getRole())) {
        response.sendRedirect("login.jsp");
        return;
    }
    
    ReportDAO reportDAO = new ReportDAO();
    List<Report> reports = reportDAO.getReportsByPatient(user.getEmail());
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Patient Dashboard - SecureCare</title>
    <link rel="stylesheet" href="css/styles.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
</head>
<body class="dashboard-layout fade-in">
    <style>
        .dashboard-layout {
            display: flex;
            flex-direction: row;
            min-height: 100vh;
        }
        .sidebar {
            width: 250px;
            background-color: var(--primary);
            color: #fff;
            padding: 2rem 1rem;
            display: flex;
            flex-direction: column;
            min-height: 100vh;
        }
        .main-content {
            flex: 1;
            padding: 2rem;
            height: 100vh;
            overflow-y: auto;
        }
    </style>

    <aside class="sidebar">
        <a href="#" class="brand" style="color: white; margin-bottom: 2rem;">
            <i class="fa-solid fa-shield-halved" style="color: var(--accent);"></i>
            SecureCare
        </a>
        <div style="padding-bottom: 1rem; border-bottom: 1px solid var(--surface-border); margin-bottom: 1rem;">
            <p style="font-size: 0.9rem; color: #CBD5E1;">Welcome,</p>
            <p style="font-weight: 600;"><%= user.getName() %></p>
        </div>
        <ul class="sidebar-menu">
            <li><a href="#" class="active"><i class="fa-solid fa-file-medical"></i> My Reports</a></li>
            <li style="margin-top: auto;"><a href="logout" style="color: var(--error);"><i class="fa-solid fa-arrow-right-from-bracket"></i> Logout</a></li>
        </ul>
    </aside>

    <main class="main-content">
        <header style="margin-bottom: 2rem;">
            <h2>Secure Medical Records</h2>
            <p style="color: var(--secondary);">Access your encrypted health data</p>
        </header>

        <div style="display: grid; grid-template-columns: 1fr 1fr; gap: 2rem;">
            <!-- Reports List -->
            <div class="glass-panel">
                <h3 style="margin-bottom: 1.5rem;"><i class="fa-solid fa-inbox" style="color: var(--highlight); margin-right: 8px;"></i> Received Documents</h3>
                <div style="overflow-y: auto; max-height: 500px; padding-right: 10px;">
                    <% if (reports.isEmpty()) { %>
                        <p style="color: var(--secondary); text-align: center; margin-top: 2rem;">No documents available.</p>
                    <% } else { 
                        for (Report r : reports) {
                    %>
                        <div style="padding: 1rem; border: 1px solid var(--surface-border); border-radius: 8px; margin-bottom: 1rem; background: #fff; cursor: pointer; transition: all 0.2s;" onclick="viewReport('<%= r.getId() %>')" id="card-<%= r.getId() %>" class="report-card">
                            <div style="display: flex; justify-content: space-between; margin-bottom: 0.5rem;">
                                <strong>Report #<%= r.getId() %></strong>
                                <span style="font-size: 0.8rem; color: #94A3B8;"><%= r.getCreatedAt() %></span>
                            </div>
                            <!-- Hidden stego text for JS extraction -->
                            <div id="stego-<%= r.getId() %>" style="display: none;"><%= r.getStegoText() %></div>
                            <button class="btn btn-outline" style="padding: 0.4rem 0.8rem; font-size: 0.85rem; margin-top: 0.5rem;">
                                Select & Decrypt
                            </button>
                        </div>
                    <%  }
                       } %>
                </div>
            </div>

            <!-- Decryption View -->
            <div class="glass-panel">
                <h3 style="margin-bottom: 1.5rem;"><i class="fa-solid fa-unlock-keyhole" style="color: var(--accent); margin-right: 8px;"></i> Extraction & Decryption</h3>
                
                <div id="noSelectionState" style="text-align: center; padding: 4rem 2rem; color: var(--secondary);">
                    <i class="fa-solid fa-file-shield" style="font-size: 3rem; color: #CBD5E1; margin-bottom: 1rem;"></i>
                    <p>Select a document from the left to extract its hidden contents safely.</p>
                </div>

                <div id="decryptionState" style="display: none;">
                    <div style="background: #F1F5F9; padding: 1rem; border-radius: 8px; margin-bottom: 1.5rem; font-size: 0.85rem; color: #64748B;">
                        <strong>Carrier Text:</strong> <br>
                        "Standard Medical Disclaimer: This document contains confidential patient information intended solely for the authorized recipient. Unauthorized disclosure or use is strictly prohibited under HIPAA regulations. Please handle with care and ensure proper disposal if printed."
                    </div>

                    <button id="decryptBtn" class="btn btn-primary" style="width: 100%; margin-bottom: 1.5rem;" onclick="processDecryption()">
                        Extract Steganography payload & Decrypt <i class="fa-solid fa-microchip" style="margin-left: 8px;"></i>
                    </button>

                    <div id="resultContainer" style="display: none;">
                        <h4 style="margin-bottom: 0.5rem; color: var(--accent);"><i class="fa-solid fa-circle-check"></i> Decrypted Medical Data:</h4>
                        <div id="decryptedOutput" style="padding: 1.5rem; background: #fff; border: 1px solid var(--accent); border-radius: 8px; font-family: monospace; white-space: pre-wrap; font-size: 1rem; color: #0F172A; min-height: 80px; box-shadow: inset 0 2px 4px rgba(0,0,0,0.05);">
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </main>

    <script>
        let currentStegoText = '';

        function viewReport(id) {
            // UI Updates
            document.querySelectorAll('.report-card').forEach(card => card.style.borderLeft = "1px solid var(--surface-border)");
            document.getElementById('card-' + id).style.borderLeft = "4px solid var(--highlight)";
            
            document.getElementById('noSelectionState').style.display = 'none';
            document.getElementById('decryptionState').style.display = 'block';
            document.getElementById('resultContainer').style.display = 'none';
            document.getElementById('decryptBtn').innerHTML = 'Extract Steganography payload & Decrypt <i class="fa-solid fa-microchip" style="margin-left: 8px;"></i>';
            document.getElementById('decryptBtn').disabled = false;

            currentStegoText = document.getElementById('stego-' + id).textContent;
        }

        function processDecryption() {
            const btn = document.getElementById('decryptBtn');
            btn.innerHTML = '<i class="fa-solid fa-spinner fa-spin"></i> Processing...';
            btn.disabled = true;

            const formData = new URLSearchParams();
            formData.append('stegoText', currentStegoText);

            fetch('decrypt_report', {
                method: 'POST',
                body: formData,
                headers: {
                    'Content-Type': 'application/x-www-form-urlencoded'
                }
            })
            .then(response => response.json())
            .then(data => {
                btn.innerHTML = 'Decryption Complete';
                if(data.status === 'success') {
                    document.getElementById('resultContainer').style.display = 'block';
                    document.getElementById('decryptedOutput').innerText = data.decryptedData;
                } else {
                    alert('Error: ' + data.message);
                    btn.disabled = false;
                    btn.innerHTML = 'Try Again';
                }
            })
            .catch(error => {
                console.error('Error:', error);
                alert('A network error occurred.');
                btn.disabled = false;
                btn.innerHTML = 'Try Again';
            });
        }
    </script>
</body>
</html>
