package com.video.servlet;

import com.video.model.Video;
import com.video.service.VideoService;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.logging.Logger;

@WebServlet("/EditVideoServlet")
public class EditVideoServlet extends HttpServlet {
    private static final Logger LOGGER = Logger.getLogger(EditVideoServlet.class.getName());
    private VideoService videoService;

    @Override
    public void init() throws ServletException {
        videoService = new VideoService();
        LOGGER.info("EditVideoServlet initialized");
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession(false);
        if (session == null || session.getAttribute("userId") == null || !"creator".equals(session.getAttribute("role"))) {
            LOGGER.warning("Unauthorized access to EditVideoServlet, redirecting to sign-in");
            resp.sendRedirect(req.getContextPath() + "/SignInServlet");
            return;
        }

        String slug = req.getParameter("slug");
        if (slug == null || slug.trim().isEmpty()) {
            LOGGER.warning("No slug provided in EditVideoServlet");
            req.setAttribute("error", "Invalid video slug");
            req.getRequestDispatcher("/tabledash.jsp").forward(req, resp);
            return;
        }

        try {
            Video video = videoService.getVideoBySlug(slug);
            if (video == null) {
                LOGGER.warning("Video not found for slug: " + slug);
                req.setAttribute("error", "Video not found");
                req.getRequestDispatcher("/tabledash.jsp").forward(req, resp);
                return;
            }
            if (video.getCreatorId() != (Integer) session.getAttribute("userId")) {
                LOGGER.warning("Unauthorized attempt to edit video with slug: " + slug + " by user ID: " + session.getAttribute("userId"));
                req.setAttribute("error", "You are not authorized to edit this video");
                req.getRequestDispatcher("/tabledash.jsp").forward(req, resp);
                return;
            }
            req.setAttribute("video", video);
            LOGGER.info("Forwarding to editVideo.jsp for video: " + video.getTitle());
            req.getRequestDispatcher("/editVideo.jsp").forward(req, resp);
        } catch (Exception e) {
            LOGGER.severe("Error in doGet for slug " + slug + ": " + e.getMessage());
            e.printStackTrace();
            req.setAttribute("error", "Error retrieving video: " + e.getMessage());
            req.getRequestDispatcher("/tabledash.jsp").forward(req, resp);
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession(false);
        if (session == null || session.getAttribute("userId") == null || !"creator".equals(session.getAttribute("role"))) {
            LOGGER.warning("Unauthorized access to EditVideoServlet POST, redirecting to sign-in");
            resp.sendRedirect(req.getContextPath() + "/SignInServlet");
            return;
        }

        try {
            Video video = new Video();
            video.setVideoId(Integer.parseInt(req.getParameter("videoId")));
            video.setCreatorId((Integer) session.getAttribute("userId"));
            video.setTitle(req.getParameter("title"));
            video.setDescription(req.getParameter("description"));
            video.setLanguage(req.getParameter("language"));
            video.setDuration(Integer.parseInt(req.getParameter("duration")));
            video.setVisibility(req.getParameter("visibility"));
            video.setStatus(req.getParameter("status"));
            video.setSlug(generateSlug(req.getParameter("title")));
            String genres = req.getParameter("genre");
            video.setGenres(genres == null || genres.trim().isEmpty() ? new ArrayList<>() : Arrays.asList(genres.split("\\s*,\\s*")));

            videoService.updateVideo(video);
            LOGGER.info("Video updated successfully, redirecting to /video/" + video.getSlug());
            resp.sendRedirect(req.getContextPath() + "/video/" + video.getSlug());
        } catch (NumberFormatException e) {
            LOGGER.severe("Invalid number format in doPost: " + e.getMessage());
            req.setAttribute("error", "Invalid input format for duration or video ID");
            req.getRequestDispatcher("/editVideo.jsp").forward(req, resp);
        } catch (Exception e) {
            LOGGER.severe("Error in doPost: " + e.getMessage());
            e.printStackTrace();
            req.setAttribute("error", "Error updating video: " + e.getMessage());
            req.getRequestDispatcher("/editVideo.jsp").forward(req, resp);
        }
    }

    private String generateSlug(String title) {
        if (title == null || title.trim().isEmpty()) {
            return "default-video-" + System.currentTimeMillis();
        }
        String slug = title.toLowerCase()
                .replaceAll("[^a-z0-9]+", "-")
                .replaceAll("^-|-$", "");
        return slug.isEmpty() ? "video-" + System.currentTimeMillis() : slug;
    }
}