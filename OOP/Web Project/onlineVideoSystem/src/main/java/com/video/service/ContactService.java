package com.video.service;

import com.video.model.Contact;
import com.video.util.DatabaseUtil;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Logger;

public class ContactService {
    private static final Logger LOGGER = Logger.getLogger(ContactService.class.getName());

    public void addContact(Contact contact) throws SQLException {
        // Validate input
        if (contact.getName() == null || contact.getName().trim().isEmpty() ||
            contact.getEmail() == null || !contact.getEmail().matches("^[A-Za-z0-9+_.-]+@(.+)$") ||
            contact.getSubject() == null || contact.getSubject().trim().isEmpty() ||
            contact.getMessage() == null || contact.getMessage().trim().isEmpty()) {
            throw new IllegalArgumentException("Invalid contact details");
        }

        String query = "INSERT INTO messages (name, email, subject, message, status, handled_by) VALUES (?, ?, ?, ?, ?, ?)";
        try (Connection conn = DatabaseUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(query)) {
            stmt.setString(1, contact.getName().trim());
            stmt.setString(2, contact.getEmail().trim());
            stmt.setString(3, contact.getSubject().trim());
            stmt.setString(4, contact.getMessage().trim());
            stmt.setString(5, contact.getStatus() != null ? contact.getStatus() : "Pending");
            stmt.setString(6, contact.getHandledBy() != null ? contact.getHandledBy() : "Auto");
            stmt.executeUpdate();
            LOGGER.info("Contact added successfully for email: " + contact.getEmail());
        } catch (SQLException e) {
            LOGGER.severe("Error adding contact for email " + contact.getEmail() + ": " + e.getMessage());
            throw e;
        }
    }

    public List<Contact> getAllContacts() throws SQLException {
        List<Contact> contacts = new ArrayList<>();
        String query = "SELECT * FROM messages";
        try (Connection conn = DatabaseUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(query);
             ResultSet rs = stmt.executeQuery()) {
            while (rs.next()) {
                Contact contact = new Contact();
                contact.setMessageId(rs.getInt("message_id"));
                contact.setName(rs.getString("name"));
                contact.setEmail(rs.getString("email"));
                contact.setSubject(rs.getString("subject"));
                contact.setMessage(rs.getString("message"));
                contact.setStatus(rs.getString("status"));
                contact.setHandledBy(rs.getString("handled_by"));
                contact.setInternalNotes(rs.getString("internal_notes"));
                contact.setCreatedAt(rs.getTimestamp("created_at"));
                contact.setUpdatedAt(rs.getTimestamp("updated_at"));
                contacts.add(contact);
            }
            LOGGER.info("Retrieved " + contacts.size() + " contacts.");
            return contacts;
        } catch (SQLException e) {
            LOGGER.severe("Error retrieving contacts: " + e.getMessage());
            throw e;
        }
    }

    public Contact getContactById(int id) throws SQLException {
        String query = "SELECT * FROM messages WHERE message_id = ?";
        try (Connection conn = DatabaseUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(query)) {
            stmt.setInt(1, id);
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    Contact contact = new Contact();
                    contact.setMessageId(rs.getInt("message_id"));
                    contact.setName(rs.getString("name"));
                    contact.setEmail(rs.getString("email"));
                    contact.setSubject(rs.getString("subject"));
                    contact.setMessage(rs.getString("message"));
                    contact.setStatus(rs.getString("status"));
                    contact.setHandledBy(rs.getString("handled_by"));
                    contact.setInternalNotes(rs.getString("internal_notes"));
                    contact.setCreatedAt(rs.getTimestamp("created_at"));
                    contact.setUpdatedAt(rs.getTimestamp("updated_at"));
                    LOGGER.info("Retrieved contact with ID: " + id);
                    return contact;
                }
                LOGGER.warning("No contact found with ID: " + id);
                return null;
            }
        } catch (SQLException e) {
            LOGGER.severe("Error retrieving contact with ID " + id + ": " + e.getMessage());
            throw e;
        }
    }

    public void updateContact(Contact contact) throws SQLException {
        // Validate status
        if (contact.getStatus() != null && !contact.getStatus().matches("Pending|Resolved")) {
            throw new IllegalArgumentException("Invalid status: must be 'Pending' or 'Resolved'");
        }

        String query = "UPDATE messages SET status = ?, handled_by = ?, internal_notes = ? WHERE message_id = ?";
        try (Connection conn = DatabaseUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(query)) {
            stmt.setString(1, contact.getStatus() != null ? contact.getStatus() : "Pending");
            stmt.setString(2, contact.getHandledBy() != null ? contact.getHandledBy() : "Auto");
            stmt.setString(3, contact.getInternalNotes());
            stmt.setInt(4, contact.getMessageId());
            stmt.executeUpdate();
            LOGGER.info("Updated contact with ID: " + contact.getMessageId());
        } catch (SQLException e) {
            LOGGER.severe("Error updating contact with ID " + contact.getMessageId() + ": " + e.getMessage());
            throw e;
        }
    }

    public void deleteContact(int id) throws SQLException {
        String query = "DELETE FROM messages WHERE message_id = ?";
        try (Connection conn = DatabaseUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(query)) {
            stmt.setInt(1, id);
            int rowsAffected = stmt.executeUpdate();
            if (rowsAffected > 0) {
                LOGGER.info("Deleted contact with ID: " + id);
            } else {
                LOGGER.warning("No contact found with ID: " + id);
            }
        } catch (SQLException e) {
            LOGGER.severe("Error deleting contact with ID " + id + ": " + e.getMessage());
            throw e;
        }
    }

    // Moved to a separate service or clarified as needed
    public boolean authenticateOfficer(String username, String password) throws SQLException {
        if (username == null || password == null || username.trim().isEmpty() || password.trim().isEmpty()) {
            LOGGER.warning("Authentication failed: Invalid username or password");
            return false;
        }
        String query = "SELECT * FROM admin_actions WHERE userName = ? AND password = ?";
        try (Connection conn = DatabaseUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(query)) {
            stmt.setString(1, username.trim());
            stmt.setString(2, password.trim());
            try (ResultSet rs = stmt.executeQuery()) {
                boolean authenticated = rs.next();
                LOGGER.info("Authentication attempt for username " + username + ": " + (authenticated ? "Success" : "Failed"));
                return authenticated;
            }
        } catch (SQLException e) {
            LOGGER.severe("Error authenticating officer for username " + username + ": " + e.getMessage());
            throw e;
        }
    }
}