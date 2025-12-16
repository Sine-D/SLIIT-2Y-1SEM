package com.video.servlet;

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
@WebServlet("/deleteAdmin")
public class AdminDeleteServlet extends HttpServlet {
    private static final Logger LOGGER = Logger.getLogger(AdminDeleteServlet.class.getName());
    private AdminService adminService;

    @Override
    public void init() throws ServletException {
        adminService = new AdminService();
        LOGGER.info("AdminDeleteServlet initialized");
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("userId") == null || !"admin".equals(session.getAttribute("role"))) {
            LOGGER.warning("Unauthorized access attempt to AdminDeleteServlet");
            response.sendRedirect(request.getContextPath() + "/SignInServlet");
            return;
        }

        try {
            int id = Integer.parseInt(request.getParameter("id"));
            adminService.deleteAdmin(id);
            response.sendRedirect("admin");
        } catch (SQLException e) {
            LOGGER.severe("Error deleting admin: " + e.getMessage());
            request.setAttribute("errorMessage", "Unable to delete admin: " + e.getMessage());
            request.getRequestDispatcher("/AdminActions/error.jsp").forward(request, response);
        } catch (NumberFormatException e) {
            LOGGER.warning("Invalid admin ID format: " + request.getParameter("id"));
            response.sendRedirect("admin");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response); // Reuse doGet for simplicity
    }
}