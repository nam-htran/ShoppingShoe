package dto;

import java.io.Serializable;

public class CartItemDTO implements Serializable {
    private static final long serialVersionUID = 1L; // Recommended to define this for Serializable classes

    private int productId;
    private String productName;
    private String productCode;
    private String imageUrl;
    private double price;
    private int quantity;

    // Default Constructor
    public CartItemDTO() {}

    // Parameterized Constructor
    public CartItemDTO(int productId, String productName, String productCode, String imageUrl, double price, int quantity) {
        this.productId = productId;
        this.productName = productName;
        this.productCode = productCode;
        this.imageUrl = imageUrl;
        this.price = price;
        this.quantity = quantity;
    }

    // Getters and Setters
    public int getProductId() {
        return productId;
    }

    public void setProductId(int productId) {
        this.productId = productId;
    }

    public String getProductName() {
        return productName;
    }

    public void setProductName(String productName) {
        this.productName = productName;
    }

    public String getProductCode() {
        return productCode;
    }

    public void setProductCode(String productCode) {
        this.productCode = productCode;
    }

    public String getImageUrl() {
        return imageUrl;
    }

    public void setImageUrl(String imageUrl) {
        this.imageUrl = imageUrl;
    }

    public double getPrice() {
        return price;
    }

    public void setPrice(double price) {
        this.price = price;
    }

    public int getQuantity() {
        return quantity;
    }

    public void setQuantity(int quantity) {
        this.quantity = quantity;
    }

    @Override
    public String toString() {
        return "CartItemDTO{" +
                "productId=" + productId +
                ", productName='" + productName + '\'' +
                ", productCode='" + productCode + '\'' +
                ", imageUrl='" + imageUrl + '\'' +
                ", price=" + price +
                ", quantity=" + quantity +
                '}';
    }
}
