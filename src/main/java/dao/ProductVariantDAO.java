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

/**
 *
 * @author Dang Thanh Liem - CE190697
 */
public class ProductVariantDAO extends DBContext {

    public int getPVId(int productId, String size, String color) throws SQLException {
        try {
            String query = "Select ProductVariantID\n"
                    + "from ProductVariant\n"
                    + "where ProductID = ? and Size = ? and color = ?";
            Object[] params = {productId, size, color};
            ResultSet rs = this.executeQuery(query, params);
            if (rs.next()) {
                return rs.getInt(1);
            } else {
                System.out.println("ProductVariant: null");
            }
        } catch (SQLException ex) {
            Logger.getLogger(ProductDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return 0;
    }
}
