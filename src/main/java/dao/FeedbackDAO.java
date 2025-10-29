/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dao;

import db.DBContext;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;
import models.Feedback;

/**
 *
 * @author Admin
 */
public class FeedbackDAO extends DBContext {

    public boolean createFeedback(Feedback feedback) {
        try {
            String query = "INSERT INTO Feedback (FeedbackID, CustomerID, ProductID, Rating, Comment, CreatedAt)\n"
                    + "VALUES(?, ?, ?, ?, ?, ?)";

            Object[] params = {
                feedback.getCustomerId(),
                feedback.getProductId(),
                feedback.getRating(),
                feedback.getComment(),
                feedback.getCreatedAt()};
            return this.executeNonQuery(query, params) > 0;
        } catch (SQLException ex) {
            Logger.getLogger(ProductDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return false;
    }

    public boolean editFeedback(Feedback feedback) {
        try {
            String query = "UPDATE Feedback\n"
                    + "SET Rating = ?,\n"
                    + "Comment = ?\n"
                    + "WHERE CustomerID = ? AND ProductID = ?";

            Object[] params = {feedback.getRating(),
                feedback.getComment(),
                feedback.getCustomerId(),
                feedback.getProductId()};
            System.out.println(this.executeNonQuery(query, params));
            return this.executeNonQuery(query, params) > 0;
        } catch (SQLException ex) {
            Logger.getLogger(ProductDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return false;
    }

    public double productsFeedbackStarAVG(int productId) {
        double total = 0;
        int count = 0;
        try {
            String query = "SELECT Rating FROM Feedback WHERE ProductID = ?";
            ResultSet rs = this.executeQuery(query, new Object[]{productId});
            while (rs.next()) {
                total += rs.getInt("Rating");
                count++;
            }
            return count > 0 ? total / count : 0;
        } catch (SQLException ex) {
            Logger.getLogger(FeedbackDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return 0;
    }
}
