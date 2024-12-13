package dao;

import dto.UserDTO;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import utils.DBUtils;

public class UserDAO {

    // Check user login credentials
    public UserDTO checkLogin(String phone, String password) throws SQLException, ClassNotFoundException {
        String sql = "SELECT * FROM Users WHERE phone = ? AND password = ?";
        try (Connection conn = DBUtils.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, phone);
            ps.setString(2, password);

            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
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
            }
        }
        return null; // Return null if no matching user is found
    }

    // Register a new user
    public boolean registerUser(UserDTO user) throws SQLException, ClassNotFoundException {
        String sql = "INSERT INTO Users(fullname, email, phone, username, password, address, role) VALUES (?, ?, ?, ?, ?, ?, ?)";
        try (Connection conn = DBUtils.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, user.getFullname());
            ps.setString(2, user.getEmail());
            ps.setString(3, user.getPhone());
            ps.setString(4, user.getUsername());
            ps.setString(5, user.getPassword());
            ps.setString(6, user.getAddress());
            ps.setString(7, user.getRole()); // Default role should be passed by the controller
            return ps.executeUpdate() > 0;
        }
    }
    
    
    public boolean insertUser(UserDTO user) throws SQLException, ClassNotFoundException {
        String sql = "INSERT INTO Users(fullname, email, phone, username, password, address, role) VALUES (?, ?, ?, ?, ?, ?, ?)";
        try (Connection conn = DBUtils.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, user.getFullname());
            ps.setString(2, user.getEmail());
            ps.setString(3, user.getPhone());
            ps.setString(4, user.getUsername());
            ps.setString(5, user.getPassword());
            ps.setString(6, user.getAddress());
            ps.setString(7, user.getRole());
            return ps.executeUpdate() > 0;
        }
    }

    // Check if a user exists by phone or email
    public boolean checkUserExists(String phone, String email) throws SQLException {
        String sql = "SELECT COUNT(*) FROM Users WHERE phone = ? OR email = ?";
        try (Connection conn = DBUtils.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, phone);
            ps.setString(2, email);

            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return rs.getInt(1) > 0; // Return true if count > 0
                }
            }
        }
        return false; // Return false if no user exists
    }

    // Update user account information
    public boolean updateUserAccount(UserDTO user) throws SQLException {
        String sql = "UPDATE Users SET fullname = ?, email = ?, phone = ?, username = ?, address = ? WHERE userId = ?";
        try (Connection conn = DBUtils.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, user.getFullname());
            ps.setString(2, user.getEmail());
            ps.setString(3, user.getPhone());
            ps.setString(4, user.getUsername());
            ps.setString(5, user.getAddress());
            ps.setInt(6, user.getUserId());

            return ps.executeUpdate() > 0; // Return true if at least one row was updated
        }
    }

    // Retrieve user information by ID (optional helper method)
    public UserDTO getUserById(int userId) throws SQLException {
        String sql = "SELECT * FROM Users WHERE userId = ?";
        try (Connection conn = DBUtils.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, userId);

            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
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
            }
        }
        return null; // Return null if no user is found
    }
    
    public boolean updateUserPassword(UserDTO user) throws SQLException {
        String sql = "UPDATE Users SET password = ? WHERE userId = ?";
        try (Connection conn = DBUtils.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, user.getPassword());
            ps.setInt(2, user.getUserId());

            int rowsAffected = ps.executeUpdate();
            return rowsAffected > 0;
        }
    }
    public boolean updateUserAddress(UserDTO user) throws Exception {
        try (Connection conn = DBUtils.getConnection()) {
            String query = "UPDATE users SET address = ? WHERE userId = ?";
            PreparedStatement stmt = conn.prepareStatement(query);
            stmt.setString(1, user.getAddress());
            stmt.setInt(2, user.getUserId());
            
            return stmt.executeUpdate() > 0;
        }
    }
    public List<UserDTO> getAllUsers() throws Exception {
        List<UserDTO> users = new ArrayList<>();
        String query = "SELECT userId, fullname, email, phone, username, address, role FROM users";

        try (Connection conn = DBUtils.getConnection();
             PreparedStatement ps = conn.prepareStatement(query)) {

            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    int id = rs.getInt("userId");
                    String fullname = rs.getString("fullname");
                    String email = rs.getString("email");
                    String phone = rs.getString("phone");
                    String username = rs.getString("username");
                    String address = rs.getString("address");
                    String role = rs.getString("role");

                    UserDTO user = new UserDTO(id, fullname, email, phone, username, null, address, role);
                    users.add(user);
                }
            }
        } catch (Exception e) {
            throw new Exception("Error retrieving users: " + e.getMessage(), e);
        }

        return users;
    }
    
    public void deleteUser(int userId) {
        Connection conn = null;
        PreparedStatement deleteCartStmt = null;
        PreparedStatement deleteUserStmt = null;

        try {
            conn = DBUtils.getConnection();

            // Start a transaction
            conn.setAutoCommit(false);

            // Step 1: Delete dependent records in cart table
            String deleteCartQuery = "DELETE FROM cart WHERE userId = ?";
            deleteCartStmt = conn.prepareStatement(deleteCartQuery);
            deleteCartStmt.setInt(1, userId);
            deleteCartStmt.executeUpdate();

            // Step 2: Delete the user record
            String deleteUserQuery = "DELETE FROM Users WHERE userId = ?";
            deleteUserStmt = conn.prepareStatement(deleteUserQuery);
            deleteUserStmt.setInt(1, userId);
            deleteUserStmt.executeUpdate();

            // Commit the transaction
            conn.commit();
        } catch (Exception e) {
            e.printStackTrace();
            try {
                if (conn != null) {
                    conn.rollback(); // Rollback if any exception occurs
                }
            } catch (Exception rollbackEx) {
                rollbackEx.printStackTrace();
            }
        } finally {
            try {
                if (deleteCartStmt != null) deleteCartStmt.close();
                if (deleteUserStmt != null) deleteUserStmt.close();
                if (conn != null) conn.setAutoCommit(true); // Restore auto-commit behavior
                if (conn != null) conn.close();
            } catch (Exception closeEx) {
                closeEx.printStackTrace();
            }
        }
    }
    

}
