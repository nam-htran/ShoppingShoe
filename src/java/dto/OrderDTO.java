package dto;

import java.util.Date;
import java.util.List;

public class OrderDTO {

    private Integer orderId;
    private Integer userId;
    private Date orderDate;
    private Double totalPrice;
    private String address;
    private String status;
    private List<CartItemDTO> items;  // List of CartItems for the order

    // Default Constructor
    public OrderDTO() {}

    // Parameterized Constructor
    public OrderDTO(Integer orderId, Integer userId, Date orderDate, Double totalPrice, String address, String status, List<CartItemDTO> items) {
        this.orderId = orderId;
        this.userId = userId;
        this.orderDate = orderDate;
        this.totalPrice = totalPrice;
        this.address = address;
        this.status = status;
        this.items = items;
    }

    // Getters and Setters
    public Integer getOrderId() {
        return orderId;
    }

    public void setOrderId(Integer orderId) {
        this.orderId = orderId;
    }

    public Integer getUserId() {
        return userId;
    }

    public void setUserId(Integer userId) {
        this.userId = userId;
    }

    public Date getOrderDate() {
        return orderDate;
    }

    public void setOrderDate(Date orderDate) {
        this.orderDate = orderDate;
    }

    public Double getTotalPrice() {
        return totalPrice;
    }

    public void setTotalPrice(Double totalPrice) {
        this.totalPrice = totalPrice;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public List<CartItemDTO> getItems() {
        return items;
    }

    public void setItems(List<CartItemDTO> items) {
        this.items = items;
    }

    @Override
    public String toString() {
        return "OrderDTO{" +
                "orderId=" + orderId +
                ", userId=" + userId +
                ", orderDate=" + orderDate +
                ", totalPrice=" + totalPrice +
                ", address='" + address + '\'' +
                ", status='" + status + '\'' +
                ", items=" + items +
                '}';
    }

    public void setOrderDetails(List<OrderDetailDTO> orderDetails) {
        throw new UnsupportedOperationException("Not supported yet."); //To change body of generated methods, choose Tools | Templates.
    }
}
