package com.video.servlet;

import com.video.service.UserService;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.logging.Logger;

@WebServlet("/SignupServlet")
public class SignupServlet extends HttpServlet {
    private static final Logger LOGGER = Logger.getLogger(SignupServlet.class.getName());
    private UserService userService;

    @Override
    public void init() throws ServletException {
        userService = new UserService();
        LOGGER.info("SignupServlet initialized");
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.getRequestDispatcher("/login.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String username = req.getParameter("username");
        String email = req.getParameter("email");
        String password = req.getParameter("password");
        String confirmPassword = req.getParameter("confirmPassword");
        String role = req.getParameter("role");

        LOGGER.info("Signup attempt for email: " + email);

        try {
            // Input validation
            if (username == null || username.trim().isEmpty() ||
                email == null || email.trim().isEmpty() ||
                password == null || password.trim().isEmpty() ||
                confirmPassword == null || confirmPassword.trim().isEmpty() ||
                role == null || (!role.equals("normal") && !role.equals("creator"))) {
                LOGGER.warning("Invalid signup data for email: " + email);
                req.setAttribute("error", "All fields are required, and role must be 'normal' or 'creator'.");
                req.getRequestDispatcher("/login.jsp").forward(req, resp);
                return;
            }

            // Validate email format
            if (!email.matches("^[^\\s@]+@[^\\s@]+\\.[^\\s@]+$")) {
                LOGGER.warning("Invalid email format for email: " + email);
                req.setAttribute("error", "Please enter a valid email address.");
                req.getRequestDispatcher("/login.jsp").forward(req, resp);
                return;
            }

            // Validate password match
            if (!password.equals(confirmPassword)) {
                LOGGER.warning("Password mismatch for email: " + email);
                req.setAttribute("error", "Passwords do not match.");
                req.getRequestDispatcher("/login.jsp").forward(req, resp);
                return;
            }

            // Validate password length
            if (password.length() < 8) {
                LOGGER.warning("Password too short for email: " + email);
                req.setAttribute("error", "Password must be at least 8 characters long.");
                req.getRequestDispatcher("/login.jsp").forward(req, resp);
                return;
            }

            // Register user
            boolean registered = userService.registerUser(username, email, password, role);
            if (registered) {
                LOGGER.info("Signup successful for user: " + username);
                req.setAttribute("success", "Signup successful! Please sign in.");
                resp.sendRedirect(req.getContextPath() + "/SignInServlet");
            } else {
                LOGGER.warning("Signup failed for email: " + email);
                req.setAttribute("error", "Signup failed. Please try again.");
                req.getRequestDispatcher("/login.jsp").forward(req, resp);
            }
        } catch (Exception e) {
            LOGGER.severe("Error in signup: " + e.getMessage());
            if (e.getMessage().contains("Duplicate entry") && e.getMessage().contains("for key 'email'")) {
                req.setAttribute("error", "Email already exists. Please use a different email.");
            } else {
                req.setAttribute("error", "An error occurred during signup. Please try again.");
            }
            req.getRequestDispatcher("/login.jsp").forward(req, resp);
        }
    }
}