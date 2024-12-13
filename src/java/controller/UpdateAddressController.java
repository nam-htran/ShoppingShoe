package controller;

import dao.UserDAO;
import dto.UserDTO;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet(name = "UpdateAddressController", urlPatterns = {"/update-account-address"})
public class UpdateAddressController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        int userId = (int) request.getSession().getAttribute("userId");
        UserDAO userDAO = new UserDAO();
        
        try {
            UserDTO user = userDAO.getUserById(userId);
            if (user != null) {
                request.setAttribute("user", user);
            } else {
                request.setAttribute("error", "User not found.");
            }
        } catch (Exception e) {
            request.setAttribute("error", "An error occurred: " + e.getMessage());
        }
        
        request.getRequestDispatcher("edit_address.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        int userId = (int) request.getSession().getAttribute("userId");
        String address = request.getParameter("address");

        UserDTO user = new UserDTO();
        user.setUserId(userId);
        user.setAddress(address);

        UserDAO userDAO = new UserDAO();
        try {
            if (userDAO.updateUserAddress(user)) {
                request.setAttribute("success", "Address updated successfully.");
            } else {
                request.setAttribute("error", "Failed to update the address.");
            }
        } catch (Exception e) {
            request.setAttribute("error", "An error occurred: " + e.getMessage());
        }
        
        request.getRequestDispatcher("edit_address.jsp").forward(request, response);
    }
}
