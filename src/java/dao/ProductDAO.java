package dao;

import dto.ProductDTO;
import utils.DBUtils;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class ProductDAO {

    // Method to retrieve all products with their sizes (stored as a comma-separated string)
    public List<ProductDTO> getAllProducts() {
        List<ProductDTO> products = new ArrayList<>();
        String query = "SELECT productId, productName, FORMAT(price, 'N0') + ' VND' AS price, quantity, img, color, categoryId, isAvailable, sizes FROM products";

        try (Connection conn = DBUtils.getConnection();
             PreparedStatement stmt = conn.prepareStatement(query);
             ResultSet rs = stmt.executeQuery()) {

            while (rs.next()) {
                ProductDTO product = new ProductDTO(
                        rs.getInt("productId"),
                        rs.getString("productName"),
                        rs.getString("price"),  // Giá đã được format từ SQL
                        rs.getInt("quantity"),
                        rs.getString("img"),
                        rs.getString("color"),
                        rs.getInt("categoryId"),
                        rs.getBoolean("isAvailable"),
                        rs.getString("sizes")
                );
                products.add(product);
            }
        } catch (SQLException e) {
            e.printStackTrace();
            throw new RuntimeException("Error fetching products", e);
        }
        return products;
    }

    // Get product by ID with formatted price
    public ProductDTO getProductByID(int id) {
        String sql = "SELECT productId, productName, FORMAT(price, 'N0') + ' VND' AS price, quantity, img, color, categoryId, isAvailable, sizes FROM products WHERE productId = ?";

        try (Connection conn = DBUtils.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, id);
            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                return new ProductDTO(
                        rs.getInt("productId"),
                        rs.getString("productName"),
                        rs.getString("price"),  // Giá đã được format từ SQL
                        rs.getInt("quantity"),
                        rs.getString("img"),
                        rs.getString("color"),
                        rs.getInt("categoryId"),
                        rs.getBoolean("isAvailable"),
                        rs.getString("sizes")
                );
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null; 
    }

    // Update Product details (including sizes as a comma-separated string)
    public boolean updateProduct(ProductDTO product) {
        String updateProductSQL = "UPDATE products SET productName = ?, price = ?, quantity = ?, color = ?, img = ?, categoryId = ?, isAvailable = ?, sizes = ? WHERE productId = ?";

        try (Connection conn = DBUtils.getConnection();
             PreparedStatement stmt = conn.prepareStatement(updateProductSQL)) {

            stmt.setString(1, product.getProductName());
            stmt.setString(2, product.getPrice());  // Price is passed as already formatted string
            stmt.setInt(3, product.getQuantity());
            stmt.setString(4, product.getColor());
            stmt.setString(5, product.getImg());
            stmt.setInt(6, product.getCategoryId());
            stmt.setBoolean(7, product.getIsAvailable());
            stmt.setString(8, product.getSizes());  // Directly set sizes as a string
            stmt.setInt(9, product.getProductId());

            stmt.executeUpdate();
            return true;
            
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    // Insert a new product (sizes are passed as a string)
    public Integer insertProduct(ProductDTO product) {
        String sql = "INSERT INTO products (productName, price, quantity, color, img, categoryId, isAvailable, sizes) VALUES (?,?,?,?,?,?,?,?)";

        try (Connection conn = DBUtils.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {

            ps.setString(1, product.getProductName());
            ps.setString(2, product.getPrice());  // Price is passed as already formatted string
            ps.setInt(3, product.getQuantity());
            ps.setString(4, product.getColor());
            ps.setString(5, product.getImg());
            ps.setInt(6, product.getCategoryId());
            ps.setBoolean(7, product.getIsAvailable());
            ps.setString(8, product.getSizes());  // Insert sizes directly
            
            ps.executeUpdate();

            ResultSet rs = ps.getGeneratedKeys();
            if (rs.next()) {
                return rs.getInt(1);  // Return the generated ID of the new product
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    // Delete Product by ID
    public boolean deleteProduct(int productId) {
        String deleteFromOrderDetailSQL = "DELETE FROM order_detail WHERE productId = ?";
        String deleteFromProductsSQL = "DELETE FROM products WHERE productId = ?";

        try (Connection conn = DBUtils.getConnection()) {
            // Begin transaction
            conn.setAutoCommit(false);

            // Step 1: Delete from order_detail table
            try (PreparedStatement orderDetailStmt = conn.prepareStatement(deleteFromOrderDetailSQL)) {
                orderDetailStmt.setInt(1, productId);
                orderDetailStmt.executeUpdate();
            }

            // Step 2: Delete product from products table
            try (PreparedStatement productStmt = conn.prepareStatement(deleteFromProductsSQL)) {
                productStmt.setInt(1, productId);
                int rowsAffected = productStmt.executeUpdate();

                if (rowsAffected > 0) {
                    conn.commit(); // Commit if the product was successfully deleted
                    return true;
                } else {
                    conn.rollback(); // Rollback if product was not deleted
                }
            }

        } catch (SQLException ex) {
            ex.printStackTrace();
            // Rollback on error
            try (Connection rollbackConn = DBUtils.getConnection()) {
                rollbackConn.rollback();
            } catch (SQLException rollbackEx) {
                rollbackEx.printStackTrace();
            }
        }
        return false; // Return false if deletion failed
    }

    // Search products by name
    public List<ProductDTO> searchProducts(String searchTerm) {
        List<ProductDTO> products = new ArrayList<>();
        String query = "SELECT productId, productName, FORMAT(price, 'N0') + ' VND' AS price, quantity, img, color, categoryId, isAvailable, sizes FROM products WHERE productName LIKE ?";

        try (Connection conn = DBUtils.getConnection();
             PreparedStatement stmt = conn.prepareStatement(query)) {

            stmt.setString(1, "%" + searchTerm + "%");
            ResultSet rs = stmt.executeQuery();

            while (rs.next()) {
                ProductDTO product = new ProductDTO(
                        rs.getInt("productId"),
                        rs.getString("productName"),
                        rs.getString("price"),  // Giá đã được format từ SQL
                        rs.getInt("quantity"),
                        rs.getString("img"),
                        rs.getString("color"),
                        rs.getInt("categoryId"),
                        rs.getBoolean("isAvailable"),
                        rs.getString("sizes")
                );
                products.add(product);
            }
        } catch (SQLException e) {
            e.printStackTrace();
            throw new RuntimeException("Error fetching products", e);
        }
        return products;
    }
    
    // Check if the product is referenced in any order details
    public boolean isProductReferencedInOrderDetails(int productId) {
        String sql = "SELECT COUNT(*) FROM order_details WHERE productId = ?";
        try (Connection conn = DBUtils.getConnection(); 
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, productId);
            ResultSet rs = stmt.executeQuery();
            if (rs.next() && rs.getInt(1) > 0) {
                return true;  // Product is referenced in order_detail
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;  // No references found
    }

    // Check if category exists
    public boolean categoryExists(int categoryId) {
        String query = "SELECT COUNT(*) FROM dbo.category WHERE categoryId = ?";
        try (Connection conn = DBUtils.getConnection(); PreparedStatement ps = conn.prepareStatement(query)) {
            ps.setInt(1, categoryId);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return rs.getInt(1) > 0;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }
}
