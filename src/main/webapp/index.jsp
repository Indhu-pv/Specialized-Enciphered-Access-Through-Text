<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>SecureCare Medical System</title>
    <link rel="stylesheet" href="css/styles.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
</head>
<body class="cyber-bg">
    <div class="container fade-in">
        <nav class="navbar glass-panel" style="margin-top: 1rem; border-radius: 50px; padding: 1rem 2rem;">
            <a href="index.jsp" class="brand">
                <i class="fa-solid fa-shield-halved" style="color: var(--accent);"></i>
                SecureCare
            </a>
            <div style="display: flex; gap: 1rem;">
                <a href="login.jsp" class="btn btn-outline">Login</a>
                <a href="register.jsp" class="btn btn-primary">Register</a>
            </div>
        </nav>

        <main style="display: flex; flex-direction: column; align-items: center; justify-content: center; min-height: 70vh; text-align: center; margin-top: 2rem;" class="slide-up">
            <h1 style="font-size: 3.5rem; margin-bottom: 1rem; max-width: 800px; line-height: 1.2;">
                Specialized Enciphered Access Through <span style="color: var(--highlight);">Text Steganography</span>
            </h1>
            <p style="font-size: 1.2rem; color: var(--secondary); max-width: 600px; margin-bottom: 2rem;">
                Securely store and share sensitive medical data globally using ultra-secure AES-128 encryption embedded invisibly into innocuous medical text.
            </p>
            <div style="display: flex; gap: 1rem;">
                <a href="register.jsp?role=doctor" class="btn btn-primary btn-lg" style="padding: 1rem 2rem; font-size: 1.1rem;">
                    I am a Doctor <i class="fa-solid fa-user-doctor" style="margin-left: 10px;"></i>
                </a>
                <a href="register.jsp?role=patient" class="btn btn-accent btn-lg" style="padding: 1rem 2rem; font-size: 1.1rem;">
                    I am a Patient <i class="fa-solid fa-bed-pulse" style="margin-left: 10px;"></i>
                </a>
            </div>
        </main>
        
        <section class="card-grid" style="margin-top: 3rem;">
            <div class="glass-panel slide-up" style="animation-delay: 0.2s;">
                <i class="fa-solid fa-lock" style="font-size: 2rem; color: var(--highlight); margin-bottom: 1rem;"></i>
                <h3>AES-128 Encryption</h3>
                <p style="color: var(--secondary); margin-top: 0.5rem;">Military-grade encryption ensures records are mathematically unreadable by third parties.</p>
            </div>
            <div class="glass-panel slide-up" style="animation-delay: 0.4s;">
                <i class="fa-solid fa-eye-slash" style="font-size: 2rem; color: var(--accent); margin-bottom: 1rem;"></i>
                <h3>Zero-Width Steganography</h3>
                <p style="color: var(--secondary); margin-top: 0.5rem;">The encrypted data is hidden within harmless carrier text padding using invisible characters, masking its very existence.</p>
            </div>
            <div class="glass-panel slide-up" style="animation-delay: 0.6s;">
                <i class="fa-solid fa-hospital-user" style="font-size: 2rem; color: var(--highlight); margin-bottom: 1rem;"></i>
                <h3>Role-Based Access</h3>
                <p style="color: var(--secondary); margin-top: 0.5rem;">Strict logical boundaries between Doctors and Patients ensure HIPPA compliancy workflows.</p>
            </div>
        </section>
    </div>
</body>
</html>
