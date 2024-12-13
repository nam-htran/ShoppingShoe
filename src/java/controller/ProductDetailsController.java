package controller;

import dao.ProductDAO;
import dto.ProductDTO;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet(name = "ProductDetailsController", urlPatterns = {"/product-details"})
public class ProductDetailsController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            // Retrieve product ID from the request parameters
            String productIdStr = request.getParameter("id");

            // Check if productId is null or empty
            if (productIdStr == null || productIdStr.isEmpty()) {
                response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Product ID is missing");
                return;
            }

            int productId = Integer.parseInt(productIdStr); // Convert productId to integer

            // Fetch product details using ProductDAO
            ProductDAO productDAO = new ProductDAO();
            ProductDTO product = productDAO.getProductByID(productId);

            // Set product details as request attribute
            request.setAttribute("product", product);

            // Forward to the product details JSP
            request.getRequestDispatcher("product_details.jsp").forward(request, response);
        } catch (NumberFormatException e) {
            log("Invalid product ID format", e);
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid product ID format");
        } catch (Exception e) {
            log("Error at ProductDetailsController: " + e.getMessage(), e);
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Unable to load product details.");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.sendError(HttpServletResponse.SC_METHOD_NOT_ALLOWED, "POST method is not supported for this URL.");
    }
}
