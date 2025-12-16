package com.video.servlet;

import com.video.model.Admin;
import com.video.service.AdminService;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.sql.SQLException;
import java.util.logging.Logger;

@SuppressWarnings("serial")
@WebServlet("/editAdmin")
public class AdminEditServlet extends HttpServlet {
    private static final Logger LOGGER = Logger.getLogger(AdminEditServlet.class.getName());
    private AdminService adminService;

    @Override
    public void init() throws ServletException {
        adminService = new AdminService();
        LOGGER.info("AdminEditServlet initialized");
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("userId") == null || !"admin".equals(session.getAttribute("role"))) {
            LOGGER.warning("Unauthorized access attempt to AdminEditServlet");
            response.sendRedirect(request.getContextPath() + "/SignInServlet");
            return;
        }

        try {
            int id = Integer.parseInt(request.getParameter("id"));
            Admin admin = adminService.getAdminById(id);
            if (admin != null) {
                request.setAttribute("admin", admin);
                request.setAttribute("username", session.getAttribute("username"));
                request.setAttribute("email", session.getAttribute("email"));
                request.setAttribute("profilePictureUrl", session.getAttribute("profilePictureUrl"));
                request.getRequestDispatcher("/AdminActions/adminEdit.jsp").forward(request, response);
            } else {
                LOGGER.warning("Admin not found for ID: " + id);
                response.sendRedirect("admin");
            }
        } catch (SQLException e) {
            LOGGER.severe("Error fetching admin for edit: " + e.getMessage());
            request.setAttribute("errorMessage", "Unable to fetch admin details: " + e.getMessage());
            request.getRequestDispatcher("/AdminActions/error.jsp").forward(request, response);
        } catch (NumberFormatException e) {
            LOGGER.warning("Invalid admin ID format: " + request.getParameter("id"));
            response.sendRedirect("admin");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            int id = Integer.parseInt(request.getParameter("id"));
            String userName = request.getParameter("userName");
            String email = request.getParameter("email");
            String phoneNumber = request.getParameter("phoneNumber");
            String password = request.getParameter("password");

            Admin admin = adminService.getAdminById(id);
            if (admin != null) {
                admin.setUserName(userName);
                admin.setEmail(email);
                admin.setPhoneNumber(phoneNumber);
                if (password != null && !password.trim().isEmpty()) {
                    admin.setPassword(password);
                }
                adminService.updateAdmin(admin);
                response.sendRedirect("admin");
            } else {
                LOGGER.warning("Admin not found for ID: " + id);
                response.sendRedirect("admin");
            }
        } catch (SQLException e) {
            LOGGER.severe("Error updating admin: " + e.getMessage());
            request.setAttribute("errorMessage", "Unable to update admin: " + e.getMessage());
            request.getRequestDispatcher("/AdminActions/error.jsp").forward(request, response);
        } catch (NumberFormatException e) {
            LOGGER.warning("Invalid admin ID format: " + request.getParameter("id"));
            response.sendRedirect("admin");
        }
    }
}
