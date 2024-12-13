package dao;

import dto.CartItemDTO;
import dto.OrderDTO;
import dto.OrderDetailDTO;
import utils.DBUtils;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

public class OrderDAO {

    private static final Logger logger = Logger.getLogger(OrderDAO.class.getName());

    /**
     * Fetch transaction history from the orders table
     */
    public List<OrderDTO> getTransactionHistory() {
        List<OrderDTO> orderList = new ArrayList<>();
        String query = "SELECT * FROM orders";

        try (Connection connection = DBUtils.getConnection();
             PreparedStatement stmt = connection.prepareStatement(query);
             ResultSet rs = stmt.executeQuery()) {

            while (rs.next()) {
                OrderDTO order = new OrderDTO();
                order.setOrderId(rs.getInt("orderId"));
                order.setUserId(rs.getInt("userId"));
                order.setOrderDate(rs.getTimestamp("orderDate"));
                order.setTotalPrice(rs.getDouble("totalPrice"));
                order.setAddress(rs.getString("address"));
                order.setStatus(rs.getString("status"));

                orderList.add(order);
            }

        } catch (Exception e) {
            logger.log(Level.SEVERE, "Error fetching transaction history", e);
        }

        return orderList;
    }
    public List<OrderDTO> getTransactionHistoryByUser(int userId) {
    List<OrderDTO> orderList = new ArrayList<>();
    String query = "SELECT * FROM orders WHERE userId = ?";

    try (Connection connection = DBUtils.getConnection();
         PreparedStatement stmt = connection.prepareStatement(query)) {

        stmt.setInt(1, userId);
        try (ResultSet rs = stmt.executeQuery()) {
            while (rs.next()) {
                OrderDTO order = new OrderDTO();
                order.setOrderId(rs.getInt("orderId"));
                order.setUserId(rs.getInt("userId"));
                order.setOrderDate(rs.getTimestamp("orderDate"));
                order.setTotalPrice(rs.getDouble("totalPrice"));
                order.setAddress(rs.getString("address"));
                order.setStatus(rs.getString("status"));

                orderList.add(order);
            }
        }
    } catch (SQLException e) {
        logger.log(Level.SEVERE, "Error fetching transaction history for user", e);
    }
    return orderList;
}


    /**
     * Delete order and its details with proper transaction handling
     */
    public void deleteOrder(String orderId) {
        if (orderId == null || orderId.trim().isEmpty()) {
            logger.log(Level.WARNING, "Invalid orderId provided");
            return;
        }

        try (Connection conn = DBUtils.getConnection()) {
            conn.setAutoCommit(false);

            try (PreparedStatement deleteOrderDetailsStmt = conn.prepareStatement("DELETE FROM order_detail WHERE orderId = ?");
                 PreparedStatement deleteOrderStmt = conn.prepareStatement("DELETE FROM orders WHERE orderId = ?")) {

                deleteOrderDetailsStmt.setInt(1, Integer.parseInt(orderId));
                deleteOrderDetailsStmt.executeUpdate();

                deleteOrderStmt.setInt(1, Integer.parseInt(orderId));
                deleteOrderStmt.executeUpdate();

                conn.commit();
            } catch (Exception e) {
                conn.rollback();
                logger.log(Level.SEVERE, "Transaction rolled back due to error", e);
            }
        } catch (Exception e) {
            logger.log(Level.SEVERE, "Error connecting to database", e);
        }
    }

    /**
     * Update order status
     */
    public void updateOrderStatus(String orderId, String status) {
        if (orderId == null || orderId.trim().isEmpty()) {
            logger.log(Level.WARNING, "Invalid orderId provided");
            return;
        }

        String query = "UPDATE orders SET status = ? WHERE orderId = ?";

        try (Connection conn = DBUtils.getConnection();
             PreparedStatement stmt = conn.prepareStatement(query)) {

            stmt.setString(1, status);
            stmt.setInt(2, Integer.parseInt(orderId));
            int rowsUpdated = stmt.executeUpdate();

            if (rowsUpdated == 0) {
                logger.log(Level.WARNING, "No order found with orderId: " + orderId);
            }

        } catch (Exception e) {
            logger.log(Level.SEVERE, "Error updating order status", e);
        }
    }

    /**
     * Insert a new order and return its generated orderId
     */
    public int insertOrder(OrderDTO order) {
        String insertOrderSQL = "INSERT INTO orders (userId, orderDate, totalPrice, address, status) VALUES (?, GETDATE(), ?, ?, ?)";

        try (Connection conn = DBUtils.getConnection();
             PreparedStatement stmt = conn.prepareStatement(insertOrderSQL, PreparedStatement.RETURN_GENERATED_KEYS)) {
            stmt.setInt(1, order.getUserId());
            stmt.setDouble(2, order.getTotalPrice());
            stmt.setString(3, order.getAddress());
            stmt.setString(4, order.getStatus());

            stmt.executeUpdate();

            try (ResultSet rs = stmt.getGeneratedKeys()) {
                if (rs.next()) {
                    return rs.getInt(1);
                }
            }
        } catch (Exception e) {
            logger.log(Level.SEVERE, "Error inserting new order", e);
        }
        return -1;
    }

    /**
     * Insert order details into the database for each cart item
     */
    public void insertOrderDetails(int orderId, List<CartItemDTO> cartItems) {
        String insertDetailSQL = "INSERT INTO order_detail (orderId, productId, quantity, price) VALUES (?, ?, ?, ?)";

        try (Connection conn = DBUtils.getConnection();
             PreparedStatement stmt = conn.prepareStatement(insertDetailSQL)) {

            for (CartItemDTO item : cartItems) {
                stmt.setInt(1, orderId);
                stmt.setInt(2, item.getProductId());
                stmt.setInt(3, item.getQuantity());
                stmt.setDouble(4, item.getPrice());
                stmt.executeUpdate();
            }

        } catch (Exception e) {
            logger.log(Level.SEVERE, "Error inserting order details", e);
        }
    }

}
