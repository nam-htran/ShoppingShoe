package controller;

import dto.UserDTO;
import dao.AdminDAO;
import java.io.IOException;
import java.util.logging.Logger;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

@WebServlet(name = "Admin_UserController", urlPatterns = {"/admin_user_management"})
public class Admin_UserController extends HttpServlet {

    private static final Logger LOGGER = Logger.getLogger(Admin_UserController.class.getName());
    private final AdminDAO adminDAO = new AdminDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        if (!isAdmin(request, response)) return;

        String action = request.getParameter("action");
        try {
            if ("list".equals(action)) {
                listUsers(request, response);
            } else if ("delete".equals(action)) {
                deleteUser(request, response);
            } else if ("edit".equals(action)) {
                showEditForm(request, response);
            } else {
                response.sendRedirect("admin_user_management?action=list");
            }
        } catch (Exception e) {
            LOGGER.severe("Error during action: " + e.getMessage());
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "An error occurred.");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        if (!isAdmin(request, response)) return;

        String action = request.getParameter("action");
        try {
            if ("edit".equals(action)) {
                handleEditUser(request, response);
            }
        } catch (Exception e) {
            LOGGER.severe("Error during edit operation: " + e.getMessage());
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "An error occurred.");
        }
    }

    private void listUsers(HttpServletRequest request, HttpServletResponse response) throws Exception {
        request.setAttribute("users", adminDAO.getAllUsers());
        request.getRequestDispatcher("admin_user_management.jsp").forward(request, response);
    }

    private void deleteUser(HttpServletRequest request, HttpServletResponse response)
            throws IOException {
        String userIdStr = request.getParameter("id");

        // Ensure the user ID is valid
        if (userIdStr != null && !userIdStr.isEmpty()) {
            try {
                int userId = Integer.parseInt(userIdStr); // Parse the user ID
                if (adminDAO.deleteUser(userId)) {
                    response.sendRedirect("admin_user_management?action=list"); // Redirect after deletion
                } else {
                    response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Failed to delete user.");
                }
            } catch (NumberFormatException e) {
                response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid user ID.");
            }
        } else {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "No user ID provided.");
        }
    }

    private void showEditForm(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            int userId = Integer.parseInt(request.getParameter("id"));
            UserDTO user = adminDAO.getUserById(userId);

            if (user == null) {
                response.sendError(HttpServletResponse.SC_NOT_FOUND, "User not found.");
            } else {
                request.setAttribute("user", user);
                request.getRequestDispatcher("edit_user.jsp").forward(request, response);
            }
        } catch (NumberFormatException e) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid user ID.");
        }
    }

    private void handleEditUser(HttpServletRequest request, HttpServletResponse response) throws IOException {
        try {
            int userId = Integer.parseInt(request.getParameter("userId"));
            String fullname = request.getParameter("fullname");
            String phone = request.getParameter("phone");
            String email = request.getParameter("email");
            String username = request.getParameter("username");
            String address = request.getParameter("address");
            String role = request.getParameter("role");

            UserDTO user = new UserDTO();
            user.setUserId(userId);
            user.setFullname(fullname);
            user.setPhone(phone);
            user.setEmail(email);
            user.setUsername(username);
            user.setAddress(address);
            user.setRole(role);

            if (adminDAO.updateUser(user)) {
                response.sendRedirect("admin_user_management?action=list");
            } else {
                response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Failed to update user.");
            }
        } catch (Exception e) {
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Error processing edit.");
        }
    }

    private boolean isAdmin(HttpServletRequest request, HttpServletResponse response) throws IOException {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            response.sendError(HttpServletResponse.SC_FORBIDDEN, "Access denied");
            return false;
        }

        UserDTO user = (UserDTO) session.getAttribute("user");
        if (!"admin".equals(user.getRole())) {
            response.sendError(HttpServletResponse.SC_FORBIDDEN, "Access denied");
            return false;
        }

        return true;
    }
}
