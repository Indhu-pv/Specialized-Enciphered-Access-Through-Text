package com.securecare.controller;

import com.securecare.dao.UserDAO;
import com.securecare.model.User;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet("/login")
public class LoginServlet extends HttpServlet {

    private UserDAO userDAO = new UserDAO();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String role = request.getParameter("role");

        User user = userDAO.authenticateUser(email, password);

        if (user != null && user.getRole().equals(role)) {
            HttpSession session = request.getSession();
            session.setAttribute("user", user);
            
            if ("doctor".equals(role)) {
                response.sendRedirect("doctor_dashboard.jsp");
            } else {
                response.sendRedirect("patient_dashboard.jsp");
            }
        } else {
            request.setAttribute("error", "Invalid credentials or incorrect role.");
            request.getRequestDispatcher("login.jsp").forward(request, response);
        }
    }
}
