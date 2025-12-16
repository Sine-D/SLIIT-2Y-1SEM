package com.video.util;


import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.util.logging.Logger;

public class DatabaseUtil {
    private static final Logger LOGGER = Logger.getLogger(DatabaseUtil.class.getName());
    private static final String URL = "jdbc:mysql://localhost:3306/Online_Video";
    private static final String USER = "root"; 
    private static final String PASSWORD = "1211"; 

    static {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            LOGGER.info("MySQL JDBC Driver loaded");
        } catch (ClassNotFoundException e) {
            LOGGER.severe("Failed to load MySQL JDBC Driver: " + e.getMessage());
        }
    }

    public static Connection getConnection() throws SQLException {
        try {
            LOGGER.info("Establishing database connection to: " + URL);
            Connection conn = DriverManager.getConnection(URL, USER, PASSWORD);
            LOGGER.info("Database connection established");
            return conn;
        } catch (SQLException e) {
            LOGGER.severe("Failed to connect to database: " + e.getMessage());
            throw e;
        }
    }
}