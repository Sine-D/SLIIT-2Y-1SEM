package com.video.servlet;

import com.video.model.Video;

import com.video.service.VideoService;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;
import java.util.logging.Logger;

@WebServlet("/video/*")
public class ViewVideoServlet extends HttpServlet {
    private static final Logger LOGGER = Logger.getLogger(ViewVideoServlet.class.getName());
    private VideoService videoService;

    @Override
    public void init() throws ServletException {
        videoService = new VideoService();
        LOGGER.info("ViewVideoServlet initialized");
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String pathInfo = req.getPathInfo();
        LOGGER.info("doGet called with pathInfo: " + pathInfo);
        if (pathInfo == null || pathInfo.equals("/") || pathInfo.trim().isEmpty()) {
            req.setAttribute("error", "No video slug provided");
            req.getRequestDispatcher("/error.jsp").forward(req, resp);
            return;
        }

        String slug = pathInfo.substring(1);
        try {
            Video video = videoService.getVideoBySlug(slug);
            if (video == null) {
                req.setAttribute("error", "Video not found for slug: " + slug);
                req.getRequestDispatcher("/error.jsp").forward(req, resp);
                return;
            }
            // Fetch actors for the video
            List<VideoService.Actor> actors = videoService.getActorsForVideo(video.getVideoId());
            req.setAttribute("video", video);
            req.setAttribute("actors", actors);
            req.getRequestDispatcher("/viewVideo.jsp").forward(req, resp);
        } catch (Exception e) {
            LOGGER.severe("Error in doGet: " + e.getMessage());
            req.setAttribute("error", "Error retrieving video: " + e.getMessage());
            req.getRequestDispatcher("/error.jsp").forward(req, resp);
        }
    }
}