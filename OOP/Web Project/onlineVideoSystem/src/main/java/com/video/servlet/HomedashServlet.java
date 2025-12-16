package com.video.servlet;

import com.video.model.CreatorVideoStats;
import com.video.service.VideoService;
import java.io.IOException;
import java.util.logging.Logger;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/HomedashServlet")
public class HomedashServlet extends HttpServlet {
    private static final Logger LOGGER = Logger.getLogger(HomedashServlet.class.getName());
    private VideoService videoService;

    @Override
    public void init() throws ServletException {
        videoService = new VideoService();
        videoService.setUploadBasePath(getServletContext().getRealPath("/"));
        LOGGER.info("HomedashServlet initialized");
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession(false);
        if (session == null || session.getAttribute("userId") == null || 
            !"creator".equals(session.getAttribute("role"))) {
            LOGGER.warning("Unauthorized access to home dashboard, redirecting to sign-in");
            resp.sendRedirect(req.getContextPath() + "/SignInServlet");
            return;
        }

        try {
            int creatorId = (Integer) session.getAttribute("userId");
            CreatorVideoStats stats = videoService.getCreatorVideoStats(creatorId);
            req.setAttribute("creatorStats", stats);
            req.getRequestDispatcher("/homedash.jsp").forward(req, resp);
        } catch (Exception e) {
            LOGGER.severe("Error in doGet: " + e.getMessage());
            req.setAttribute("error", "Error loading home dashboard: " + e.getMessage());
            req.getRequestDispatcher("/error.jsp").forward(req, resp);
        }
    }
}