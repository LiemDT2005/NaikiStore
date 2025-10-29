/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package models;

import java.math.BigDecimal;
import java.text.DecimalFormat;
import java.text.DecimalFormatSymbols;
import java.time.LocalDateTime;

public class Product {

    private int productId;
    private int categoryId;
    private String productName;
    private String description;
    private BigDecimal price;
    private LocalDateTime createdAt;
    private LocalDateTime updatedAt;
    private boolean isActive;
    private int soldQuantity;
    private String imageUrl;

    public Product() {
    }

    public Product(int productId, int categoryId, String productName, BigDecimal price, int soldQuantity, String imageUrl) {
        this.productId = productId;
        this.categoryId = categoryId;
        this.productName = productName;
        this.price = price;
        this.soldQuantity = soldQuantity;
        this.imageUrl = imageUrl;
    }

    public Product(int productId, int categoryId, String productName, String description, BigDecimal price, LocalDateTime createdAt, LocalDateTime updatedAt, boolean isActive, String imageUrl) {
        this.productId = productId;
        this.categoryId = categoryId;
        this.productName = productName;
        this.description = description;
        this.price = price;
        this.createdAt = createdAt;
        this.updatedAt = updatedAt;
        this.isActive = isActive;
        this.imageUrl = imageUrl;
    }

    public int getProductId() {
        return productId;
    }

    public void setProductId(int productId) {
        this.productId = productId;
    }

    public int getCategoryId() {
        return categoryId;
    }

    public void setCategoryId(int categoryId) {
        this.categoryId = categoryId;
    }

    public String getProductName() {
        return productName;
    }

    public void setProductName(String productName) {
        this.productName = productName;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public BigDecimal getPrice() {
        return price;
    }

    public void setPrice(BigDecimal price) {
        this.price = price;
    }

    public LocalDateTime getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(LocalDateTime createdAt) {
        this.createdAt = createdAt;
    }

    public LocalDateTime getUpdatedAt() {
        return updatedAt;
    }

    public void setUpdatedAt(LocalDateTime updatedAt) {
        this.updatedAt = updatedAt;
    }

    public boolean isIsActive() {
        return isActive;
    }

    public void setIsActive(boolean isActive) {
        this.isActive = isActive;
    }

    public int getSoldQuantity() {
        return soldQuantity;
    }

    public void setSoldQuantity(int soldQuantity) {
        this.soldQuantity = soldQuantity;
    }

    public String getImageUrl() {
        return imageUrl;
    }

    public void setImageUrl(String imageUrl) {
        this.imageUrl = imageUrl;
    }

    
    @Override
    public String toString() {
        return "Product{"
                + "productId=" + productId
                + ", productName='" + productName + '\''
                + ", description='" + description + '\''
                + ", categoryId=" + categoryId
                + ", price=" + price
                + ", createdAt=" + createdAt
                + ", updatedAt=" + updatedAt
                + ", isActive=" + isActive
                + '}';
    }

    // Method để trả về giá tiền có định dạng dấu chấm
    public String getFormattedPrice() {
        DecimalFormatSymbols symbols = new DecimalFormatSymbols();
        symbols.setGroupingSeparator('.');
        symbols.setDecimalSeparator(','); // Tuỳ chỉnh nếu bạn có phần thập phân

        DecimalFormat formatter = new DecimalFormat("#,###", symbols);
        return formatter.format(price);
    }
}
