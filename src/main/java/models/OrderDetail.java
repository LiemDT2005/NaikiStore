/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package models;

import java.math.BigDecimal;

/**
 *
 * @author Dang Thanh Liem - CE190697
 */
public class OrderDetail {

    private int orderDetailID;
    private int orderID;
    private int productVariantID;
    private BigDecimal price;
    private int quantity;
    private String status;

    public OrderDetail() {
    }

    public int getOrderDetailID() {
        return orderDetailID;
    }

    public int getOrderID() {
        return orderID;
    }

    public int getProductVariantID() {
        return productVariantID;
    }

    public BigDecimal getPrice() {
        return price;
    }

    public int getQuantity() {
        return quantity;
    }

    public String getStatus() {
        return status;
    }

    public void setOrderDetailID(int orderDetialID) {
        this.orderDetailID = orderDetialID;
    }

    public void setOrderID(int orderID) {
        this.orderID = orderID;
    }

    public void setProductVariantID(int productVariantID) {
        this.productVariantID = productVariantID;
    }

    public void setPrice(BigDecimal price) {
        this.price = price;
    }

    public void setQuantity(int quantity) {
        this.quantity = quantity;
    }

    public void setStatus(String status) {
        this.status = status;
    }
    
}
