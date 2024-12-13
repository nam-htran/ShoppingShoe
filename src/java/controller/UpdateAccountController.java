package controller;

import dao.UserDAO;
import dto.UserDTO;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet(name = "UpdateAccountController", urlPatterns = {"/update-account-info"})
public class UpdateAccountController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        // Safely check if the session attribute exists
        Object sessionUserId = request.getSession().getAttribute("userId");

        if (sessionUserId == null) {
            // Redirect to login if userId is not set in the session
            response.sendRedirect(request.getContextPath() + "/Login");
            return;
        }

        int userId = (int) sessionUserId; // Cast only after confirming it's not null

        UserDAO userDAO = new UserDAO();
        try {
            UserDTO user = userDAO.getUserById(userId);

            if (user != null) {
                request.setAttribute("fullname", user.getFullname());
                request.setAttribute("email", user.getEmail());
                request.setAttribute("phone", user.getPhone());
                request.setAttribute("username", user.getUsername());
            } else {
                request.setAttribute("error", "No user found for the given user ID.");
            }
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Error retrieving user information.");
        }

        request.getRequestDispatcher("edit_account.jsp").forward(request, response);
    }


    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        String fullname = request.getParameter("fullname");
        String email = request.getParameter("email");
        String phone = request.getParameter("phone");
        String username = request.getParameter("username");
        int userId = (int) request.getSession().getAttribute("userId");

        UserDAO userDAO = new UserDAO();
        try {
            UserDTO user = new UserDTO(userId, fullname, email, phone, username, null, null, null);
            if (userDAO.updateUserAccount(user)) {
                request.setAttribute("success", "Account information updated successfully!");
            } else {
                request.setAttribute("error", "Failed to update account information.");
            }
        } catch (Exception e) {
            request.setAttribute("error", "An error occurred: " + e.getMessage());
        }
        request.getRequestDispatcher("edit_account.jsp").forward(request, response);
    }
}
