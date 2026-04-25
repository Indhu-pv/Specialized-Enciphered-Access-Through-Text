package com.securecare.controller;

import com.google.gson.JsonObject;
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

@WebServlet("/decrypt_report")
public class DecryptReportServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        JsonObject jsonResponse = new JsonObject();
        
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            jsonResponse.addProperty("status", "error");
            jsonResponse.addProperty("message", "Unauthorized access.");
            response.getWriter().write(jsonResponse.toString());
            return;
        }

        String stegoText = request.getParameter("stegoText");
        if (stegoText == null || stegoText.trim().isEmpty()) {
            jsonResponse.addProperty("status", "error");
            jsonResponse.addProperty("message", "No stego text provided.");
            response.getWriter().write(jsonResponse.toString());
            return;
        }

        try {
            // 1. Extract hidden encrypted text
            String encryptedData = StegoUtil.extractData(stegoText);
            
            // 2. Decrypt data
            String plainText = EncryptionUtil.decrypt(encryptedData);
            
            jsonResponse.addProperty("status", "success");
            jsonResponse.addProperty("decryptedData", plainText);
            
        } catch (Exception e) {
            e.printStackTrace();
            jsonResponse.addProperty("status", "error");
            jsonResponse.addProperty("message", "Decryption failed. The text might be tampered with.");
        }
        
        response.getWriter().write(jsonResponse.toString());
    }
}
