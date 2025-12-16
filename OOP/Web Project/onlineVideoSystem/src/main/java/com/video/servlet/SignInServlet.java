package com.video.servlet;

import com.video.model.User;
import com.video.service.UserService;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.logging.Logger;

@WebServlet("/SignInServlet")
public class SignInServlet extends HttpServlet {
    private static final Logger LOGGER = Logger.getLogger(SignInServlet.class.getName());
    private UserService userService;

    @Override
    public void init() throws ServletException {
        userService = new UserService();
        LOGGER.info("SignInServlet initialized");
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.getRequestDispatcher("/login.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String email = req.getParameter("email");
        String password = req.getParameter("password");
        LOGGER.info("Sign-in attempt for email: " + email);

        // Basic input validation
        if (email == null || email.trim().isEmpty() || password == null || password.trim().isEmpty()) {
            LOGGER.warning("Empty email or password provided");
            req.setAttribute("error", "Email and password are required.");
            req.getRequestDispatcher("/login.jsp").forward(req, resp);
            return;
        }

        try {
            User user = userService.authenticate(email, password);
            if (user != null) {
                HttpSession session = req.getSession();
                session.setAttribute("userId", user.getUserId());
                session.setAttribute("username", user.getUsername());
                session.setAttribute("email", user.getEmail());
                session.setAttribute("role", user.getRole());
                session.setAttribute("profilePictureUrl", user.getProfilePictureUrl());
                session.setMaxInactiveInterval(30 * 60); // Set session timeout to 30 minutes
                LOGGER.info("Sign-in successful for user: " + user.getUsername());

                // Redirect based on user role
                switch (user.getRole()) {
                    case "creator":
                        resp.sendRedirect(req.getContextPath() + "/CreatorDashboardServlet");
                        break;
                    case "normal":
                        resp.sendRedirect(req.getContextPath() + "/ProfileDashboardServlet");
                        break;
                    case "admin":
                        resp.sendRedirect(req.getContextPath() + "/admin");
                        break;
                    default:
                        LOGGER.warning("Unknown role: " + user.getRole());
                        resp.sendRedirect(req.getContextPath() + "/index.jsp");
                }
            } else {
                LOGGER.warning("Sign-in failed for email: " + email);
                req.setAttribute("error", "Invalid email or password.");
                req.getRequestDispatcher("/login.jsp").forward(req, resp);
            }
        } catch (Exception e) {
            LOGGER.severe("Error in sign-in: " + e.getMessage());
            req.setAttribute("error", "An error occurred during sign-in. Please try again.");
            req.getRequestDispatcher("/login.jsp").forward(req, resp);
        }
    }
}