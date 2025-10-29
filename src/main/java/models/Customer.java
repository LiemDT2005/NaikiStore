/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package models;

import java.time.LocalDateTime;

/**
 *
 * @author Do Ho Gia Huy - CE191293
 */
public class Customer {
    
    private String customerId;  
    private String customerName;  
    private String email;  
    private String password;  
    private String phone;  
    private Gender gender;
    private String address; 
    private Status status;  
    private String passwordRecoveryToken;  
    private LocalDateTime tokenExpiry;  
    private String avatar;  

    public Customer() {
    }

    public Customer(String customerId, String customerName, String email, String password, String phone, String address, Status status, String passwordRecoveryToken, LocalDateTime tokenExpiry, String avatar) {
        this.customerId = customerId;
        this.customerName = customerName;
        this.email = email;
        this.password = password;
        this.phone = phone;
        this.address = address;
        this.status = status;
        this.passwordRecoveryToken = passwordRecoveryToken;
        this.tokenExpiry = tokenExpiry;
        this.avatar = avatar;
    }
    
    public Customer(String customerId, String customerName, String email, String password, String phone,Gender gender, String address, Status status, String passwordRecoveryToken, LocalDateTime tokenExpiry, String avatar) {
        this.customerId = customerId;
        this.customerName = customerName;
        this.email = email;
        this.password = password;
        this.phone = phone;
        this.gender = gender;
        this.address = address;
        this.status = status;
        this.passwordRecoveryToken = passwordRecoveryToken;
        this.tokenExpiry = tokenExpiry;
        this.avatar = avatar;
    }

    // Enum cho Status (ACTIVE, INACTIVE)
    public enum Status {
        ACTIVE, INACTIVE
    }
    
    public enum Gender {
        MALE, FEMALE, OTHER
    }
    
    public Customer(String userName, String email) {
        this.customerName = userName;
        this.email = email;
    }

    public String getCustomerId() {
        return customerId;
    }

    public void setCustomerId(String customerId) {
        this.customerId = customerId;
    }

    public String getCustomerName() {
        return customerName;
    }

    public void setCustomerName(String customerName) {
        this.customerName = customerName;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = phone;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public Status getStatus() {
        return status;
    }

    public void setStatus(Status status) {
        this.status = status;
    }

    // Sửa lại phương thức này để trả về đúng thuộc tính `passwordRecoveryToken`
    public String getPasswordRecoveryToken() {
        return passwordRecoveryToken;
    }

    public void setPasswordRecoveryToken(String passwordRecoveryToken) {
        this.passwordRecoveryToken = passwordRecoveryToken;
    }

    public LocalDateTime getTokenExpiry() {
        return tokenExpiry;
    }

    public void setTokenExpiry(LocalDateTime tokenExpiry) {
        this.tokenExpiry = tokenExpiry;
    }

    public String getAvatar() {
        return avatar;
    }

    public void setAvatar(String avatar) {
        this.avatar = avatar;
    }

    public Gender getGender() {
        return gender;
    }

    public void setGender(Gender gender) {
        this.gender = gender;
    }

    @Override
    public String toString() {
        return "Customers{" + "customerId=" + customerId + ", customerName=" + customerName + ", email=" + email + ", password=" + password + ", phone=" + phone + ", address=" + address + ", status=" + status + ", passwordRecoveryToken=" + passwordRecoveryToken + ", tokenExpiry=" + tokenExpiry + ", avatar=" + avatar + '}';
    }
    
    
    
}
