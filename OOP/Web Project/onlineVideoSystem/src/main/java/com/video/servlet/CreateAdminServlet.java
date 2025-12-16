package com.video.servlet;

import com.video.model.Admin;
import com.video.service.AdminService;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.SQLException;

@SuppressWarnings("serial")
@WebServlet("/createAdmin")
public class CreateAdminServlet extends HttpServlet {
    private AdminService adminService;

    @Override
    public void init() throws ServletException {
        adminService = new AdminService();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("/AdminActions/createAdmin.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            String userName = request.getParameter("userName");
            String email = request.getParameter("email");
            String phoneNumber = request.getParameter("phoneNumber");
            String password = request.getParameter("password");

            Admin admin = new Admin();
            admin.setUserName(userName);
            admin.setEmail(email);
            admin.setPhoneNumber(phoneNumber);
            admin.setPassword(password);

            adminService.addAdmin(admin);
            response.sendRedirect("admin");
        } catch (SQLException e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", "Unable to create admin: " + e.getMessage());
            request.getRequestDispatcher("/error.jsp").forward(request, response);
        }
    }
}