/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
 /*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dao;

import db.DBContext;
import java.math.BigDecimal;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import models.Order;

/**
 * Data Access Object cho bảng Orders. Author: Dang Thanh Liem - CE190697
 */
public class OrderDAO extends DBContext {

    /**
     * Đếm tổng số đơn hàng theo CustomerID
     */
    public int countOrdersByCustomerId(String customerId) {
        String sql = "SELECT COUNT(*) FROM [Order] WHERE CustomerID = ?";
        try ( PreparedStatement ps = getConnection().prepareStatement(sql)) {
            ps.setString(1, customerId);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return rs.getInt(1);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return 0;
    }

    /**
     * Lấy danh sách đơn hàng của khách hàng theo trang
     */
    public List<Order> getOrdersByCustomerIdWithPaging(String customerId, int offset, int pageSize) {
        List<Order> list = new ArrayList<>();
        String sql = "SELECT OrderID, StaffID, CustomerID, VoucherID, Status, PaymentMethod,\n"
                + "                   TotalPrice, Address, Phone, CreatedAt\n"
                + "            FROM [Order]\n"
                + "            WHERE CustomerID = ?\n"
                + "            ORDER BY CreatedAt DESC\n"
                + "            OFFSET ? ROWS FETCH NEXT ? ROWS ONLY";

        try ( PreparedStatement ps = getConnection().prepareStatement(sql)) {
            ps.setString(1, customerId);
            ps.setInt(2, offset);
            ps.setInt(3, pageSize);

            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Order o = new Order();
                o.setOrderID(rs.getInt("OrderID"));
                o.setStaffID(rs.getString("StaffID"));
                o.setCustomerID(rs.getString("CustomerID"));

                Object voucherValue = rs.getObject("VoucherID");
                if (voucherValue != null) {
                    o.setVoucherID((Integer) voucherValue);
                }

                o.setStatus(rs.getString("Status"));
                o.setPaymentMethod(rs.getString("PaymentMethod"));
                o.setTotalPrice(rs.getBigDecimal("TotalPrice"));
                o.setAddress(rs.getString("Address"));
                o.setPhone(rs.getString("Phone"));
                o.setCreatedAt(rs.getTimestamp("CreatedAt"));

                list.add(o);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return list;
    }

    /**
     * Lấy chi tiết đơn hàng theo ID
     */
    public Order getOrderById(int orderId) {
        String sql = "SELECT * FROM [Order] WHERE OrderID = ?";
        try ( PreparedStatement ps = getConnection().prepareStatement(sql)) {
            ps.setInt(1, orderId);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                Order o = new Order();
                o.setOrderID(rs.getInt("OrderID"));
                o.setStaffID(rs.getString("StaffID"));
                o.setCustomerID(rs.getString("CustomerID"));

                Object voucherValue = rs.getObject("VoucherID");
                if (voucherValue != null) {
                    o.setVoucherID((Integer) voucherValue);
                }

                o.setStatus(rs.getString("Status"));
                o.setPaymentMethod(rs.getString("PaymentMethod"));
                o.setTotalPrice(rs.getBigDecimal("TotalPrice"));
                o.setAddress(rs.getString("Address"));
                o.setPhone(rs.getString("Phone"));
                o.setCreatedAt(rs.getTimestamp("CreatedAt"));
                return o;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    public List<Double> getMonthlyRevenueByYear(int year) {
        List<Double> list = new ArrayList<>();
        String query = "WITH Months AS (\n"
                + "    SELECT 1 AS Month\n"
                + "    UNION ALL SELECT 2\n"
                + "    UNION ALL SELECT 3\n"
                + "    UNION ALL SELECT 4\n"
                + "    UNION ALL SELECT 5\n"
                + "    UNION ALL SELECT 6\n"
                + "    UNION ALL SELECT 7\n"
                + "    UNION ALL SELECT 8\n"
                + "    UNION ALL SELECT 9\n"
                + "    UNION ALL SELECT 10\n"
                + "    UNION ALL SELECT 11\n"
                + "    UNION ALL SELECT 12\n"
                + ")\n"
                + "SELECT \n"
                + "    m.Month,\n"
                + "    ISNULL(SUM(o.TotalPrice), 0) AS Revenue\n"
                + "FROM Months m\n"
                + "LEFT JOIN [Order] o ON MONTH(o.CreatedAt) = m.Month \n"
                + "    AND YEAR(o.CreatedAt) = ? \n"
                + "    AND o.Status = 'COMPLETED'\n"
                + "GROUP BY m.Month\n"
                + "ORDER BY m.Month;";
        try {
            Object[] params = {year};
            ResultSet rs = this.executeQuery(query, params);
            while (rs.next()) {
                // cột 1 = month, cột 2 = revenue
                list.add(rs.getDouble(2));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    public List<Integer> getMonthlyOrderCountByYear(int year) {
        List<Integer> list = new ArrayList<>();
        String query = "WITH Months AS (\n"
                + "    SELECT 1 AS Month\n"
                + "    UNION ALL SELECT 2\n"
                + "    UNION ALL SELECT 3\n"
                + "    UNION ALL SELECT 4\n"
                + "    UNION ALL SELECT 5\n"
                + "    UNION ALL SELECT 6\n"
                + "    UNION ALL SELECT 7\n"
                + "    UNION ALL SELECT 8\n"
                + "    UNION ALL SELECT 9\n"
                + "    UNION ALL SELECT 10\n"
                + "    UNION ALL SELECT 11\n"
                + "    UNION ALL SELECT 12\n"
                + ")\n"
                + "SELECT \n"
                + "    m.Month,\n"
                + "    COUNT(o.OrderID) AS OrderCount\n"
                + "FROM \n"
                + "    Months m\n"
                + "LEFT JOIN \n"
                + "    [Order] o ON MONTH(o.CreatedAt) = m.Month AND YEAR(o.CreatedAt) = ? AND o.Status = 'COMPLETED'\n"
                + "GROUP BY \n"
                + "    m.Month\n"
                + "ORDER BY \n"
                + "    m.Month;";

        try {
            Object[] params = {year};
            ResultSet rs = this.executeQuery(query, params);
            while (rs.next()) {
                list.add(rs.getInt(2));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    public List<Map<String, Object>> getTop10StaffByOrderCount(int year) {
        List<Map<String, Object>> list = new ArrayList<>();
        String query = "SELECT TOP 10 \n"
                + "    s.StaffID, \n"
                + "    s.StaffName, \n"
                + "    COUNT(o.OrderID) AS OrderCount\n"
                + "FROM \n"
                + "    [Order] o\n"
                + "JOIN \n"
                + "    Staff s ON o.StaffID = s.StaffID\n"
                + "WHERE \n"
                + "    o.Status = 'COMPLETED' and YEAR(o.CreatedAt) = ?\n"
                + "GROUP BY \n"
                + "    s.StaffID, s.StaffName\n"
                + "ORDER BY \n"
                + "    OrderCount DESC;";

        try {
            Object[] params = {year};
            ResultSet rs = this.executeQuery(query, params);
            while (rs.next()) {
                Map<String, Object> map = new HashMap<>();
                map.put("StaffID", rs.getString("StaffID"));
                map.put("StaffName", rs.getString("StaffName"));
                map.put("OrderCount", rs.getInt("OrderCount"));
                list.add(map);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    public BigDecimal getTotalProfit() {
        BigDecimal totalProfit = BigDecimal.ZERO;
        String query = "SELECT SUM(TotalPrice) AS TotalPrice\n"
                + "FROM [Order]\n"
                + "WHERE MONTH(CreatedAt) = MONTH(GETDATE()) \n"
                + "AND YEAR(CreatedAt) = YEAR(GETDATE());";
        try {
            ResultSet rs = this.executeQuery(query);
            if (rs.next()) {
                totalProfit = rs.getBigDecimal("TotalPrice");
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return totalProfit;
    }

    public int getTotalFeedbackInMonth() {
        int total = 0;
        String query = "SELECT COUNT(FeedbackID) AS TotalFeedback\n"
                + "FROM Feedback\n"
                + "WHERE MONTH(CreatedAt) = MONTH(GETDATE()) AND YEAR(CreatedAt) = YEAR(GETDATE());";
        try {
            ResultSet rs = this.executeQuery(query);
            if (rs.next()) {
                total = rs.getInt("TotalFeedback");
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return total;
    }

    public int getTotalOrdersInMonth() {
        int total = 0;
        String query = "SELECT COUNT(OrderID) AS TotalOrders\n"
                + "FROM [Order]\n"
                + "WHERE MONTH(CreatedAt) = MONTH(GETDATE()) AND YEAR(CreatedAt) = YEAR(GETDATE());";
        try {
            ResultSet rs = this.executeQuery(query);
            if (rs.next()) {
                total = rs.getInt("TotalOrders");
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return total;
    }

    public int getTotalCustomers() {
        int total = 0;
        String query = "SELECT COUNT(CustomerID) AS TotalCustomers\n"
                + "FROM Customer";
        try {
            ResultSet rs = this.executeQuery(query);
            if (rs.next()) {
                total = rs.getInt("TotalCustomers");
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return total;
    }
}
