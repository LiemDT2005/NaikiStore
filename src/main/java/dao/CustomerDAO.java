package dao;

import db.DBContext;
import models.Customers;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

/**
 *
 * @author Tran Gia Dat - CE190694
 */
public class CustomerDAO {

    private final Connection conn = new DBContext().getConnection();

    private Customers map(ResultSet rs) throws SQLException {
        Customers c = new Customers();
        c.setCustomerID(rs.getString("CustomerID"));
        c.setCustomerName(rs.getString("CustomerName"));
        c.setEmail(rs.getString("Email"));
        c.setPhone(rs.getString("Phone"));
        c.setGender(rs.getString("Gender"));
        c.setAddress(rs.getString("Address"));
        c.setStatus(rs.getString("Status"));
        try {
            c.setAvatar(rs.getString("Avatar"));
        } catch (SQLException ignored) {
        }
        return c;
    }

    public int countAll(String keyword) {
        String base = "SELECT COUNT(*) FROM Customer";
        String where = (keyword != null && !keyword.trim().isEmpty()) ? " WHERE CustomerName LIKE ? OR Email LIKE ?" : "";
        String sql = base + where;
        try (
                 PreparedStatement ps = conn.prepareStatement(sql)) {
            if (!where.isEmpty()) {
                String like = "%" + keyword.trim() + "%";
                ps.setString(1, like);
                ps.setString(2, like);
            }
            try ( ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return rs.getInt(1);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return 0;
    }

    public List<Customers> getAllCustomers(int page, int size) {
        List<Customers> list = new ArrayList<>();
        int offset = (page - 1) * size;
        System.out.println("getAllCustomers - page: " + page + ", size: " + size + ", offset: " + offset);
        String sql = "SELECT * FROM Customer ORDER BY CustomerID OFFSET ? ROWS FETCH NEXT ? ROWS ONLY";
        try (
                 PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, offset);
            ps.setInt(2, size);
            try ( ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    list.add(map(rs));
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        System.out.println("getAllCustomers - result size: " + list.size());
        return list;
    }

    public List<Customers> searchCustomers(String keyword, int page, int size) {
        List<Customers> list = new ArrayList<>();
        int offset = (page - 1) * size;
        System.out.println("searchCustomers - keyword: '" + keyword + "', page: " + page + ", size: " + size + ", offset: " + offset);
        String sql = "SELECT * FROM Customer WHERE CustomerName LIKE ? OR Email LIKE ? ORDER BY CustomerID OFFSET ? ROWS FETCH NEXT ? ROWS ONLY";
        try (
                 PreparedStatement ps = conn.prepareStatement(sql)) {
            String like = "%" + keyword.trim() + "%";
            ps.setString(1, like);
            ps.setString(2, like);
            ps.setInt(3, offset);
            ps.setInt(4, size);
            try ( ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    list.add(map(rs));
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        System.out.println("searchCustomers - result size: " + list.size());
        return list;
    }

    public List<Customers> getAllCustomers() {
        List<Customers> list = new ArrayList<>();
        String sql = "SELECT * FROM Customer ORDER BY CustomerID";
        try (
                 PreparedStatement ps = conn.prepareStatement(sql);  ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                list.add(map(rs));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    public List<Customers> searchCustomers(String keyword) {
        List<Customers> list = new ArrayList<>();
        String sql = "SELECT * FROM Customer WHERE CustomerName LIKE ? OR Email LIKE ? ORDER BY CustomerID";
        try (
                 PreparedStatement ps = conn.prepareStatement(sql)) {
            String like = "%" + keyword.trim() + "%";
            ps.setString(1, like);
            ps.setString(2, like);
            try ( ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    list.add(map(rs));
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    public Customers getCustomerById(String id) {
        String sql = "SELECT * FROM Customer WHERE CustomerID = ?";
        try (
                 PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, id);
            try ( ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return map(rs);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    public boolean updateStatus(String customerId, String newStatus) {
        String sql = "UPDATE Customer SET Status = ? WHERE CustomerID = ?";
        try (
                 PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, newStatus);
            ps.setString(2, customerId);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }
}
