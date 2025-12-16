package com.video.servlet;

import com.video.model.Video;
import com.video.service.VideoService;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.logging.Logger;

@WebServlet(name = "IndexServlet", urlPatterns = {"/IndexServlet"})
public class IndexServlet extends HttpServlet {
    private static final Logger LOGGER = Logger.getLogger(IndexServlet.class.getName());
    private VideoService videoService;

    @Override
    public void init() throws ServletException {
        videoService = new VideoService();
        LOGGER.info("IndexServlet initialized");
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        try {
            // Fetch all active videos
            List<Video> videos = videoService.getAllActiveVideos();
            // Fetch creator usernames for each video
            Map<Integer, String> creatorUsernames = new HashMap<>();
            for (Video video : videos) {
                String creatorUsername = videoService.getCreatorUsername(video.getCreatorId());
                creatorUsernames.put(video.getVideoId(), creatorUsername);
            }
            // Set attributes for JSP
            req.setAttribute("videos", videos);
            req.setAttribute("creatorUsernames", creatorUsernames);
            // Forward to index.jsp
            req.getRequestDispatcher("/index.jsp").forward(req, resp);
        } catch (Exception e) {
            LOGGER.severe("Error in doGet: " + e.getMessage());
            req.setAttribute("error", "Error retrieving video list: " + e.getMessage());
            req.getRequestDispatcher("/error.jsp").forward(req, resp);
        }
    }
}