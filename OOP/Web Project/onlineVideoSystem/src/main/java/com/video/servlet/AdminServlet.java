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
import java.util.List;
import java.util.logging.Logger;

@SuppressWarnings("serial")
@WebServlet("/admin")
public class AdminServlet extends HttpServlet {
    private static final Logger LOGGER = Logger.getLogger(AdminServlet.class.getName());
    private AdminService adminService;

    @Override
    public void init() throws ServletException {
        adminService = new AdminService();
        LOGGER.info("AdminServlet initialized");
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("userId") == null || !"admin".equals(session.getAttribute("role"))) {
            LOGGER.warning("Unauthorized access attempt to AdminServlet");
            response.sendRedirect(request.getContextPath() + "/SignInServlet");
            return;
        }

        try {
            List<Admin> admins = adminService.getAllAdmins();
            request.setAttribute("admins", admins);
            // Pass current user details from session
            request.setAttribute("username", session.getAttribute("username"));
            request.setAttribute("email", session.getAttribute("email"));
            request.setAttribute("profilePictureUrl", session.getAttribute("profilePictureUrl"));
            request.getRequestDispatcher("/AdminActions/AdminDashBoard.jsp").forward(request, response);
        } catch (SQLException e) {
            LOGGER.severe("Unable to fetch admin records: " + e.getMessage());
            request.setAttribute("errorMessage", "Unable to fetch admin records: " + e.getMessage());
            request.getRequestDispatcher("/AdminActions/error.jsp").forward(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response); // Reuse doGet for simplicity
    }
}