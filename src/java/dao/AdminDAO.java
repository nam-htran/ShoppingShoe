package dao;

import dto.UserDTO;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import utils.DBUtils;

public class AdminDAO {

    // Validate admin credentials
    public boolean validateAdmin(String username, String password) {
        String query = "SELECT * FROM users WHERE username = ? AND password = ? AND role = 'admin'";
        try (Connection conn = DBUtils.getConnection();
             PreparedStatement ps = conn.prepareStatement(query)) {
            ps.setString(1, username);
            ps.setString(2, password);

            try (ResultSet rs = ps.executeQuery()) {
                return rs.next();
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    // Authenticate login credentials
    public UserDTO checkLogin(String username, String password) {
        String query = "SELECT * FROM users WHERE username = ? AND password = ?";
        try (Connection conn = DBUtils.getConnection();
             PreparedStatement ps = conn.prepareStatement(query)) {
            ps.setString(1, username);
            ps.setString(2, password);

            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return mapResultSetToUser(rs);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    // Get all users
    public List<UserDTO> getAllUsers() {
        List<UserDTO> userList = new ArrayList<>();
        String query = "SELECT * FROM users";

        try (Connection conn = DBUtils.getConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(query)) {

            while (rs.next()) {
                userList.add(mapResultSetToUser(rs));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return userList;
    }

    // Insert a new user
    public boolean insertUser(UserDTO user) {
        String query = "INSERT INTO users (fullname, email, phone, username, password, address, role) VALUES (?, ?, ?, ?, ?, ?, ?)";
        try (Connection conn = DBUtils.getConnection();
             PreparedStatement ps = conn.prepareStatement(query)) {

            ps.setString(1, user.getFullname());
            ps.setString(2, user.getEmail());
            ps.setString(3, user.getPhone());
            ps.setString(4, user.getUsername());
            ps.setString(5, user.getPassword());
            ps.setString(6, user.getAddress());
            ps.setString(7, user.getRole());

            ps.executeUpdate();
            return true;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

public boolean deleteUser(int userId) {
    Connection conn = null;
    PreparedStatement deleteUserStmt = null;

    try {
        conn = DBUtils.getConnection();

        // Step 1: Delete the user from the users table
        String deleteUserQuery = "DELETE FROM users WHERE userId = ?";
        deleteUserStmt = conn.prepareStatement(deleteUserQuery);
        deleteUserStmt.setInt(1, userId);
        int userRowsAffected = deleteUserStmt.executeUpdate();

        // Return true if the user was deleted
        return userRowsAffected > 0; // Return true if user is deleted, false otherwise
    } catch (SQLException e) {
        e.printStackTrace(); // Log the error
    } finally {
        // Ensure resources are closed
        try {
            if (deleteUserStmt != null) deleteUserStmt.close();
            if (conn != null) conn.close();
        } catch (SQLException closeEx) {
            closeEx.printStackTrace();
        }
    }
    return false; // Return false if an exception occurred or no rows were affected
}



    // Map result set to DTO
    private UserDTO mapResultSetToUser(ResultSet rs) throws SQLException {
        return new UserDTO(
            rs.getInt("userId"),
            rs.getString("fullname"),
            rs.getString("email"),
            rs.getString("phone"),
            rs.getString("username"),
            rs.getString("password"),
            rs.getString("address"),
            rs.getString("role")
        );
    }
    public boolean updateUser(UserDTO user) {
        String query = "UPDATE users SET fullname = ?, phone = ?, email = ?, username = ?, address = ?, role = ? WHERE userId = ?";
        try (Connection conn = DBUtils.getConnection();
             PreparedStatement stmt = conn.prepareStatement(query)) {
            stmt.setString(1, user.getFullname());
            stmt.setString(2, user.getPhone());
            stmt.setString(3, user.getEmail());
            stmt.setString(4, user.getUsername());
            stmt.setString(5, user.getAddress());
            stmt.setString(6, user.getRole());
            stmt.setInt(7, user.getUserId());

            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
}
    public UserDTO getUserById(int userId) {
        String query = "SELECT * FROM users WHERE userId = ?";
        try (Connection conn = DBUtils.getConnection();
             PreparedStatement stmt = conn.prepareStatement(query)) {

            stmt.setInt(1, userId);
            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                UserDTO user = new UserDTO();
                user.setUserId(rs.getInt("userId"));
                user.setFullname(rs.getString("fullname"));
                user.setPhone(rs.getString("phone"));
                user.setEmail(rs.getString("email"));
                user.setUsername(rs.getString("username"));
                user.setAddress(rs.getString("address"));
                user.setRole(rs.getString("role"));
                return user;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null; // Return null if no user is found
}
}
