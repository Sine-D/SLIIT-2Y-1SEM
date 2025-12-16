package com.video.servlet;


import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.logging.Logger;

@WebServlet("/SignOutServlet")
public class SignOutServlet extends HttpServlet {
    private static final Logger LOGGER = Logger.getLogger(SignOutServlet.class.getName());

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession(false);
        if (session != null) {
            LOGGER.info("Signing out user: " + session.getAttribute("username"));
            session.invalidate();
        }
        resp.sendRedirect(req.getContextPath() + "/index.jsp");
    }
}