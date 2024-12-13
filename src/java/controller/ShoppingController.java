package controller;

import dao.OrderDAO;
import dto.CartItemDTO;
import dto.OrderDTO;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

@WebServlet(name = "ShoppingController", urlPatterns = {"/shopping"})
public class ShoppingController extends HttpServlet {

    private final OrderDAO orderDAO = new OrderDAO();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");

        if (action == null) {
            request.getRequestDispatcher("shopping_cart.jsp").forward(request, response);
            return;
        }

        switch (action) {
            case "addToCart":
                addToCart(request, response);
                break;
            case "removeFromCart":
                removeFromCart(request, response);
                break;
            case "checkout":
                checkout(request, response);
                break;
            case "updateQuantity":
                updateQuantity(request, response);
                break;
            case "updateAddress":
                updateAddress(request, response);
                break;
            case "updateAddressAndCheckout":
                updateAddressAndCheckout(request, response);
                break;
            default:
                request.getRequestDispatcher("shopping_cart.jsp").forward(request, response);
        }
    }

    private void addToCart(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        List<CartItemDTO> cart = (List<CartItemDTO>) session.getAttribute("cart");

        if (cart == null) {
            cart = new ArrayList<>();
            session.setAttribute("cart", cart);
        }

        int productId = Integer.parseInt(request.getParameter("productId"));
        String productName = request.getParameter("productName");
        String productCode = request.getParameter("productCode");
        String imageUrl = request.getParameter("imageUrl");
        double price = parsePrice(request.getParameter("price"));
        int quantity = Integer.parseInt(request.getParameter("quantity"));

        boolean itemExists = false;

        for (CartItemDTO item : cart) {
            if (item.getProductId() == productId) {
                item.setQuantity(item.getQuantity() + quantity);
                itemExists = true;
                break;
            }
        }

        if (!itemExists) {
            cart.add(new CartItemDTO(productId, productName, productCode, imageUrl, price, quantity));
        }

        session.setAttribute("cart", cart);
        request.getRequestDispatcher("shopping_cart.jsp").forward(request, response);
    }

    private void removeFromCart(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        List<CartItemDTO> cart = (List<CartItemDTO>) session.getAttribute("cart");

        if (cart != null) {
            int productId = Integer.parseInt(request.getParameter("productId"));
            cart.removeIf(item -> item.getProductId() == productId);
            session.setAttribute("cart", cart);
        }

        request.getRequestDispatcher("shopping_cart.jsp").forward(request, response);
    }

    private void checkout(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String address = (String) request.getSession().getAttribute("address");
        HttpSession session = request.getSession();
        List<CartItemDTO> cart = (List<CartItemDTO>) session.getAttribute("cart");

        if (cart == null || cart.isEmpty()) {
            request.getRequestDispatcher("shopping_cart.jsp").forward(request, response);
            return;
        }

        Integer userId = (Integer) session.getAttribute("userId");

        if (userId == null) {
            response.sendRedirect(request.getContextPath() + "/Login");
            return;
        }

        double totalAmount = cart.stream().mapToDouble(item -> item.getPrice() * item.getQuantity()).sum();

        OrderDTO order = new OrderDTO();
        order.setUserId(userId);
        order.setTotalPrice(totalAmount);
        order.setAddress(address);
        order.setStatus("Pending");

        int orderId = orderDAO.insertOrder(order);

        if (orderId > 0) {
            orderDAO.insertOrderDetails(orderId, cart);
            session.removeAttribute("cart");
            request.setAttribute("orderId", orderId);
            request.getRequestDispatcher("order_confirmation.jsp").forward(request, response);
        } else {
            request.getRequestDispatcher("checkout_failure.jsp").forward(request, response);
        }
    }

    private void updateQuantity(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        List<CartItemDTO> cart = (List<CartItemDTO>) session.getAttribute("cart");

        if (cart != null) {
            int productId = Integer.parseInt(request.getParameter("productId"));
            int quantity = Integer.parseInt(request.getParameter("quantity"));

            for (CartItemDTO item : cart) {
                if (item.getProductId() == productId) {
                    item.setQuantity(quantity);
                    break;
                }
            }

            session.setAttribute("cart", cart);
        }

        request.getRequestDispatcher("shopping_cart.jsp").forward(request, response);
    }

    private void updateAddress(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String address = request.getParameter("address");

        if (address == null || address.trim().isEmpty()) {
            request.setAttribute("errorMessage", "Địa chỉ không thể để trống.");
            request.getRequestDispatcher("shopping_cart.jsp").forward(request, response);
            return;
        }

        HttpSession session = request.getSession();
        session.setAttribute("address", address);

        request.getRequestDispatcher("shopping_cart.jsp").forward(request, response);
    }

    private void updateAddressAndCheckout(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String address = request.getParameter("address");

        if (address == null || address.trim().isEmpty()) {
            request.setAttribute("errorMessage", "Địa chỉ không thể để trống.");
            request.getRequestDispatcher("shopping_cart.jsp").forward(request, response);
            return;
        }

        HttpSession session = request.getSession();
        session.setAttribute("address", address);

        checkout(request, response);
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.getRequestDispatcher("shopping_cart.jsp").forward(request, response);
    }

    public double parsePrice(String priceString) {
        if (priceString == null || priceString.trim().isEmpty()) {
            throw new IllegalArgumentException("Price string cannot be null or empty");
        }
        try {
            String numericString = priceString.replaceAll("[^\\d.]", "");
            return Double.parseDouble(numericString);
        } catch (NumberFormatException e) {
            throw new IllegalArgumentException("Invalid price format: " + priceString, e);
        }
    }
    
}