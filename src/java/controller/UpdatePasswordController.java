package controller;

import dao.UserDAO;
import dto.UserDTO;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet(name = "UpdatePasswordController", urlPatterns = {"/update-account-password"})
public class UpdatePasswordController extends HttpServlet {
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        // Forward user to edit password page
        request.getRequestDispatcher("edit_password.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        // Get user session
        Integer userId = (Integer) request.getSession().getAttribute("userId");

        // Fetch form parameters
        String oldPassword = request.getParameter("oldPassword");
        String newPassword = request.getParameter("newPassword");
        String confirmPassword = request.getParameter("confirmPassword");
        
        // Check if session is invalid
        if (userId == null) {
            request.setAttribute("error", "Session expired. Please log in again.");
            request.getRequestDispatcher("login.jsp").forward(request, response);
            return;
        }

        // Check if new password and confirmation match
        if (!newPassword.equals(confirmPassword)) {
            request.setAttribute("error", "New password and confirmation do not match.");
            request.getRequestDispatcher("edit_password.jsp").forward(request, response);
            return;
        }

        try {
            // Verify old password logic
            UserDAO userDAO = new UserDAO();
            UserDTO user = userDAO.getUserById(userId);

            if (user == null) {
                request.setAttribute("error", "User session invalid.");
                request.getRequestDispatcher("edit_password.jsp").forward(request, response);
                return;
            }

            // Verify the old password entered by the user
            if (!user.getPassword().equals(oldPassword)) {
                request.setAttribute("error", "Old password is incorrect.");
                request.getRequestDispatcher("edit_password.jsp").forward(request, response);
                return;
            }

            // Update password
            user.setPassword(newPassword); // Set new password to the user object
            boolean updateSuccess = userDAO.updateUserPassword(user);

            if (updateSuccess) {
                request.setAttribute("success", "Password updated successfully!");
            } else {
                request.setAttribute("error", "Failed to update password. Please try again later.");
            }
        } catch (Exception e) {
            log("Error in UpdatePasswordController: ", e);
            request.setAttribute("error", "An unexpected error occurred: " + e.getMessage());
        }

        // Forward back to the edit password page
        request.getRequestDispatcher("edit_password.jsp").forward(request, response);
    }
}
