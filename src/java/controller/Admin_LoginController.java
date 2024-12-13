package controller;

import dao.AdminDAO;
import dto.UserDTO;
import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.IOException;

@WebServlet(name = "Admin_LoginController", urlPatterns = {"/admin"})
public class Admin_LoginController extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String username = request.getParameter("username");
        String password = request.getParameter("password");

        AdminDAO adminDAO = new AdminDAO();

        try {
            // Retrieve user details
            UserDTO user = adminDAO.checkLogin(username, password);

            if (user != null && user.getPassword().equals(password)) {
                if ("admin".equals(user.getRole())) {
                    // Admin login success
                    HttpSession session = request.getSession();
                    session.setAttribute("user", user);
                    session.setAttribute("userId", user.getUserId());
                    response.sendRedirect(request.getContextPath() + "/admin_product_management");
                } else {
                    // Non-admin user trying to log in
                    request.setAttribute("error", "Access denied: Only admin users can log in.");
                    request.getRequestDispatcher("admin_login.jsp").forward(request, response);
                }
            } else {
                // Invalid credentials
                request.setAttribute("error", "Invalid username or password.");
                request.getRequestDispatcher("admin_login.jsp").forward(request, response);
            }
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "An unexpected error occurred. Please try again.");
            request.getRequestDispatcher("admin_login.jsp").forward(request, response);
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Invalidate the session to ensure any existing session is cleared when accessing the login page
        if (request.getSession(false) != null) { // Check if the session exists
            request.getSession(false).invalidate(); // Invalidate it
        }
        request.getRequestDispatcher("admin_login.jsp").forward(request, response);
    }
}
