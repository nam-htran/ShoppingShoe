package controller;

import dao.UserDAO;
import dto.UserDTO;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;




@WebServlet(name = "LoginController", urlPatterns = {"/Login"})
public class LoginController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        // Invalidate the session to ensure any existing session is cleared when accessing the login page
        if (request.getSession(false) != null) { // Check if the session exists
            request.getSession(false).invalidate(); // Invalidate it
        }
        
        response.sendRedirect(request.getContextPath() + "/login.jsp");
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String phone = request.getParameter("phone");
        String password = request.getParameter("password");
        String url = "login.jsp";  // Default redirect URL if login fails

        try {
            UserDAO dao = new UserDAO();
            UserDTO user = dao.checkLogin(phone, password);

            if (user != null) { // Successful login
                // Set session attributes only when login succeeds
                request.getSession(true).setAttribute("user", user);
                request.getSession(true).setAttribute("userId", user.getUserId());
                // Redirect to the root URL ("/") after login success
                response.sendRedirect(request.getContextPath() + "/");
                return;  // Ensure no further code is executed after the redirect
            } else { // Login failed
                request.setAttribute("error", "Invalid phone number or password!");
            }
        } catch (Exception e) {
            log("Error at LoginController: " + e.getMessage(), e);
            request.setAttribute("error", "An internal server error occurred. Please try again.");
        }

        // If login failed, forward back to the login page
        request.getRequestDispatcher(url).forward(request, response);
    }
}
