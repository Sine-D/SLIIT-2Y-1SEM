package com.video.model;

import java.util.Date;
import java.util.List;

public class Video {
    private int videoId;
    private int creatorId;
    private String title;
    private String description;
    private String language;
    private int duration;
    private Date uploadDate;
    private String visibility;
    private String videoUrl;
    private String thumbnailUrl;
    private String status;
    private String slug;
    private List<String> genres;

    // Getters and Setters
    public int getVideoId() { return videoId; }
    public void setVideoId(int videoId) { this.videoId = videoId; }

    public int getCreatorId() { return creatorId; }
    public void setCreatorId(int creatorId) { this.creatorId = creatorId; }

    public String getTitle() { return title; }
    public void setTitle(String title) { this.title = title; }

    public String getDescription() { return description; }
    public void setDescription(String description) { this.description = description; }

    public String getLanguage() { return language; }
    public void setLanguage(String language) { this.language = language; }

    public int getDuration() { return duration; }
    public void setDuration(int duration) { this.duration = duration; }

    public Date getUploadDate() { return uploadDate; }
    public void setUploadDate(Date uploadDate) { this.uploadDate = uploadDate; }

    public String getVisibility() { return visibility; }
    public void setVisibility(String visibility) { this.visibility = visibility; }

    public String getVideoUrl() { return videoUrl; }
    public void setVideoUrl(String videoUrl) { this.videoUrl = videoUrl; }

    public String getThumbnailUrl() { return thumbnailUrl; }
    public void setThumbnailUrl(String thumbnailUrl) { this.thumbnailUrl = thumbnailUrl; }

    public String getStatus() { return status; }
    public void setStatus(String status) { this.status = status; }

    public String getSlug() { return slug; }
    public void setSlug(String slug) { this.slug = slug; }

    public List<String> getGenres() { return genres; }
    public void setGenres(List<String> genres) { this.genres = genres; }
}