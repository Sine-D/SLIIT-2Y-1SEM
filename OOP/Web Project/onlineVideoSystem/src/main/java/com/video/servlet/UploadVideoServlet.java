package com.video.servlet;

import com.video.model.Video;
import com.video.service.VideoService;
import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;
import java.util.logging.Logger;

@WebServlet(name = "UploadVideoServlet", urlPatterns = {"/UploadVideoServlet"})
public class UploadVideoServlet extends HttpServlet {
    private static final Logger LOGGER = Logger.getLogger(UploadVideoServlet.class.getName());
    private VideoService videoService;
    private static final String FALLBACK_UPLOAD_DIR = System.getProperty("java.io.tmpdir") + "/onlineWebBrowsingSystem/uploads";

    @Override
    public void init() throws ServletException {
        videoService = new VideoService();
        String realPath = getServletContext().getRealPath("/");
        if (realPath == null) {
            LOGGER.warning("getServletContext().getRealPath('/') returned null, using fallback: " + FALLBACK_UPLOAD_DIR);
            realPath = FALLBACK_UPLOAD_DIR;
        }
        videoService.setUploadBasePath(realPath);
        LOGGER.info("UploadVideoServlet initialized with upload base path: " + realPath);
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession(false);
        if (session == null || session.getAttribute("userId") == null) {
            LOGGER.warning("User not signed in, redirecting to sign-in");
            resp.sendRedirect(req.getContextPath() + "/SignInServlet");
            return;
        }
        req.getRequestDispatcher("/upload.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession(false);
        if (session == null || session.getAttribute("userId") == null) {
            LOGGER.warning("User not signed in, redirecting to sign-in");
            resp.sendRedirect(req.getContextPath() + "/SignInServlet");
            return;
        }

        if (!ServletFileUpload.isMultipartContent(req)) {
            LOGGER.warning("Form is not multipart/form-data");
            req.setAttribute("error", "Form must have enctype=multipart/form-data");
            req.getRequestDispatcher("/upload.jsp").forward(req, resp);
            return;
        }

        try {
            DiskFileItemFactory factory = new DiskFileItemFactory();
            ServletFileUpload upload = new ServletFileUpload(factory);
            List<FileItem> items = upload.parseRequest(req);//create video object
            Video video = new Video();
            List<String> actorNames = new ArrayList<>();
            List<FileItem> actorPhotos = new ArrayList<>();

            LOGGER.info("Parsing form items: " + items.size() + " items received");
            for (FileItem item : items) {
                if (item.isFormField()) {
                    String fieldName = item.getFieldName();
                    String value = item.getString("UTF-8");
                    LOGGER.info("Form field: " + fieldName + " = " + value);
                    switch (fieldName) {
                        case "title":
                            video.setTitle(value);
                            video.setSlug(generateSlug(value));
                            break;
                        case "description":
                            video.setDescription(value);
                            break;
                        case "genre":
                            video.setGenres(value.isEmpty() ? new ArrayList<>() : Arrays.asList(value.split(",")));
                            break;
                        case "language":
                            video.setLanguage(value);
                            break;
                        case "duration":
                            try {
                                video.setDuration(Integer.parseInt(value));
                            } catch (NumberFormatException e) {
                                LOGGER.warning("Invalid duration: " + value);
                                video.setDuration(0);
                            }
                            break;
                        case "visibility":
                            video.setVisibility(value);
                            break;
                        default:
                            if (fieldName.startsWith("actor_name_")) {
                                actorNames.add(value);
                            }
                    }
                } else {
                    String fieldName = item.getFieldName();
                    LOGGER.info("File field: " + fieldName + ", size: " + item.getSize());
                    if (fieldName.equals("video_file")) {
                        video.setVideoUrl(saveFile(item, "videos"));
                    } else if (fieldName.equals("thumbnail")) {
                        video.setThumbnailUrl(saveFile(item, "thumbnails"));
                    } else if (fieldName.startsWith("actor_photo_")) {
                        actorPhotos.add(item);
                    }
                }
            }
 
            if (video.getSlug() == null || video.getSlug().isEmpty()) {
                LOGGER.warning("Invalid slug generated");
                req.setAttribute("error", "Invalid video title for slug generation");
                req.getRequestDispatcher("/upload.jsp").forward(req, resp);
                return;
            }
          
            if (video.getVideoUrl() == null || video.getThumbnailUrl() == null) {
                LOGGER.warning("Missing video or thumbnail file");
                req.setAttribute("error", "Video file and thumbnail are required");
                req.getRequestDispatcher("/upload.jsp").forward(req, resp);
                return;
            }

            video.setCreatorId((Integer) session.getAttribute("userId"));
            LOGGER.info("Calling VideoService.uploadVideo with slug: " + video.getSlug());
            videoService.uploadVideo(video, actorNames, actorPhotos);
            LOGGER.info("Video uploaded successfully, forwarding to upload-success.jsp");
            req.setAttribute("videoSlug", video.getSlug());
            req.getRequestDispatcher("/upload-success.jsp").forward(req, resp);
        } catch (Exception e) {
            LOGGER.severe("Error in doPost: " + e.getMessage());
            e.printStackTrace();
            req.setAttribute("error", "Error uploading video: " + e.getMessage());
            req.getRequestDispatcher("/upload.jsp").forward(req, resp);
        }
    }

    private String generateSlug(String title) {
        if (title == null || title.trim().isEmpty()) {
            LOGGER.warning("Title is null or empty, generating default slug");
            return "default-video-" + System.currentTimeMillis();
        }
        String slug = title.toLowerCase()
                .replaceAll("[^a-z0-9]+", "-")
                .replaceAll("^-|-$", "");
        return slug.isEmpty() ? "video-" + System.currentTimeMillis() : slug;
    }

    private String saveFile(FileItem item, String subDir) throws Exception {
        if (item == null || item.getSize() == 0) {
            LOGGER.warning("Empty file for " + subDir);
            return null;
        }
        String fileName = new File(item.getName()).getName();
        String uploadDir = getServletContext().getRealPath("/uploads/" + subDir);
        if (uploadDir == null) {
            uploadDir = FALLBACK_UPLOAD_DIR + "/" + subDir;
            LOGGER.warning("getRealPath returned null, using fallback: " + uploadDir);
        }
        LOGGER.info("Saving file to: " + uploadDir + "/" + fileName);
        File dir = new File(uploadDir);
        if (!dir.exists()) {
            LOGGER.info("Creating directory: " + uploadDir);
            if (!dir.mkdirs()) {
                throw new IOException("Failed to create directory: " + uploadDir);
            }
        }
        File file = new File(dir, fileName);
        item.write(file);
        if (!file.exists()) {
            LOGGER.severe("File not found after save: " + file.getAbsolutePath());
            throw new IOException("File not found after save: " + file.getAbsolutePath());
        }
        LOGGER.info("File saved successfully: " + file.getAbsolutePath());
        return "/uploads/" + subDir + "/" + fileName;
    }
}