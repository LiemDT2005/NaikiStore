package dao;

import db.DBContext;
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

public class VoucherDAO {
    private final Connection conn = new DBContext().getConnection();

    private models.Voucher map(ResultSet rs) throws SQLException {
        models.Voucher v = new models.Voucher();
        v.setVoucherID(rs.getInt("VoucherID"));
        try { v.setName(rs.getString("Name")); } catch (SQLException ignored) {}
        v.setCode(rs.getString("Code"));
        v.setDescription(rs.getString("Description"));
        try { v.setDiscountPercentage(rs.getBigDecimal("DiscountPercentage")); } catch (SQLException ignored) {}
        try { v.setMaxReducing(rs.getBigDecimal("MaxReducing")); } catch (SQLException ignored) {}
        try { v.setMinOrderValue(rs.getBigDecimal("MinOrderValue")); } catch (SQLException ignored) {}
        try { v.setExpiryDate(rs.getDate("ExpiryDate")); } catch (SQLException ignored) {}
        try { v.setQuantity(rs.getInt("Quantity")); } catch (SQLException ignored) {}
        try { v.setActive(rs.getBoolean("IsActive")); } catch (SQLException ignored) {}
        try { v.setUsageCount((Integer)rs.getObject("UsageCount")); } catch (SQLException ignored) {}
        try { v.setMaxUsagePerUser((Integer)rs.getObject("MaxUsagePerUser")); } catch (SQLException ignored) {}
        return v;
    }

    public List<models.Voucher> getAllAvailableVouchers() {
        List<models.Voucher> list = new ArrayList<>();
        String sql = "SELECT * FROM Voucher WHERE IsActive = 1 AND ExpiryDate > GETDATE() ORDER BY ExpiryDate ASC";
        try (
             PreparedStatement ps = conn.prepareStatement(sql)) {
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    list.add(map(rs));
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    public models.Voucher getVoucherById(int id) {
        String sql = "SELECT * FROM Voucher WHERE VoucherID = ?";
        try (
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, id);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return map(rs);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    public List<models.Voucher> getAllVouchersForManager(String keyword, String status, String sortBy) {
        List<models.Voucher> list = new ArrayList<>();
        StringBuilder sql = new StringBuilder("SELECT * FROM Voucher WHERE 1=1");
        List<Object> params = new ArrayList<>();

        if (keyword != null && !keyword.trim().isEmpty()) {
            sql.append(" AND (Name LIKE ? OR Code LIKE ?)");
            String like = "%" + keyword.trim() + "%";
            params.add(like);
            params.add(like);
        }
        if (status != null && !status.trim().isEmpty()) {
            String s = status.trim().toLowerCase();
            if (s.equals("active") || s.equals("1") || s.equals("true")) {
                sql.append(" AND IsActive = 1");
            } else if (s.equals("inactive") || s.equals("0") || s.equals("false")) {
                sql.append(" AND IsActive = 0");
            }
        }
        // Sorting
        String orderBy;
        if (sortBy == null || sortBy.isEmpty() || sortBy.equalsIgnoreCase("newest")) {
            orderBy = " ORDER BY VoucherID DESC";
        } else if (sortBy.equalsIgnoreCase("oldest")) {
            orderBy = " ORDER BY VoucherID ASC";
        } else if (sortBy.equalsIgnoreCase("expiry_asc")) {
            orderBy = " ORDER BY ExpiryDate ASC";
        } else if (sortBy.equalsIgnoreCase("expiry_desc")) {
            orderBy = " ORDER BY ExpiryDate DESC";
        } else {
            orderBy = " ORDER BY VoucherID DESC";
        }
        sql.append(orderBy);

        try (PreparedStatement ps = conn.prepareStatement(sql.toString())) {
            for (int i = 0; i < params.size(); i++) {
                ps.setObject(i + 1, params.get(i));
            }
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    list.add(map(rs));
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    public boolean addVoucher(models.Voucher v) {
        // Basic duplicate code check
        String checkSql = "SELECT COUNT(*) FROM Voucher WHERE Code = ?";
        String insertSql = "INSERT INTO Voucher (Code, Description, DiscountPercentage, MaxReducing, MinOrderValue, ExpiryDate, Quantity, Name, IsActive, UsageCount, MaxUsagePerUser) " +
                "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
        try {
            try (PreparedStatement cps = conn.prepareStatement(checkSql)) {
                cps.setString(1, v.getCode());
                try (ResultSet rs = cps.executeQuery()) {
                    if (rs.next() && rs.getInt(1) > 0) {
                        return false;
                    }
                }
            }
            try (PreparedStatement ps = conn.prepareStatement(insertSql)) {
                ps.setString(1, v.getCode());
                ps.setString(2, v.getDescription());
                ps.setBigDecimal(3, v.getDiscountPercentage());
                ps.setBigDecimal(4, v.getMaxReducing());
                ps.setBigDecimal(5, v.getMinOrderValue());
                ps.setDate(6, v.getExpiryDate());
                ps.setInt(7, v.getQuantity());
                ps.setString(8, v.getName());
                ps.setBoolean(9, v.isActive());
                // UsageCount default to 0 if null
                Integer usage = v.getUsageCount();
                if (usage == null) usage = 0;
                ps.setInt(10, usage);
                if (v.getMaxUsagePerUser() == null) {
                    ps.setNull(11, java.sql.Types.INTEGER);
                } else {
                    ps.setInt(11, v.getMaxUsagePerUser());
                }
                int rows = ps.executeUpdate();
                return rows > 0;
            }
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    public boolean updateVoucher(models.Voucher v) {
        String sql = "UPDATE Voucher SET Code = ?, Description = ?, DiscountPercentage = ?, MaxReducing = ?, MinOrderValue = ?, ExpiryDate = ?, Quantity = ?, Name = ?, IsActive = ?, MaxUsagePerUser = ? WHERE VoucherID = ?";
        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, v.getCode());
            ps.setString(2, v.getDescription());
            ps.setBigDecimal(3, v.getDiscountPercentage());
            ps.setBigDecimal(4, v.getMaxReducing());
            ps.setBigDecimal(5, v.getMinOrderValue());
            ps.setDate(6, v.getExpiryDate());
            ps.setInt(7, v.getQuantity());
            ps.setString(8, v.getName());
            ps.setBoolean(9, v.isActive());
            if (v.getMaxUsagePerUser() == null) {
                ps.setNull(10, java.sql.Types.INTEGER);
            } else {
                ps.setInt(10, v.getMaxUsagePerUser());
            }
            ps.setInt(11, v.getVoucherID());
            int rows = ps.executeUpdate();
            return rows > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    public boolean deleteVoucher(int voucherId) {
        String sql = "DELETE FROM Voucher WHERE VoucherID = ?";
        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, voucherId);
            int rows = ps.executeUpdate();
            return rows > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
}
