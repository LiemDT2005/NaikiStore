/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package models;

import java.time.LocalDateTime;

/**
 *
 * @author Admin
 */
public class Feedback {

    private int feedbackId;
    private String customerId;
    private String customerName;
    private int productId;
    private int rating;
    private String comment;
    private LocalDateTime createdAt;

    public Feedback() {
    }

    public Feedback(String customerName, int rating, String comment, LocalDateTime createdAt) {
        this.customerName = customerName;
        this.rating = rating;
        this.comment = comment;
        this.createdAt = createdAt;
    }

    public Feedback(int feedbackId, String customerId, int productId, int rating, String comment, LocalDateTime createdAt) {
        this.feedbackId = feedbackId;
        this.customerId = customerId;
        this.productId = productId;
        this.rating = rating;
        this.comment = comment;
        this.createdAt = createdAt;
    }

    public int getFeedbackId() {
        return feedbackId;
    }

    public void setFeedbackId(int feedbackId) {
        this.feedbackId = feedbackId;
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

    public int getProductId() {
        return productId;
    }

    public void setProductId(int productId) {
        this.productId = productId;
    }

    public int getRating() {
        return rating;
    }

    public void setRating(int rating) {
        this.rating = rating;
    }

    public String getComment() {
        return comment;
    }

    public void setComment(String comment) {
        this.comment = comment;
    }

    public LocalDateTime getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(LocalDateTime createdAt) {
        this.createdAt = createdAt;
    }

}
