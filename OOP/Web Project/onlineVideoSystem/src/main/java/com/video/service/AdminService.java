package com.video.service;

import com.video.model.Admin;
import com.video.util.DatabaseUtil;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class AdminService {

    public List<Admin> getAllAdmins() throws SQLException {
        List<Admin> admins = new ArrayList<>();
        String sql = "SELECT Id, UserName, Email, PhoneNumber, Password FROM admin_actions";
        try (Connection conn = DatabaseUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {
            while (rs.next()) {
                Admin admin = new Admin();
                admin.setId(rs.getInt("Id"));
                admin.setUserName(rs.getString("UserName"));
                admin.setEmail(rs.getString("Email"));
                admin.setPhoneNumber(rs.getString("PhoneNumber"));
                admin.setPassword(rs.getString("Password"));
                admins.add(admin);
            }
        }
        return admins;
    }

    public void addAdmin(Admin admin) throws SQLException {
        String sql = "INSERT INTO admin_actions (UserName, Email, PhoneNumber, Password) VALUES (?, ?, ?, ?)";
        try (Connection conn = DatabaseUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, admin.getUserName());
            stmt.setString(2, admin.getEmail());
            stmt.setString(3, admin.getPhoneNumber());
            stmt.setString(4, admin.getPassword());
            stmt.executeUpdate();
        }
    }

    public void deleteAdmin(int id) throws SQLException {
        String sql = "DELETE FROM admin_actions WHERE Id = ?";
        try (Connection conn = DatabaseUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, id);
            stmt.executeUpdate();
        }
    }

    public Admin getAdminById(int id) throws SQLException {
        String sql = "SELECT Id, UserName, Email, PhoneNumber, Password FROM admin_actions WHERE Id = ?";
        try (Connection conn = DatabaseUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, id);
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    Admin admin = new Admin();
                    admin.setId(rs.getInt("Id"));
                    admin.setUserName(rs.getString("UserName"));
                    admin.setEmail(rs.getString("Email"));
                    admin.setPhoneNumber(rs.getString("PhoneNumber"));
                    admin.setPassword(rs.getString("Password"));
                    return admin;
                }
            }
        }
        return null;
    }

    public void updateAdmin(Admin admin) throws SQLException {
        String sql = "UPDATE admin_actions SET UserName = ?, Email = ?, PhoneNumber = ?, Password = ? WHERE Id = ?";
        try (Connection conn = DatabaseUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, admin.getUserName());
            stmt.setString(2, admin.getEmail());
            stmt.setString(3, admin.getPhoneNumber());
            stmt.setString(4, admin.getPassword());
            stmt.setInt(5, admin.getId());
            stmt.executeUpdate();
        }
    }
}