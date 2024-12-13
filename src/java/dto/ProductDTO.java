package dto;

import java.math.BigDecimal;
import java.util.List;

public class ProductDTO {
    private Integer productId;
    private String productName;
    private String price; // Changed to BigDecimal for price
    private Integer quantity;
    private String img;
    private String color;
    private Integer categoryId;
    private boolean isAvailable;
    private String sizes;  // Can also be List<String> if you prefer

    public ProductDTO() {}

    public ProductDTO(Integer productId, String productName, String price, Integer quantity, 
                      String img, String color, Integer categoryId, boolean isAvailable, String sizes) {
        this.productId = productId;
        this.productName = productName;
        this.price = price;
        this.quantity = quantity;
        this.img = img;
        this.color = color;
        this.categoryId = categoryId;
        this.isAvailable = isAvailable;
        this.sizes = sizes;  // You can change this to a List<String> if you prefer
    }

    public Integer getProductId() {
        return productId;
    }

    public void setProductId(Integer productId) {
        this.productId = productId;
    }

    public String getProductName() {
        return productName;
    }

    public void setProductName(String productName) {
        this.productName = productName;
    }

    public String getPrice() {
        return price;
    }

    public void setPrice(String price) {
        this.price = price;
    }

    public Integer getQuantity() {
        return quantity;
    }

    public void setQuantity(Integer quantity) {
        this.quantity = quantity;
    }

    public String getImg() {
        return img;
    }

    public void setImg(String img) {
        this.img = img;
    }

    public String getColor() {
        return color;
    }

    public void setColor(String color) {
        this.color = color;
    }

    public Integer getCategoryId() {
        return categoryId;
    }

    public void setCategoryId(Integer categoryId) {
        this.categoryId = categoryId;
    }

    public boolean getIsAvailable() {
        return isAvailable;
    }

    public void setAvailable(boolean available) {
        isAvailable = available;
    }

    public String getSizes() {
        return sizes;
    }

    public void setSizes(String sizes) {
        this.sizes = sizes;
    }

    @Override
    public String toString() {
        return "ProductDTO{" +
               "productId=" + productId +
               ", productName='" + productName + '\'' +
               ", price=" + price +
               ", quantity=" + quantity +
               ", img='" + img + '\'' +
               ", color='" + color + '\'' +
               ", categoryId=" + categoryId +
               ", isAvailable=" + isAvailable +
               ", sizes='" + sizes + '\'' +
               '}';
    }
}
