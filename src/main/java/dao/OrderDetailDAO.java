/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dao;

import db.DBContext;
import models.OrderWithDetails;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import models.Order;

public class OrderDetailDAO {

    private final Connection conn;

    public OrderDetailDAO() throws SQLException {
        this.conn = new DBContext().getConnection();
    }

    /**
     * Lấy thông tin tóm tắt chi tiết của 1 đơn hàng (dùng cho view My Orders)
     */
    public OrderWithDetails getOrderSummaryByOrderId(Order order) {
        OrderWithDetails dto = new OrderWithDetails();
        dto.setOrder(order); // gắn đối tượng order hiện tại

        // Lấy danh sách tên sản phẩm
        dto.setProductNames(getProductNamesByOrderId(order.getOrderID()));

        // Lấy hình ảnh sản phẩm đầu tiên trong đơn
        dto.setImageURL(getFirstProductImageByOrderId(order.getOrderID()));

        return dto;
    }

    /**
     * Lấy danh sách tên sản phẩm trong đơn
     */
    public List<String> getProductNamesByOrderId(int orderId) {
        List<String> names = new ArrayList<>();
        String sql = "SELECT p.ProductName\n"
                + "FROM OrderDetail od\n"
                + "JOIN ProductVariant pv ON od.ProductVariantID = pv.ProductVariantID\n"
                + "JOIN Product p ON pv.ProductID = p.ProductID\n"
                + "WHERE od.OrderID = ?";

        try ( PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, orderId);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                names.add(rs.getString("ProductName"));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return names;
    }

    /**
     * Lấy ảnh sản phẩm đầu tiên trong đơn
     */
    public String getFirstProductImageByOrderId(int orderId) {
        String sql = "SELECT TOP 1 p.ImageURL \n"
                + "                 FROM ProductVariant p \n"
                + "               JOIN OrderDetail od ON p.ProductVariantID = od.ProductVariantID \n"
                + "                JOIN [Order] o ON od.OrderID = o.OrderID \n"
                + "              WHERE o.OrderID = ?";
        try ( PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, orderId);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return rs.getString("ImageURL");
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }
}
