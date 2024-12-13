package controller;

import dao.ProductDAO;
import dto.ProductDTO;

import javax.servlet.*;
import javax.servlet.http.*;
import java.io.IOException;
import java.util.List;
import javax.servlet.annotation.WebServlet;

@WebServlet(name = "SearchController", urlPatterns = {"/SearchController"})
public class SearchController extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String searchTerm = request.getParameter("searchTerm");
        ProductDAO productDAO = new ProductDAO();
        List<ProductDTO> filteredProducts = productDAO.searchProducts(searchTerm);

        // Pass data to JSP for rendering
        request.setAttribute("searchResults", filteredProducts);
        request.getRequestDispatcher("search.jsp").forward(request, response);
    }
}
