/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package models;

import java.math.BigDecimal;
import java.sql.Timestamp;
import java.util.Date;

/**
 *
 * @author Dang Thanh Liem - CE190697
 */
public class Order {

    private int orderID;
    private String staffID;
    private String customerID;
    private Integer voucherID;
    private String status;
    private String paymentMethod;
    private BigDecimal totalPrice;
    private String address;
    private String phone;
    private Timestamp createdAt;

    public Order() {
    }

    public int getOrderID() {
        return orderID;
    }

    public String getStaffID() {
        return staffID;
    }

    public String getCustomerID() {
        return customerID;
    }

    public Integer getVoucherID() {
        return voucherID;
    }

    public String getStatus() {
        return status;
    }

    public String getPaymentMethod() {
        return paymentMethod;
    }

    public BigDecimal getTotalPrice() {
        return totalPrice;
    }

    public String getAddress() {
        return address;
    }

    public String getPhone() {
        return phone;
    }

    public Timestamp getCreatedAt() {
        return createdAt;
    }
    

    public void setOrderID(int orderID) {
        this.orderID = orderID;
    }

    public void setStaffID(String staffID) {
        this.staffID = staffID;
    }

    public void setCustomerID(String customerID) {
        this.customerID = customerID;
    }

    public void setVoucherID(Integer voucherID) {
        this.voucherID = voucherID;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public void setPaymentMethod(String paymentMethod) {
        this.paymentMethod = paymentMethod;
    }

    public void setTotalPrice(BigDecimal totalPrice) {
        this.totalPrice = totalPrice;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public void setPhone(String phone) {
        this.phone = phone;
    }

    public void setCreatedAt(Timestamp createdAt) {
        this.createdAt = createdAt;
    }

   
    
}
