package com.video.servlet;

import com.video.service.VideoService;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.logging.Logger;

@WebServlet("/DeleteVideoServlet")
public class DeleteVideoServlet extends HttpServlet {
    private static final Logger LOGGER = Logger.getLogger(DeleteVideoServlet.class.getName());
    private VideoService videoService;

    @Override
    public void init() throws ServletException {
        videoService = new VideoService();
        LOGGER.info("DeleteVideoServlet initialized");
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        
        LOGGER.info("DeleteVideoServlet doPost method called");
        LOGGER.info("Request URI: " + req.getRequestURI());
        LOGGER.info("Context Path: " + req.getContextPath());
        LOGGER.info("Servlet Path: " + req.getServletPath());
        
        HttpSession session = req.getSession(false);
        if (session == null || session.getAttribute("userId") == null) {
            LOGGER.warning("User not signed in, redirecting to sign-in");
            resp.sendRedirect(req.getContextPath() + "/SignInServlet");
            return;
        }

        
        LOGGER.info("Video ID parameter: " + req.getParameter("videoId"));
        LOGGER.info("User ID from session: " + session.getAttribute("userId"));

        try {
            int videoId = Integer.parseInt(req.getParameter("videoId"));
            int creatorId = (Integer) session.getAttribute("userId");
            
            LOGGER.info("Attempting to delete video with ID: " + videoId + " by creator: " + creatorId);
            videoService.deleteVideoPermanently(videoId, creatorId);
            LOGGER.info("Video deleted permanently, redirecting to dashboard");
            resp.sendRedirect(req.getContextPath() + "/dashboard.jsp");
        } catch (NumberFormatException e) {
            LOGGER.severe("Invalid video ID format: " + req.getParameter("videoId"));
            req.setAttribute("error", "Invalid video ID format");
            req.getRequestDispatcher("/error.jsp").forward(req, resp);
        } catch (Exception e) {
            LOGGER.severe("Error in doPost: " + e.getMessage());
            req.setAttribute("error", "Error deleting video: " + e.getMessage());
            req.getRequestDispatcher("/error.jsp").forward(req, resp);
        }
    }
    
    
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        LOGGER.warning("DeleteVideoServlet received a GET request instead of POST");
        resp.sendRedirect(req.getContextPath() + "/dashboard.jsp");
    }
}