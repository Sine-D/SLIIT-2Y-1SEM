package com.video.service;

import com.video.model.CreatorVideoStats;
import com.video.model.Video;
import com.video.util.DatabaseUtil;
import org.apache.commons.fileupload.FileItem;

import java.io.File;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Logger;

public class VideoService {
    private static final Logger LOGGER = Logger.getLogger(VideoService.class.getName());
    private String uploadBasePath;
    private static final String FALLBACK_UPLOAD_DIR = System.getProperty("java.io.tmpdir") + "/onlineWebBrowsingSystem/uploads";

    public VideoService() {
        this.uploadBasePath = null;
    } 
    public void setUploadBasePath(String path) {
        this.uploadBasePath = (path != null) ? path : FALLBACK_UPLOAD_DIR;
        LOGGER.info("Upload base path set to: " + this.uploadBasePath);
        File dir = new File(this.uploadBasePath);
        if (!dir.exists()) {
            LOGGER.info("Creating upload directory: " + this.uploadBasePath);
            dir.mkdirs(); }
    }

    public void uploadVideo(Video video, List<String> actorNames, List<FileItem> actorPhotos) throws Exception {
        LOGGER.info("Uploading video: " + video.getTitle() + ", slug: " + video.getSlug());

        try (Connection conn = DatabaseUtil.getConnection()) {
            conn.setAutoCommit(false);

            try {
                String sql = "INSERT INTO videos (creator_id, title, description, language, duration, visibility, video_url, thumbnail_url, status, slug) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";

                int videoId;
                try (PreparedStatement stmt = conn.prepareStatement(sql, PreparedStatement.RETURN_GENERATED_KEYS)) {
                    stmt.setInt(1, video.getCreatorId());
                    stmt.setString(2, video.getTitle());
                    stmt.setString(3, video.getDescription() != null ? video.getDescription() : "");
                    stmt.setString(4, video.getLanguage() != null ? video.getLanguage() : "");
                    stmt.setInt(5, video.getDuration());
                    stmt.setString(6, video.getVisibility() != null ? video.getVisibility() : "public");
                    stmt.setString(7, video.getVideoUrl());
                    stmt.setString(8, video.getThumbnailUrl());
                    stmt.setString(9, video.getStatus() != null ? video.getStatus() : "active");
                    stmt.setString(10, video.getSlug());

                    stmt.executeUpdate();

                    ResultSet rs = stmt.getGeneratedKeys();
                    if (rs.next()) {
                        videoId = rs.getInt(1);
                        video.setVideoId(videoId);
                        LOGGER.info("Video inserted with ID: " + videoId);
                    } else {
                        throw new Exception("Could not retrieve generated video ID.");
                    }
                }

                if (video.getGenres() != null && !video.getGenres().isEmpty()) {
                    for (String genre : video.getGenres()) {
                        try (PreparedStatement stmt = conn.prepareStatement("INSERT INTO video_genres (video_id, genre) VALUES (?, ?)")) {
                            stmt.setInt(1, videoId);
                            stmt.setString(2, genre);
                            stmt.executeUpdate();
                        }
                    }
                }

                if (actorNames.size() == actorPhotos.size()) {
                    for (int i = 0; i < actorNames.size(); i++) {
                        String actorName = actorNames.get(i);
                        FileItem actorPhoto = actorPhotos.get(i);
                        String photoUrl = saveActorPhoto(actorPhoto);

                        int actorId;
                        try (PreparedStatement stmt = conn.prepareStatement("INSERT INTO actors (name, photo_url) VALUES (?, ?)", PreparedStatement.RETURN_GENERATED_KEYS)) {
                            stmt.setString(1, actorName);
                            stmt.setString(2, photoUrl);
                            stmt.executeUpdate();

                            ResultSet rs = stmt.getGeneratedKeys();
                            if (rs.next()) {
                                actorId = rs.getInt(1);

                                try (PreparedStatement stmtVA = conn.prepareStatement("INSERT INTO video_actors (video_id, actor_id) VALUES (?, ?)")) {
                                    stmtVA.setInt(1, videoId);
                                    stmtVA.setInt(2, actorId);
                                    stmtVA.executeUpdate();
                                }
                            }
                        }
                    }
                } else {
                    LOGGER.warning("Mismatch in number of actor names and photos");
                }

                conn.commit();
                LOGGER.info("Upload completed for video: " + video.getTitle());

            } catch (Exception e) {
                conn.rollback();
                LOGGER.severe("Upload failed, rolling back. Reason: " + e.getMessage());
                throw e;
            }
        }
    }


    public Video getVideoBySlug(String slug) throws Exception {
        LOGGER.info("Fetching video with slug: " + slug);
        if (slug == null || slug.trim().isEmpty()) {
            LOGGER.warning("Invalid slug provided");
            return null;
        }
        
        try (Connection conn = DatabaseUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(
                     "SELECT * FROM videos WHERE slug = ?")) {
            stmt.setString(1, slug);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
            	
                Video video = new Video();
                video.setVideoId(rs.getInt("video_id"));
                video.setCreatorId(rs.getInt("creator_id"));
                video.setTitle(rs.getString("title"));
                video.setDescription(rs.getString("description"));
                video.setLanguage(rs.getString("language"));
                video.setDuration(rs.getInt("duration"));
                video.setUploadDate(rs.getTimestamp("upload_date"));
                video.setVisibility(rs.getString("visibility"));
                String videoUrl = rs.getString("video_url");
                video.setVideoUrl(videoUrl);
                String thumbnailUrl = rs.getString("thumbnail_url");
                video.setThumbnailUrl(thumbnailUrl);
                video.setStatus(rs.getString("status"));
                video.setSlug(rs.getString("slug"));
                video.setGenres(getGenresForVideo(video.getVideoId()));
                LOGGER.info("Video found: " + video.getTitle());
                validateFile(videoUrl, "videos");
                validateFile(thumbnailUrl, "thumbnails");
                return video;
            }
            LOGGER.info("No video found for slug: " + slug);
            return null;
        }
    }

    public List<Video> getVideosByCreatorId(int creatorId) throws Exception {
        LOGGER.info("Fetching videos for creator ID: " + creatorId);
        List<Video> videos = new ArrayList<>();
        try (Connection conn = DatabaseUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(
                     "SELECT * FROM videos WHERE creator_id = ? AND status != 'removed'")) {
            stmt.setInt(1, creatorId);
            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                Video video = new Video();
                video.setVideoId(rs.getInt("video_id"));
                video.setCreatorId(rs.getInt("creator_id"));
                video.setTitle(rs.getString("title"));
                video.setDescription(rs.getString("description"));
                video.setLanguage(rs.getString("language"));
                video.setDuration(rs.getInt("duration"));
                video.setUploadDate(rs.getTimestamp("upload_date"));
                video.setVisibility(rs.getString("visibility"));
                String videoUrl = rs.getString("video_url");
                video.setVideoUrl(videoUrl);
                String thumbnailUrl = rs.getString("thumbnail_url");
                video.setThumbnailUrl(thumbnailUrl);
                video.setStatus(rs.getString("status"));
                video.setSlug(rs.getString("slug"));
                video.setGenres(getGenresForVideo(video.getVideoId()));
                validateFile(videoUrl, "videos");
                validateFile(thumbnailUrl, "thumbnails");
                videos.add(video);
                LOGGER.info("Found video: " + video.getTitle());
            }
            LOGGER.info("Fetched " + videos.size() + " videos for creator ID: " + creatorId);
            return videos;
        }
    }

    public List<Video> getAllActiveVideos() throws Exception {
        LOGGER.info("Fetching all active videos");
        List<Video> videos = new ArrayList<>();
        try (Connection conn = DatabaseUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(
                     "SELECT * FROM videos WHERE status = 'active'")) {
            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                Video video = new Video();
                video.setVideoId(rs.getInt("video_id"));
                video.setCreatorId(rs.getInt("creator_id"));
                video.setTitle(rs.getString("title"));
                video.setDescription(rs.getString("description"));
                video.setLanguage(rs.getString("language"));
                video.setDuration(rs.getInt("duration"));
                video.setUploadDate(rs.getTimestamp("upload_date"));
                video.setVisibility(rs.getString("visibility"));
                String videoUrl = rs.getString("video_url");
                video.setVideoUrl(videoUrl);
                String thumbnailUrl = rs.getString("thumbnail_url");
                video.setThumbnailUrl(thumbnailUrl);
                video.setStatus(rs.getString("status"));
                video.setSlug(rs.getString("slug"));
                video.setGenres(getGenresForVideo(video.getVideoId()));
                validateFile(videoUrl, "videos");
                validateFile(thumbnailUrl, "thumbnails");
                videos.add(video);
                LOGGER.info("Found video: " + video.getTitle());
            }
            LOGGER.info("Fetched " + videos.size() + " active videos");
            return videos;
        }
    }

    public String getCreatorUsername(int creatorId) throws Exception {
        LOGGER.info("Fetching username for creator ID: " + creatorId);
        try (Connection conn = DatabaseUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(
                     "SELECT username FROM users WHERE user_id = ?")) {
            stmt.setInt(1, creatorId);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                String username = rs.getString("username");
                LOGGER.info("Found username: " + username);
                return username;
            }
            LOGGER.warning("No user found for creator ID: " + creatorId);
            return "Unknown Creator";
        }
    }

    public List<Actor> getActorsForVideo(int videoId) throws Exception {
        LOGGER.info("Fetching actors for video ID: " + videoId);
        List<Actor> actors = new ArrayList<>();
        try (Connection conn = DatabaseUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(
                     "SELECT a.actor_id, a.name, a.photo_url FROM actors a " +
                     "JOIN video_actors va ON a.actor_id = va.actor_id " +
                     "WHERE va.video_id = ?")) {
            stmt.setInt(1, videoId);
            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                Actor actor = new Actor();
                actor.setActorId(rs.getInt("actor_id"));
                actor.setName(rs.getString("name"));
                String photoUrl = rs.getString("photo_url");
                actor.setPhotoUrl(photoUrl);
                validateFile(photoUrl, "actors");
                actors.add(actor);
                LOGGER.info("Found actor: " + actor.getName() + ", photo_url: " + photoUrl);
            }
            LOGGER.info("Fetched " + actors.size() + " actors for video ID: " + videoId);
            return actors;
        }
    }

    public void updateVideo(Video video) throws Exception {
        LOGGER.info("Updating video: " + video.getTitle() + ", ID: " + video.getVideoId());
        try (Connection conn = DatabaseUtil.getConnection()) {
            conn.setAutoCommit(false);
            try {
                String sql = "UPDATE videos SET title = ?, description = ?, language = ?, duration = ?, visibility = ?, status = ?, slug = ? WHERE video_id = ? AND creator_id = ?";
                try (PreparedStatement stmt = conn.prepareStatement(sql)) {
                    stmt.setString(1, video.getTitle());
                    stmt.setString(2, video.getDescription() != null ? video.getDescription() : "");
                    stmt.setString(3, video.getLanguage() != null ? video.getLanguage() : "");
                    stmt.setInt(4, video.getDuration());
                    stmt.setString(5, video.getVisibility() != null ? video.getVisibility() : "public");
                    stmt.setString(6, video.getStatus() != null ? video.getStatus() : "active");
                    stmt.setString(7, video.getSlug());
                    stmt.setInt(8, video.getVideoId());
                    stmt.setInt(9, video.getCreatorId());
                    int rows = stmt.executeUpdate();
                    LOGGER.info("Updated video, rows affected: " + rows);
                }

                try (PreparedStatement stmt = conn.prepareStatement("DELETE FROM video_genres WHERE video_id = ?")) {
                    stmt.setInt(1, video.getVideoId());
                    stmt.executeUpdate();
                }

                if (video.getGenres() != null && !video.getGenres().isEmpty()) {
                    for (String genre : video.getGenres()) {
                        String sqlGenre = "INSERT INTO video_genres (video_id, genre) VALUES (?, ?)";
                        try (PreparedStatement stmt = conn.prepareStatement(sqlGenre)) {
                            stmt.setInt(1, video.getVideoId());
                            stmt.setString(2, genre);
                            stmt.executeUpdate();
                            LOGGER.info("Inserted genre: " + genre);
                        }
                    }
                }

                conn.commit();
                LOGGER.info("Transaction committed for video update: " + video.getTitle());
            } catch (Exception e) {
                LOGGER.severe("Error during updateVideo, rolling back: " + e.getMessage());
                conn.rollback();
                throw e;
            }
        }
    }

    public void deleteVideo(int videoId, int creatorId) throws Exception {
        LOGGER.info("Soft deleting video ID: " + videoId);
        try (Connection conn = DatabaseUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement("UPDATE videos SET status = 'removed' WHERE video_id = ? AND creator_id = ?")) {
            stmt.setInt(1, videoId);
            stmt.setInt(2, creatorId);
            int rows = stmt.executeUpdate();
            LOGGER.info("Soft deleted video, rows affected: " + rows);
            if (rows == 0) {
                throw new Exception("Video not found or user not authorized to delete video ID: " + videoId);
            }
        }
    }

    public void deleteVideoPermanently(int videoId, int creatorId) throws Exception {
        LOGGER.info("Permanently deleting video ID: " + videoId);
        try (Connection conn = DatabaseUtil.getConnection()) {
            conn.setAutoCommit(false);
            try {
                
                Video video = getVideoById(videoId);
                if (video == null || video.getCreatorId() != creatorId) {
                    throw new Exception("Video not found or user not authorized to delete video ID: " + videoId);
                }

                
                List<Actor> actors = getActorsForVideo(videoId);
                for (Actor actor : actors) {
                    deleteFile(actor.getPhotoUrl(), "actors");
                }

               
                try (PreparedStatement stmt = conn.prepareStatement("DELETE FROM video_actors WHERE video_id = ?")) {
                    stmt.setInt(1, videoId);
                    int rows = stmt.executeUpdate();
                    LOGGER.info("Deleted video_actors mappings, rows affected: " + rows);
                }

                
                try (PreparedStatement stmt = conn.prepareStatement(
                        "DELETE FROM actors WHERE actor_id IN (SELECT actor_id FROM video_actors WHERE video_id = ?)")) {
                    stmt.setInt(1, videoId);
                    int rows = stmt.executeUpdate();
                    LOGGER.info("Deleted actors, rows affected: " + rows);
                }

                
                try (PreparedStatement stmt = conn.prepareStatement("DELETE FROM video_genres WHERE video_id = ?")) {
                    stmt.setInt(1, videoId);
                    int rows = stmt.executeUpdate();
                    LOGGER.info("Deleted video_genres, rows affected: " + rows);
                }

                
                try (PreparedStatement stmt = conn.prepareStatement("DELETE FROM videos WHERE video_id = ? AND creator_id = ?")) {
                    stmt.setInt(1, videoId);
                    stmt.setInt(2, creatorId);
                    int rows = stmt.executeUpdate();
                    LOGGER.info("Permanently deleted video, rows affected: " + rows);
                    if (rows == 0) {
                        throw new Exception("Video not found or user not authorized to delete video ID: " + videoId);
                    }
                }

                
                deleteFile(video.getVideoUrl(), "videos");
                deleteFile(video.getThumbnailUrl(), "thumbnails");

                conn.commit();
                LOGGER.info("Transaction committed for permanent deletion of video ID: " + videoId);
            } catch (Exception e) {
                LOGGER.severe("Error during deleteVideoPermanently, rolling back: " + e.getMessage());
                conn.rollback();
                throw e;
            }
        }
    }

    private Video getVideoById(int videoId) throws Exception {
        LOGGER.info("Fetching video by ID: " + videoId);
        try (Connection conn = DatabaseUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement("SELECT * FROM videos WHERE video_id = ?")) {
            stmt.setInt(1, videoId);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                Video video = new Video();
                video.setVideoId(rs.getInt("video_id"));
                video.setCreatorId(rs.getInt("creator_id"));
                video.setTitle(rs.getString("title"));
                video.setDescription(rs.getString("description"));
                video.setLanguage(rs.getString("language"));
                video.setDuration(rs.getInt("duration"));
                video.setUploadDate(rs.getTimestamp("upload_date"));
                video.setVisibility(rs.getString("visibility"));
                String videoUrl = rs.getString("video_url");
                video.setVideoUrl(videoUrl);
                String thumbnailUrl = rs.getString("thumbnail_url");
                video.setThumbnailUrl(thumbnailUrl);
                video.setStatus(rs.getString("status"));
                video.setSlug(rs.getString("slug"));
                video.setGenres(getGenresForVideo(videoId));
                LOGGER.info("Video found: " + video.getTitle());
                validateFile(videoUrl, "videos");
                validateFile(thumbnailUrl, "thumbnails");
                return video;
            }
            LOGGER.info("No video found for ID: " + videoId);
            return null;
        }
    }

    private List<String> getGenresForVideo(int videoId) throws Exception {
        LOGGER.info("Fetching genres for video ID: " + videoId);
        List<String> genres = new ArrayList<>();
        try (Connection conn = DatabaseUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement("SELECT genre FROM video_genres WHERE video_id = ?")) {
            stmt.setInt(1, videoId);
            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                genres.add(rs.getString("genre"));
            }
            LOGGER.info("Found genres: " + genres);
            return genres;
        }
    }

    private String saveActorPhoto(FileItem item) throws Exception {
        if (item == null || item.getSize() == 0) {
            LOGGER.warning("Empty or null actor photo");
            return null;
        }
        String fileName = new File(item.getName()).getName();
        if (uploadBasePath == null) {
            throw new Exception("Upload base path not set");
        }
        String uploadDir = uploadBasePath + "/uploads/actors";
        LOGGER.info("Saving actor photo to: " + uploadDir + "/" + fileName);
        File dir = new File(uploadDir);
        if (!dir.exists()) {
            LOGGER.info("Creating directory: " + uploadDir);
            if (!dir.mkdirs()) {
                throw new IOException("Failed to create directory: " + uploadDir);
            }
        }
        File file = new File(dir, fileName);
        item.write(file);
        LOGGER.info("Actor photo saved successfully: " + file.getAbsolutePath());
        if (!file.exists()) {
            LOGGER.severe("File not found after save: " + file.getAbsolutePath());
            throw new IOException("File not found after save: " + file.getAbsolutePath());
        }
        return "/uploads/actors/" + fileName;
    }

    private void validateFile(String relativePath, String subDir) {
        if (relativePath == null || relativePath.isEmpty()) {
            LOGGER.warning("File path is null or empty for " + subDir);
            return;
        }
        String fullPath = uploadBasePath + relativePath;
        File file = new File(fullPath);
        if (!file.exists()) {
            LOGGER.warning("File does not exist: " + fullPath);
        } else if (!file.canRead()) {
            LOGGER.warning("File is not readable: " + fullPath);
        } else {
            LOGGER.info("File validated successfully: " + fullPath);
        }
    }

    private void deleteFile(String relativePath, String subDir) {
        if (relativePath == null || relativePath.isEmpty()) {
            LOGGER.warning("File path is null or empty for " + subDir);
            return;
        }
        String fullPath = uploadBasePath + relativePath;
        File file = new File(fullPath);
        if (file.exists()) {
            if (file.delete()) {
                LOGGER.info("Deleted file: " + fullPath);
            } else {
                LOGGER.warning("Failed to delete file: " + fullPath);
            }
        } else {
            LOGGER.warning("File does not exist: " + fullPath);
        }
    }

    public CreatorVideoStats getCreatorVideoStats(int creatorId) throws Exception {
        LOGGER.info("Fetching video statistics for creator ID: " + creatorId);
        CreatorVideoStats stats = null;
        String sql = "SELECT u.user_id, u.username, " +
                     "SUM(CASE WHEN v.status = 'active' THEN 1 ELSE 0 END) AS active_videos, " +
                     "SUM(CASE WHEN v.status = 'removed' THEN 1 ELSE 0 END) AS deactivated_videos, " +
                     "COUNT(v.video_id) AS total_videos " +
                     "FROM users u " +
                     "LEFT JOIN videos v ON u.user_id = v.creator_id " +
                     "WHERE u.role = 'creator' AND u.user_id = ? " +
                     "GROUP BY u.user_id, u.username";

        try (Connection conn = DatabaseUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, creatorId);
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    stats = new CreatorVideoStats(
                        rs.getInt("user_id"),
                        rs.getString("username"),
                        rs.getLong("active_videos"),
                        rs.getLong("deactivated_videos"),
                        rs.getLong("total_videos")
                    );
                    LOGGER.info("Found stats for creator: " + stats.getUsername());
                } else {
                    LOGGER.info("No stats found for creator ID: " + creatorId);
                }
            }
        } catch (Exception e) {
            LOGGER.severe("Error fetching creator video stats: " + e.getMessage());
            throw e;
        }
        return stats;
    }

    public static class Actor {
        private int actorId;
        private String name;
        private String photoUrl;

        public int getActorId() { return actorId; }
        public void setActorId(int actorId) { this.actorId = actorId; }

        public String getName() { return name; }
        public void setName(String name) { this.name = name; }

        public String getPhotoUrl() { return photoUrl; }
        public void setPhotoUrl(String photoUrl) { this.photoUrl = photoUrl; }
    }
}