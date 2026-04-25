<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Register - SecureCare</title>
    <link rel="stylesheet" href="css/styles.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
</head>
<body class="cyber-bg" style="display: flex; align-items: center; justify-content: center; padding: 2rem 0;">
    
    <div class="glass-panel fade-in" style="width: 100%; max-width: 450px;">
        <div style="text-align: center; margin-bottom: 2rem;">
            <a href="index.jsp" class="brand" style="justify-content: center; margin-bottom: 1rem;">
                <i class="fa-solid fa-shield-halved" style="color: var(--accent); font-size: 2rem;"></i>
            </a>
            <h2>Create Account</h2>
            <p style="color: var(--secondary);">Join the secure medical network</p>
        </div>

        <% if (request.getAttribute("error") != null) { %>
            <div class="alert alert-error">
                <%= request.getAttribute("error") %>
            </div>
        <% } %>

        <form action="register" method="POST">
            <div class="form-group">
                <label class="form-label">Full Name</label>
                <div style="position: relative;">
                    <i class="fa-solid fa-user" style="position: absolute; left: 15px; top: 15px; color: #94A3B8;"></i>
                    <input type="text" name="name" class="form-control" style="padding-left: 45px;" required>
                </div>
            </div>

            <div class="form-group">
                <label class="form-label">Email Address</label>
                <div style="position: relative;">
                    <i class="fa-solid fa-envelope" style="position: absolute; left: 15px; top: 15px; color: #94A3B8;"></i>
                    <input type="email" name="email" class="form-control" style="padding-left: 45px;" required>
                </div>
            </div>
            
            <div class="form-group">
                <label class="form-label">Password</label>
                <div style="position: relative;">
                    <i class="fa-solid fa-lock" style="position: absolute; left: 15px; top: 15px; color: #94A3B8;"></i>
                    <input type="password" name="password" class="form-control" style="padding-left: 45px;" required>
                </div>
            </div>

            <div class="form-group">
                <label class="form-label">Account Type</label>
                <select name="role" class="form-control" required style="cursor: pointer;">
                    <option value="doctor">Doctor</option>
                    <option value="patient" <%= "patient".equals(request.getParameter("role")) ? "selected" : "" %>>Patient</option>
                </select>
            </div>

            <button type="submit" class="btn btn-primary" style="width: 100%; margin-top: 1rem;">
                Register <i class="fa-solid fa-user-plus" style="margin-left: 8px;"></i>
            </button>
        </form>
        
        <p style="text-align: center; margin-top: 1.5rem; font-size: 0.9rem;">
            Already have an account? <a href="login.jsp" style="color: var(--highlight); text-decoration: none; font-weight: 600;">Login here</a>
        </p>
    </div>

</body>
</html>
