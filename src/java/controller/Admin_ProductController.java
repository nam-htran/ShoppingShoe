package controller;

import dao.ProductDAO;
import dto.ProductDTO;
import dto.UserDTO;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

@WebServlet(name = "Admin_ProductController", urlPatterns = {"/admin_product_management", "/admin_edit_product"})
public class Admin_ProductController extends HttpServlet {

    private static final Logger LOGGER = Logger.getLogger(Admin_ProductController.class.getName());
    private final ProductDAO productDAO = new ProductDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        if (!isAdmin(request, response)) {
            return;
        }

        String action = request.getRequestURI().substring(request.getContextPath().length());

        if ("/admin_product_management".equals(action)) {
            handleProductManagement(request, response);
        } else if ("/admin_edit_product".equals(action)) {
            handleEditProduct(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        if (!isAdmin(request, response)) {
            return;
        }

        String action = request.getParameter("action");

        try {
            switch (action) {
                case "add":
                    handleAddProduct(request);
                    break;
                case "update":
                    handleUpdateProduct(request);
                    break;
                case "delete":
                    handleDeleteProduct(request);
                    break;
                default:
                    LOGGER.warning("Unknown action: " + action);
                    response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid action.");
                    return;
            }

            response.sendRedirect("admin_product_management");

        } catch (Exception e) {
            LOGGER.log(Level.SEVERE, "Error processing action: " + action, e);
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "An error occurred while processing your request.");
        }
    }

    /**
     * Check if the logged-in user is an admin.
     */
    private boolean isAdmin(HttpServletRequest request, HttpServletResponse response) throws IOException {
        HttpSession session = request.getSession(false); // Retrieve the existing session, if any
        if (session == null) {
            LOGGER.warning("Unauthorized access attempt: No session found.");
            response.sendError(HttpServletResponse.SC_FORBIDDEN, "Access denied. Please log in.");
            return false;
        }

        UserDTO user = (UserDTO) session.getAttribute("user"); // Retrieve the user object from the session
        if (user == null || !"admin".equals(user.getRole())) {
            LOGGER.warning("Unauthorized access attempt: User is not an admin.");
            response.sendError(HttpServletResponse.SC_FORBIDDEN, "Access denied. Admin role required.");
            return false;
        }

        return true;
    }

    /**
     * Handle the product management page.
     */
    private void handleProductManagement(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            String searchTerm = request.getParameter("search");
            List<ProductDTO> products = (searchTerm != null && !searchTerm.trim().isEmpty())
                    ? productDAO.searchProducts(searchTerm)
                    : productDAO.getAllProducts();

            request.setAttribute("products", products);
            request.getRequestDispatcher("admin_product_management.jsp").forward(request, response);
        } catch (Exception e) {
            LOGGER.log(Level.SEVERE, "Error retrieving products", e);
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Unable to retrieve products.");
        }
    }

    /**
     * Handle the edit product form.
     */
    private void handleEditProduct(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String productIdParam = request.getParameter("productId");

        if (productIdParam == null || productIdParam.isEmpty()) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Product ID is missing.");
            return;
        }

        int productId;
        try {
            productId = Integer.parseInt(productIdParam);
        } catch (NumberFormatException e) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid Product ID.");
            return;
        }

        // Retrieve product details by ID
        ProductDTO product = productDAO.getProductByID(productId);

        if (product == null) {
            response.sendError(HttpServletResponse.SC_NOT_FOUND, "Product not found.");
            return;
        }

        // Set product attributes for the JSP page
        request.setAttribute("product", product);
        request.getRequestDispatcher("edit_product.jsp").forward(request, response); // Forward to the JSP page
    }

    /**
     * Handle adding a new product.
     */
    private void handleAddProduct(HttpServletRequest request) {
        String name = request.getParameter("productName");
        String priceStr = request.getParameter("price");
        String quantityStr = request.getParameter("quantity");
        String color = request.getParameter("color");
        String img = request.getParameter("img");
        String categoryIdStr = request.getParameter("categoryId");
        String isAvailableStr = request.getParameter("isAvailable");
        String sizes = request.getParameter("sizes");

        // Input validation
        if (name == null || priceStr == null || quantityStr == null || categoryIdStr == null) {
            throw new IllegalArgumentException("Missing required fields.");
        }

        try {
            double price = Double.parseDouble(priceStr);
            int quantity = Integer.parseInt(quantityStr);
            int categoryId = Integer.parseInt(categoryIdStr);
            boolean isAvailable = Boolean.parseBoolean(isAvailableStr);

            // Check if category ID exists
            if (!productDAO.categoryExists(categoryId)) {
                throw new IllegalArgumentException("Invalid category ID.");
            }

            ProductDTO newProduct = new ProductDTO();
            newProduct.setProductName(name);
            newProduct.setPrice(String.valueOf(price));
            newProduct.setQuantity(quantity);
            newProduct.setColor(color);
            newProduct.setImg(img);
            newProduct.setCategoryId(categoryId);
            newProduct.setAvailable(isAvailable);
            newProduct.setSizes(sizes);  // Set sizes

            productDAO.insertProduct(newProduct);
        } catch (NumberFormatException e) {
            LOGGER.warning("Invalid number format in input fields.");
            throw new IllegalArgumentException("Invalid input format for price, quantity, or categoryId.");
        }
    }

    /**
     * Handle updating an existing product.
     */
    private void handleUpdateProduct(HttpServletRequest request) {
        try {
            String idStr = request.getParameter("productId");
            String name = request.getParameter("productName");
            String price = request.getParameter("price");
            String quantity = request.getParameter("quantity");
            String color = request.getParameter("color");
            String img = request.getParameter("img");
            String categoryIdStr = request.getParameter("categoryId");
            String isAvailableStr = request.getParameter("isAvailable");
            String sizes = request.getParameter("sizes");

            ProductDTO updatedProduct = new ProductDTO();
            updatedProduct.setProductId(Integer.parseInt(idStr));
            updatedProduct.setProductName(name);
            updatedProduct.setPrice(price);
            updatedProduct.setQuantity(Integer.parseInt(quantity));
            updatedProduct.setColor(color);
            updatedProduct.setImg(img);
            updatedProduct.setCategoryId(Integer.parseInt(categoryIdStr));
            updatedProduct.setAvailable(Boolean.parseBoolean(isAvailableStr));
            updatedProduct.setSizes(sizes);

            productDAO.updateProduct(updatedProduct);

        } catch (NumberFormatException e) {
            LOGGER.warning("Invalid number format in input fields.");
            throw new IllegalArgumentException("Invalid input data.");
        }
    }

    /**
     * Handle deleting a product by its ID.
     */
    private void handleDeleteProduct(HttpServletRequest request) {
        String idStr = request.getParameter("id");

        try {
            int id = Integer.parseInt(idStr);
            productDAO.deleteProduct(id);
        } catch (NumberFormatException e) {
            LOGGER.warning("Invalid ID format: " + idStr);
            throw new IllegalArgumentException("ID must be a valid number.");
        }
    }
}
