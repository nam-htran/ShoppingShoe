package controller;

import dao.OrderDAO;
import dto.OrderDTO;
import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.util.List;

@WebServlet(name = "TransactionHistoryController" ,urlPatterns = {"/transaction-history"})
public class TransactionHistoryController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Lấy thông tin người dùng từ session
        HttpSession session = request.getSession();
        Integer userId = (Integer) session.getAttribute("userId");  // Giả sử bạn lưu userId trong session khi người dùng đăng nhập

        if (userId != null) {
            // Lấy lịch sử giao dịch chỉ của người dùng hiện tại
            OrderDAO orderDAO = new OrderDAO();
            List<OrderDTO> transactionHistory = orderDAO.getTransactionHistoryByUser(userId);

            // Pass data to the JSP view
            request.setAttribute("transactionHistory", transactionHistory);
            // Forward to JSP page
            RequestDispatcher dispatcher = request.getRequestDispatcher("order_list.jsp");
            dispatcher.forward(request, response);
        } else {
            // Nếu chưa đăng nhập, chuyển hướng đến trang đăng nhập
            response.sendRedirect(request.getContextPath() + "/Login");
        }
    }
}
