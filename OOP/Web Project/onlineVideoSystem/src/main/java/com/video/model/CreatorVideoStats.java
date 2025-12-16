package com.video.model;

public class CreatorVideoStats {
    private int creatorId;
    private String username;
    private long activeVideos;
    private long deactivatedVideos;
    private long totalVideos;

    
    public CreatorVideoStats(int creatorId, String username, long activeVideos, long deactivatedVideos, long totalVideos) {
        this.creatorId = creatorId;
        this.username = username;
        this.activeVideos = activeVideos;
        this.deactivatedVideos = deactivatedVideos;
        this.totalVideos = totalVideos;
    }

   
    public int getCreatorId() {
        return creatorId;
    }

    public void setCreatorId(int creatorId) {
        this.creatorId = creatorId;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public long getActiveVideos() {
        return activeVideos;
    }

    public void setActiveVideos(long activeVideos) {
        this.activeVideos = activeVideos;
    }

    public long getDeactivatedVideos() {
        return deactivatedVideos;
    }

    public void setDeactivatedVideos(long deactivatedVideos) {
        this.deactivatedVideos = deactivatedVideos;
    }

    public long getTotalVideos() {
        return totalVideos;
    }

    public void setTotalVideos(long totalVideos) {
        this.totalVideos = totalVideos;
    }
}