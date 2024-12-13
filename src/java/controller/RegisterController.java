package controller;

import dao.UserDAO;
import dto.UserDTO;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet(name = "RegisterController", urlPatterns = {"/Register"})
public class RegisterController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Redirect to the registration page
        request.getRequestDispatcher("register.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String fullname = request.getParameter("fullname");
        String email = request.getParameter("email");
        String phone = request.getParameter("phone");
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        String address = request.getParameter("address");

        UserDTO newUser = new UserDTO(0, fullname, email, phone, username, password, address, "user"); // Default role is "user"
        UserDAO userDAO = new UserDAO();

        try {
            // Check if the user already exists
            if (userDAO.checkUserExists(phone, email)) {
                request.setAttribute("error", "Phone number or email already exists. Please use a different one.");
                request.getRequestDispatcher("register.jsp").forward(request, response);
                return; // Stop further execution
            }

            // Register the new user
            if (userDAO.registerUser(newUser)) {
                // Set the success message in the request
                request.getSession(true).setAttribute("user", newUser);
                request.getSession(true).setAttribute("userId", newUser.getUserId());
                request.setAttribute("success", "Registration successful! You will be redirected shortly.");
                
                // Forward back to the registration page with the success message
                request.getRequestDispatcher("register.jsp").forward(request, response);
            } else {
                request.setAttribute("error", "Registration failed. Please try again.");
                request.getRequestDispatcher("register.jsp").forward(request, response);
            }
        } catch (Exception e) {
            log("Error at RegisterController: " + e.getMessage(), e);
            request.setAttribute("error", "An error occurred during registration. Please try again.");
            request.getRequestDispatcher("register.jsp").forward(request, response);
        }
    }
}
