/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dao;

import db.DBContext;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

/**
 *
 * @author Admin
 */
public class ImageDAO extends DBContext {

    public List<String> getAllImageByProductId(int productId) {
        String sql = "SELECT ImageURL FROM Image\n"
                + "WHERE ProductID = ?";
        List<String> listImage = new ArrayList<>();
        try {
            PreparedStatement ps = this.getConnection().prepareStatement(sql);
            ps.setInt(1, productId);
            ResultSet rs = ps.executeQuery();
            String url;
            while (rs.next()) {
                url = rs.getString(1);
                if (!(url == null || url.isEmpty())) {
                    listImage.add(url);
                }
            }
        } catch (SQLException e) {
            System.out.println(e.getCause());
        }
        return listImage;
    }
}
