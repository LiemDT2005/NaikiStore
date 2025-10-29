/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package models;

import java.math.BigDecimal;
import java.sql.Timestamp;

/**
 *
 * @author Dang Thanh Liem - CE190697
 */
public class CartItem {
    private int cartItemID;
    private String customerID;
    private int productVariantID;
    private int quantity;
    private Timestamp createdAt;
    
    private Product product;
    private String size;
    private String color;
    private String imageURL;
    private BigDecimal price;

    public CartItem() {
    }

    public int getCartItemID() {
        return cartItemID;
    }

    public String getCustomerID() {
        return customerID;
    }

    public int getProductVariantID() {
        return productVariantID;
    }

    public int getQuantity() {
        return quantity;
    }

    public Timestamp getCreatedAt() {
        return createdAt;
    }

    public Product getProduct() {
        return product;
    }

    public String getSize() {
        return size;
    }

    public String getColor() {
        return color;
    }

    public String getImageURL() {
        return imageURL;
    }

    public BigDecimal getPrice() {
        return price;
    }

    public void setCartItemID(int cartItemID) {
        this.cartItemID = cartItemID;
    }

    public void setCustomerID(String customerID) {
        this.customerID = customerID;
    }

    public void setProductVariantID(int productVariantID) {
        this.productVariantID = productVariantID;
    }

    public void setQuantity(int quantity) {
        this.quantity = quantity;
    }

    public void setCreatedAt(Timestamp createdAt) {
        this.createdAt = createdAt;
    }

    public void setProduct(Product product) {
        this.product = product;
    }

    public void setSize(String size) {
        this.size = size;
    }

    public void setColor(String color) {
        this.color = color;
    }

    public void setImageURL(String imageURL) {
        this.imageURL = imageURL;
    }

    public void setPrice(BigDecimal price) {
        this.price = price;
    }
     
    
    
}
