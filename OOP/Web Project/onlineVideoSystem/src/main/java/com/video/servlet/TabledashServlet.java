package com.video.servlet;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Logger;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.video.model.Video;
import com.video.service.VideoService;

@WebServlet("/TabledashServlet")
public class TabledashServlet extends HttpServlet {
    private static final Logger LOGGER = Logger.getLogger(TabledashServlet.class.getName());
    private VideoService videoService;

    @Override
    public void init() throws ServletException {
        videoService = new VideoService();
        LOGGER.info("TabledashServlet initialized");
    }
    
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession(false);
        if (session == null || session.getAttribute("userId") == null || !"creator".equals(session.getAttribute("role"))) {
            LOGGER.warning("Unauthorized access to dashboard, redirecting to sign-in");
            resp.sendRedirect(req.getContextPath() + "/SignInServlet");
            return;
        }

        try {
            int creatorId = (Integer) session.getAttribute("userId");
            List<Video> videos = videoService.getVideosByCreatorId(creatorId);
            
            // Log if thumbnailUrl is missing for any video
            for (Video video : videos) {
                if (video.getThumbnailUrl() == null || video.getThumbnailUrl().isEmpty()) {
                    LOGGER.warning("Thumbnail URL missing for video: " + video.getTitle());
                }
            }

            req.setAttribute("videos", videos);
            req.setAttribute("username", session.getAttribute("username"));
            req.setAttribute("email", session.getAttribute("email"));
            req.getRequestDispatcher("/tabledash.jsp").forward(req, resp);
        } catch (Exception e) {
            LOGGER.severe("Error in doGet: " + e.getMessage());
            req.setAttribute("error", "Error loading dashboard: " + e.getMessage());
            req.getRequestDispatcher("/error.jsp").forward(req, resp);
        }
    }
}