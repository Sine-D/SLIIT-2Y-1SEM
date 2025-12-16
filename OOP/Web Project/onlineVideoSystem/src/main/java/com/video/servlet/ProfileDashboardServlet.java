package com.video.servlet;

import com.video.model.User;
import com.video.service.UserService;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.File;
import java.io.IOException;
import java.util.logging.Logger;

@WebServlet("/ProfileDashboardServlet")
@MultipartConfig(fileSizeThreshold = 1024 * 1024 * 2, // 2MB
        maxFileSize = 1024 * 1024 * 10,      // 10MB
        maxRequestSize = 1024 * 1024 * 50)    // 50MB
public class ProfileDashboardServlet extends HttpServlet {
    private static final Logger LOGGER = Logger.getLogger(ProfileDashboardServlet.class.getName());
    private UserService userService;
    private static final String UPLOAD_DIR = "profile_photo";

    @Override
    public void init() throws ServletException {
        userService = new UserService();
        LOGGER.info("ProfileDashboardServlet initialized");
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession(false);
        if (session == null || session.getAttribute("userId") == null || !"normal".equals(session.getAttribute("role"))) {
            LOGGER.warning("Unauthorized access attempt to ProfileDashboardServlet");
            resp.sendRedirect(req.getContextPath() + "/login.jsp");
            return;
        }

        try {
            int userId = (Integer) session.getAttribute("userId");
            User user = userService.getUserById(userId);
            if (user != null) {
                String profilePictureUrl = user.getProfilePictureUrl();
                if (profilePictureUrl != null && !profilePictureUrl.isEmpty()) {
                    profilePictureUrl = req.getContextPath() + "/" + profilePictureUrl;
                }
                req.setAttribute("username", user.getUsername());
                req.setAttribute("email", user.getEmail());
                req.setAttribute("profilePictureUrl", profilePictureUrl);
                session.setAttribute("username", user.getUsername());
                session.setAttribute("email", user.getEmail());
                session.setAttribute("profilePictureUrl", user.getProfilePictureUrl());
            } else {
                LOGGER.warning("User not found for ID: " + userId);
                resp.sendRedirect(req.getContextPath() + "/login.jsp");
                return;
            }
        } catch (Exception e) {
            LOGGER.severe("Error fetching user: " + e.getMessage());
            req.setAttribute("error", "Error fetching user data");
        }

        req.getRequestDispatcher("/profileDashboard.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession(false);
        if (session == null || session.getAttribute("userId") == null || !"normal".equals(session.getAttribute("role"))) {
            LOGGER.warning("Unauthorized update attempt");
            resp.sendRedirect(req.getContextPath() + "/login.jsp");
            return;
        }

        try {
            int userId = (Integer) session.getAttribute("userId");
            String action = req.getParameter("action");
            String currentProfilePictureUrl = (String) session.getAttribute("profilePictureUrl");

            if ("delete".equals(action)) {
                // Delete user profile
                String uploadPath = getServletContext().getRealPath("") + File.separator + UPLOAD_DIR;
                boolean deleted = userService.deleteUser(userId, currentProfilePictureUrl, uploadPath);
                if (deleted) {
                    session.invalidate();
                    resp.sendRedirect(req.getContextPath() + "/index.jsp");
                    return;
                } else {
                    req.setAttribute("error", "Failed to delete profile");
                }
            } else {
                // Handle profile update 
                String username = req.getParameter("username");
                String email = req.getParameter("email");
                String newPassword = req.getParameter("password");
                Part filePart = req.getPart("profilePhoto");
                String fileName = null;
                String profilePictureUrl = currentProfilePictureUrl;

                // Validate email 
                if (!email.matches("^[^\\s@]+@[^\\s@]+\\.[^\\s@]+$")) {
                    req.setAttribute("error", "Invalid email format");
                    setUserAttributes(req, session);
                    req.getRequestDispatcher("/profileDashboard.jsp").forward(req, resp);
                    return;
                }

                // Check for email uniqueness
                if (userService.isEmailTakenByOther(email, userId)) {
                    req.setAttribute("error", "Email is already in use by another user");
                    setUserAttributes(req, session);
                    req.getRequestDispatcher("/profileDashboard.jsp").forward(req, resp);
                    return;
                }

                // Handle photo upload
                if (filePart != null && filePart.getSize() > 0) {
                    fileName = userId + "_" + extractFileName(filePart);
                    String uploadPath = getServletContext().getRealPath("") + File.separator + UPLOAD_DIR;
                    File uploadDir = new File(uploadPath);
                    if (!uploadDir.exists()) {
                        uploadDir.mkdirs();
                    }
                    String fullFilePath = uploadPath + File.separator + fileName;
                    filePart.write(fullFilePath);
                    LOGGER.info("Profile photo uploaded to: " + fullFilePath);
                    profilePictureUrl = UPLOAD_DIR + "/" + fileName;

                    // Verify file exists
                    File uploadedFile = new File(fullFilePath);
                    if (!uploadedFile.exists()) {
                        LOGGER.severe("Uploaded file does not exist: " + fullFilePath);
                        req.setAttribute("error", "Failed to save profile photo");
                    }
                }

                // Update password 
                if (newPassword != null && !newPassword.trim().isEmpty()) {
                    boolean passwordUpdated = userService.updatePassword(userId, newPassword);
                    if (!passwordUpdated) {
                        req.setAttribute("error", "Failed to update password");
                    }
                }

                // Update user profile
                boolean profileUpdated = userService.updateUser(userId, username, email, profilePictureUrl);
                if (profileUpdated) {
                    session.setAttribute("username", username);
                    session.setAttribute("email", email);
                    session.setAttribute("profilePictureUrl", profilePictureUrl);
                    String displayProfilePictureUrl = profilePictureUrl;
                    if (profilePictureUrl != null && !profilePictureUrl.isEmpty()) {
                        displayProfilePictureUrl = req.getContextPath() + "/" + profilePictureUrl;
                    }
                    req.setAttribute("username", username);
                    req.setAttribute("email", email);
                    req.setAttribute("profilePictureUrl", displayProfilePictureUrl);
                    req.setAttribute("success", "Profile updated successfully");
                } else {
                    req.setAttribute("error", "Failed to update profile");
                    setUserAttributes(req, session);
                }
            }

            req.getRequestDispatcher("/profileDashboard.jsp").forward(req, resp);

        } catch (Exception e) {
            LOGGER.severe("Error processing request: " + e.getMessage());
            req.setAttribute("error", "An unexpected error occurred: " + e.getMessage());
            try {
                setUserAttributes(req, session);
            } catch (Exception innerException) {
                LOGGER.severe("Error setting user attributes: " + innerException.getMessage());
                req.setAttribute("error", "An unexpected error occurred while retrieving user data: " + innerException.getMessage());
            }
            req.getRequestDispatcher("/profileDashboard.jsp").forward(req, resp);
        }
    }

    private String extractFileName(Part part) {
        String contentDisp = part.getHeader("content-disposition");
        String[] items = contentDisp.split(";");
        for (String s : items) {
            if (s.trim().startsWith("filename")) {
                String fileName = s.substring(s.indexOf("=") + 2, s.length() - 1);
                return fileName.replaceAll("[^a-zA-Z0-9._-]", "");
            }
        }
        return "";
    }

    private void setUserAttributes(HttpServletRequest req, HttpSession session) throws Exception {
        int userId = (Integer) session.getAttribute("userId");
        User user = userService.getUserById(userId);
        if (user != null) {
            String profilePictureUrl = user.getProfilePictureUrl();
            if (profilePictureUrl != null && !profilePictureUrl.isEmpty()) {
                profilePictureUrl = req.getContextPath() + "/" + profilePictureUrl;
            }
            req.setAttribute("username", user.getUsername());
            req.setAttribute("email", user.getEmail());
            req.setAttribute("profilePictureUrl", profilePictureUrl);
        } else {
            throw new Exception("User not found for ID: " + userId);
        }
    }
}