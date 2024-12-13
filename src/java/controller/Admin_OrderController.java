package controller;

import dao.OrderDAO;
import dto.OrderDTO;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * AdminOrderController handles administrative actions related to order management.
 */
@WebServlet(name = "Admin_OrderController", urlPatterns = {"/admin_order_management"})
public class Admin_OrderController extends HttpServlet {

    private static final long serialVersionUID = 1L;
    private final OrderDAO orderDAO = new OrderDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");

        if ("viewOrders".equals(action) || action == null) {
            handleViewOrders(request, response);
        } else if ("deleteOrder".equals(action)) {
            handleDeleteOrder(request, response);
        } else if ("updateStatus".equals(action)) {
            handleUpdateStatus(request, response);
        } else {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid action");
        }
    }

    /**
     * Handles viewing all orders.
     */
    private void handleViewOrders(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            List<OrderDTO> orders = orderDAO.getTransactionHistory();
            request.setAttribute("orderList", orders);
            request.getRequestDispatcher("admin_order_management.jsp").forward(request, response);
        } catch (Exception e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Error loading orders");
        }
    }

    /**
     * Handles deleting a specific order by ID.
     */
    private void handleDeleteOrder(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String orderId = request.getParameter("orderId");

        if (orderId == null) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Order ID is required");
            return;
        }

        try {
            orderDAO.deleteOrder(orderId);
            response.sendRedirect("admin_order_management?action=viewOrders");
        } catch (Exception e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Failed to delete order");
        }
    }

    /**
     * Handles updating the order status.
     */
    private void handleUpdateStatus(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String orderId = request.getParameter("orderId");
        String status = request.getParameter("status");

        if (orderId == null || status == null) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid parameters");
            return;
        }

        try {
            orderDAO.updateOrderStatus(orderId, status);
            response.sendRedirect("admin_order_management?action=viewOrders");
        } catch (Exception e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Failed to update order status");
        }
    }
}
