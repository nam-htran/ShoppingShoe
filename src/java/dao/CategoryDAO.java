package dao;

import dto.CategoryDTO;
import dto.ProductDTO;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import utils.DBUtils;

/**
 * Handles database access logic for categories.
 */
public class CategoryDAO {

    public List<CategoryDTO> getAllCategories() {
        List<CategoryDTO> categories = new ArrayList<>();
        String query = "SELECT categoryId, categoryName FROM category";

        try (Connection conn = DBUtils.getConnection();
                PreparedStatement stmt = conn.prepareStatement(query);
                ResultSet rs = stmt.executeQuery()) {

            while (rs.next()) {
                CategoryDTO category = new CategoryDTO(
                        rs.getInt("categoryId"),
                        rs.getString("categoryName")
                );
                categories.add(category);
            }
        } catch (Exception e) {
            e.printStackTrace();
            throw new RuntimeException("Error fetching categories", e);
        }

        return categories;
    }
    
    public CategoryDTO getCategoryByID(int id) {
        String sql = " select * from category where categoryId = ?";
        try (Connection con = DBUtils.getConnection();
                PreparedStatement stmt = con.prepareStatement(sql)) {
            stmt.setInt(1, id);
            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                return new CategoryDTO(
                        rs.getInt("categoryId"),
                        rs.getString("categoryName"));
            }
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
        return null;
    }

    public boolean updateCategory(CategoryDTO category) {
        String updateProductSQL = " UPDATE category SET categoryName = ? WHERE categoryId = ? ";

        try {
            Connection conn = DBUtils.getConnection();
            // Cập nhật thông tin sản phẩm
            PreparedStatement stmt = conn.prepareStatement(updateProductSQL);

            stmt.setInt(1, category.getCategoryId());
            stmt.setString(2, category.getCategoryName());

            stmt.executeUpdate();
            conn.close();
            
            return true;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }
 
    public Integer insertCategory(CategoryDTO category){
        String sql = "INSERT INTO category (categoryId, categoryName) VALUES (?,?)";
        
        try {
            
            Connection conn = DBUtils.getConnection();
            PreparedStatement ps = conn.prepareStatement(sql);                      
            
            ps.setInt(1, category.getCategoryId());
            ps.setString(2, category.getCategoryName());

            ps.executeUpdate();
            conn.close();
            
            return category.getCategoryId();
	}
        catch (SQLException ex) {
            System.out.println("Create Category error!" + ex.getMessage());
            ex.printStackTrace();
        }
        return null;
    }

    public void delete(Integer id) {
        try {
            Connection con = DBUtils.getConnection();
            String sql = " DELETE FROM category WHERE categoryId = ? ";
            PreparedStatement stm = con.prepareStatement(sql);
            stm.setInt(1, id);
            stm.executeUpdate();
        } catch (SQLException e) {
            System.out.println(e.getMessage());
        }
    }

}
