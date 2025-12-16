package com.video.service;

import com.video.model.User;
import com.video.util.DatabaseUtil;

import java.io.File;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.logging.Logger;

public class UserService {
    private static final Logger LOGGER = Logger.getLogger(UserService.class.getName());

    public User authenticate(String email, String password) throws Exception {
        LOGGER.info("Authenticating user with email: " + email);
        try (Connection conn = DatabaseUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement("SELECT * FROM users WHERE email = ?")) {
            stmt.setString(1, email);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                String storedPassword = rs.getString("password_hash");
                // For simplicity, compare plain text (no encryption)
                if (password.equals(storedPassword)) {
                    User user = new User();
                    user.setUserId(rs.getInt("user_id"));
                    user.setUsername(rs.getString("username"));
                    user.setEmail(rs.getString("email"));
                    user.setRole(rs.getString("role"));
                    user.setProfilePictureUrl(rs.getString("profile_picture_url"));
                    LOGGER.info("User authenticated: " + user.getUsername());
                    return user;
                } else {
                    LOGGER.warning("Invalid password for email: " + email);
                    return null;
                }
            }
            LOGGER.warning("User not found for email: " + email);
            return null;
        }
    }

    public User getUserById(int userId) throws Exception {
        LOGGER.info("Fetching user with ID: " + userId);
        try (Connection conn = DatabaseUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement("SELECT * FROM users WHERE user_id = ?")) {
            stmt.setInt(1, userId);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                User user = new User();
                user.setUserId(rs.getInt("user_id"));
                user.setUsername(rs.getString("username"));
                user.setEmail(rs.getString("email"));
                user.setRole(rs.getString("role"));
                user.setProfilePictureUrl(rs.getString("profile_picture_url"));
                LOGGER.info("User fetched: " + user.getUsername());
                return user;
            }
            LOGGER.warning("No user found with ID: " + userId);
            return null;
        }
    }

    public boolean updateUser(int userId, String username, String email, String profilePictureUrl) throws Exception {
        LOGGER.info("Updating user with ID: " + userId);
        try (Connection conn = DatabaseUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(
                     "UPDATE users SET username = ?, email = ?, profile_picture_url = ? WHERE user_id = ?")) {
            stmt.setString(1, username);
            stmt.setString(2, email);
            stmt.setString(3, profilePictureUrl);
            stmt.setInt(4, userId);
            int rowsAffected = stmt.executeUpdate();
            if (rowsAffected > 0) {
                LOGGER.info("User updated successfully: " + username);
                return true;
            } else {
                LOGGER.warning("No user found with ID: " + userId);
                return false;
            }
        }
    }

    public boolean updatePassword(int userId, String newPassword) throws Exception {
        LOGGER.info("Updating password for user ID: " + userId);
        try (Connection conn = DatabaseUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(
                     "UPDATE users SET password_hash = ? WHERE user_id = ?")) {
            stmt.setString(1, newPassword);
            stmt.setInt(2, userId);
            int rowsAffected = stmt.executeUpdate();
            if (rowsAffected > 0) {
                LOGGER.info("Password updated successfully for user ID: " + userId);
                return true;
            } else {
                LOGGER.warning("No user found with ID: " + userId);
                return false;
            }
        }
    }

    public boolean deleteUser(int userId, String profilePictureUrl, String profilePhotoDir) throws Exception {
        LOGGER.info("Deleting user with ID: " + userId);
        try (Connection conn = DatabaseUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement("DELETE FROM users WHERE user_id = ?")) {
            stmt.setInt(1, userId);
            int rowsAffected = stmt.executeUpdate();
            if (rowsAffected > 0) {
                // Delete profile photo file if it exists
                if (profilePictureUrl != null && !profilePictureUrl.isEmpty()) {
                    // Remove any directory prefix from profilePictureUrl
                    String fileName = profilePictureUrl.replace("profile_photo/", "");
                    java.io.File photoFile = new java.io.File(profilePhotoDir + File.separator + fileName);
                    if (photoFile.exists()) {
                        if (photoFile.delete()) {
                            LOGGER.info("Profile photo deleted: " + fileName);
                        } else {
                            LOGGER.warning("Failed to delete profile photo: " + fileName);
                        }
                    } else {
                        LOGGER.warning("Profile photo file does not exist: " + photoFile.getAbsolutePath());
                    }
                }
                LOGGER.info("User deleted successfully: ID " + userId);
                return true;
            } else {
                LOGGER.warning("No user found with ID: " + userId);
                return false;
            }
        }
    }

    public boolean registerUser(String username, String email, String password, String role) throws Exception {
        LOGGER.info("Registering new user with email: " + email);
        try (Connection conn = DatabaseUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(
                     "INSERT INTO users (username, email, password_hash, role) VALUES (?, ?, ?, ?)")) {
            stmt.setString(1, username);
            stmt.setString(2, email);
            stmt.setString(3, password); // Plain text password
            stmt.setString(4, role);
            int rowsAffected = stmt.executeUpdate();
            if (rowsAffected > 0) {
                LOGGER.info("User registered successfully: " + username);
                return true;
            } else {
                LOGGER.warning("Failed to register user: " + username);
                return false;
            }
        }
    }

    public boolean isEmailTakenByOther(String email, int excludeUserId) throws Exception {
        LOGGER.info("Checking if email is taken: " + email);
        try (Connection conn = DatabaseUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement("SELECT COUNT(*) FROM users WHERE email = ? AND user_id != ?")) {
            stmt.setString(1, email);
            stmt.setInt(2, excludeUserId);
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    boolean isTaken = rs.getInt(1) > 0;
                    LOGGER.info("Email taken check result: " + isTaken);
                    return isTaken;
                }
            }
        }
        return false;
    }
}