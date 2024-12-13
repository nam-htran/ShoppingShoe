package controller;

import java.io.IOException;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dao.ProductDAO;
import dto.ProductDTO;

@WebServlet(name="HomepageController", urlPatterns = {"/"})
public class HomepageController extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        ProductDAO productDAO = new ProductDAO();
        List<ProductDTO> products = productDAO.getAllProducts();
        
        // You don't need to manually clean the price here anymore, as it's done in the DTO class
        
        // Set the list of products in request to forward to the JSP
        request.setAttribute("products", products);
        request.getRequestDispatcher("/homepage.jsp").forward(request, response);
    }
}
