/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dao;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import db.DBContext;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import models.Customer;
import models.Staff;
import utils.PasswordUtils;

/**
 *
 * @author Do Ho Gia Huy - CE191293
 */
public class StaffsDAO extends DBContext {

    public List<Staff> getAllStaffs(String gender, String status) {
        List<Staff> staffs = new ArrayList<>();
        String sql = "SELECT StaffID, StaffName, Email, Phone, Gender, Status, Address, CitizenID FROM Staff WHERE [Status] != 'DELETED' AND Role != 'ADMIN'";
        List<Object> params = new ArrayList<>();
        if (!gender.equalsIgnoreCase("all")) {
            sql += " AND Gender = ?";
            params.add(gender);
        }
        if (!status.equalsIgnoreCase("all")) {
            sql += " AND Status = ?";
            params.add(status);
        }
        try ( ResultSet rs = executeQuery(sql, params.isEmpty() ? null : params.toArray())) {
            while (rs.next()) {
                Staff staff = new Staff();
                staff.setStaffID(rs.getString("StaffID"));
                staff.setStaffName(rs.getString("StaffName"));
                staff.setEmail(rs.getString("Email"));
                staff.setPhone(rs.getString("Phone"));
                staff.setGender(Staff.Gender.valueOf(rs.getString("Gender")));
                staff.setStatus(Staff.Status.valueOf(rs.getString("Status")));
                staff.setAddress(rs.getString("Address"));
                staff.setCitizenID(rs.getString("CitizenID"));
                staffs.add(staff);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return staffs;
    }

    public String createStaffID() {
        String sql = "SELECT StaffID FROM Staff";
        try ( ResultSet rs = executeQuery(sql)) {
            int maxNumber = 0;
            while (rs.next()) {
                String id = rs.getString(1);
                if (id != null) {
                    int number = extractStaffNumber(id);
                    if (number > maxNumber) {
                        maxNumber = number;
                    }
                }
            }
            return String.format("ST%04d", maxNumber + 1);
        } catch (Exception e) {
            System.out.println("Error in createStaffID: " + e.getMessage());
        }
        return null;
    }

    private int extractStaffNumber(String id) {
        Pattern pattern = Pattern.compile("ST(\\d+)");
        Matcher matcher = pattern.matcher(id);
        if (matcher.matches()) {
            return Integer.parseInt(matcher.group(1));
        }
        throw new IllegalArgumentException("Invalid StaffID format: " + id);
    }

    public void addStaff(Staff staff) {
        String staffID = createStaffID();
        staff.setStaffID(staffID);
        String sql = "INSERT INTO Staff (StaffID, StaffName, Password, Phone, Role, Email, Gender, Status, Address, CitizenID) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
        try {
            executeNonQuery(sql, new Object[]{
                staff.getStaffID(),
                staff.getStaffName(),
                staff.getPassword(),
                staff.getPhone(),
                staff.getRole().name(),
                staff.getEmail(),
                staff.getGender(),
                staff.getStatus().name(),
                staff.getAddress(),
                staff.getCitizenID()
            });
            System.out.println("Staff added successfully with ID: " + staffID);
        } catch (Exception e) {
            System.out.println("Error while adding staff: " + e.getMessage());
        }
    }

    public boolean isEmailExists(String email) {
        String sql = "SELECT COUNT(*) FROM Staff WHERE Email = ?";
        try ( ResultSet rs = executeQuery(sql, new Object[]{email})) {
            if (rs.next() && rs.getInt(1) > 0) {
                return true;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    public Staff getStaffById(String staffId) {
        Staff staff = null;
        String sql = "SELECT StaffID, StaffName, Password, Phone, Role, Email, Gender, Status, Address, CitizenID FROM Staff WHERE StaffID = ?";
        try ( ResultSet rs = executeQuery(sql, new Object[]{staffId})) {
            if (rs.next()) {
                staff = new Staff();
                staff.setStaffID(rs.getString("StaffID"));
                staff.setStaffName(rs.getString("StaffName"));
                staff.setPassword(rs.getString("Password"));
                staff.setPhone(rs.getString("Phone"));
                staff.setRole(Staff.Role.valueOf(rs.getString("Role")));
                staff.setEmail(rs.getString("Email"));
                staff.setGender(Staff.Gender.valueOf(rs.getString("Gender")));
                staff.setStatus(Staff.Status.valueOf(rs.getString("Status")));
                staff.setAddress(rs.getString("Address"));
                staff.setCitizenID(rs.getString("CitizenID"));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return staff;
    }

    public void updateStaff(Staff staff) {
        String sql = "UPDATE Staff SET StaffName=?, Password=?, Phone=?, Role=?, Email=?, Gender=?, Status=?, Address=?, CitizenID=? WHERE StaffID=?";
        try {
            executeNonQuery(sql, new Object[]{
                staff.getStaffName(),
                staff.getPassword(),
                staff.getPhone(),
                staff.getRole().name(),
                staff.getEmail(),
                staff.getGender(),
                staff.getStatus().name(),
                staff.getAddress(),
                staff.getCitizenID(),
                staff.getStaffID()
            });
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public void updateStaffProfile(Staff staff) {
        String sql = "UPDATE Staff SET StaffName=?, Phone=?, Email=?, Gender=?, Address=?, Avatar=? WHERE StaffID=?";
        try {
            executeNonQuery(sql, new Object[]{
                staff.getStaffName(),
                staff.getPhone(),
                staff.getEmail(),
                staff.getGender(),
                staff.getAddress(),
                staff.getAvatar(),
                staff.getStaffID()
            });
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public boolean deleteStaffById(String staffId) {
        String sql = "UPDATE Staff SET Status = 'DELETED' WHERE StaffID = ?";
        try {
            int rowsAffected = executeNonQuery(sql, new Object[]{staffId});
            return rowsAffected > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    public Staff getStaffByID(String staffID) {
        Staff staff = null;
        String sql = "SELECT StaffID, StaffName, Email, Avatar, TokenExpiry, Password, Phone, Gender, Address, Role, SupervisorID, Status, PasswordRecoveryToken, HireDate, CitizenID FROM Staff WHERE StaffID = ?";
        try ( ResultSet rs = executeQuery(sql, new Object[]{staffID})) {
            if (rs.next()) {
                staff = new Staff();
                staff.setStaffID(rs.getString("StaffID"));
                staff.setStaffName(rs.getString("StaffName"));
                staff.setEmail(rs.getString("Email"));
                staff.setAvatar(rs.getString("Avatar"));
                staff.setTokenExpiry(rs.getTimestamp("TokenExpiry"));
                staff.setPassword(rs.getString("Password"));
                staff.setPhone(rs.getString("Phone"));
                staff.setGender(Staff.Gender.valueOf(rs.getString("Gender")));
                staff.setAddress(rs.getString("Address"));
                staff.setRole(Staff.Role.valueOf(rs.getString("Role")));
                // Nếu cần supervisor, có thể gọi lại getStaffByID(rs.getString("SupervisorID"))
                staff.setStatus(Staff.Status.valueOf(rs.getString("Status")));
                staff.setPasswordRecoveryToken(rs.getString("PasswordRecoveryToken"));
                staff.setHireDate(rs.getTimestamp("HireDate"));
                staff.setCitizenID(rs.getString("CitizenID"));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return staff;
    }

    public Staff loginWithEmailAndPassword(String email, String password) {
        Staff staff = null;
        String query = "SELECT * FROM Staff WHERE Email = ? AND Status != 'DELETED'";
        try ( ResultSet rs = executeQuery(query, new Object[]{email})) {
            while (rs.next()) {
                String hashedPassword = rs.getString("Password");
                if (PasswordUtils.checkPassword(password, hashedPassword)) {
                    staff = new Staff();
                    staff.setStaffID(rs.getString("StaffID"));
                    staff.setStaffName(rs.getString("StaffName"));
                    staff.setEmail(rs.getString("Email"));
                    staff.setAvatar(rs.getString("Avatar"));
                    staff.setPassword(rs.getString("Password"));
                    staff.setPhone(rs.getString("Phone"));
                    staff.setAddress(rs.getString("Address"));
                    staff.setRole(Staff.Role.valueOf(rs.getString("Role")));
                    staff.setStatus(Staff.Status.valueOf(rs.getString("Status")));
                    staff.setGender(Staff.Gender.valueOf(rs.getString("Gender")));
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return staff;
    }

    public Staff getStaffByEmail(String email) {
        Staff staff = null;
        String query = "SELECT * FROM Staff WHERE Email = ?";
        try ( ResultSet rs = executeQuery(query, new Object[]{email})) {
            while (rs.next()) {
                staff = new Staff();
                staff.setStaffID(rs.getString("StaffID"));
                staff.setStaffName(rs.getString("StaffName"));
                staff.setEmail(rs.getString("Email"));
                staff.setAvatar(rs.getString("Avatar"));
                staff.setTokenExpiry(rs.getTimestamp("TokenExpiry"));
                staff.setPassword(rs.getString("Password"));
                staff.setPhone(rs.getString("Phone"));
                staff.setGender(Staff.Gender.valueOf(rs.getString("Gender")));
                staff.setAddress(rs.getString("Address"));
                staff.setRole(Staff.Role.valueOf(rs.getString("Role")));
                // Nếu cần supervisor, có thể gọi lại getStaffByID(rs.getString("SupervisorID"))
                staff.setStatus(Staff.Status.valueOf(rs.getString("Status")));
                staff.setPasswordRecoveryToken(rs.getString("PasswordRecoveryToken"));
                staff.setHireDate(rs.getTimestamp("HireDate"));
                staff.setCitizenID(rs.getString("CitizenID"));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return staff;
    }

    public boolean checkCitizenIDExists(String citizenID, String staffID) {
        String query = "SELECT COUNT(*) FROM Staff WHERE CitizenID = ?";
        Object[] params;
        if (staffID != null && !staffID.isEmpty()) {
            query += " AND StaffID = ?";
            params = new Object[]{citizenID, staffID};
        } else {
            params = new Object[]{citizenID};
        }
        try ( ResultSet rs = executeQuery(query, params)) {
            if (rs.next()) {
                return rs.getInt(1) > 0;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    public ArrayList<Staff> getSearchStaffs(String keyword) {
        ArrayList<Staff> staffList = new ArrayList<>();
        String sql = "SELECT StaffID, StaffName, Email, Avatar, TokenExpiry, Password, Phone, Gender, Address, Role, SupervisorID, Status, PasswordRecoveryToken, HireDate, CitizenID "
                + "FROM Staff "
                + "WHERE Role != 'ADMIN' AND (StaffID LIKE ? OR StaffName LIKE ? OR CitizenID LIKE ?)";
        String searchPattern = "%" + keyword + "%";
        try ( ResultSet rs = executeQuery(sql, new Object[]{searchPattern, searchPattern, searchPattern})) {
            while (rs.next()) {
                Staff staff = new Staff();
                staff.setStaffID(rs.getString("StaffID"));
                staff.setStaffName(rs.getString("StaffName"));
                staff.setEmail(rs.getString("Email"));
                staff.setAvatar(rs.getString("Avatar"));
                staff.setTokenExpiry(rs.getTimestamp("TokenExpiry"));
                staff.setPassword(rs.getString("Password"));
                staff.setPhone(rs.getString("Phone"));
                staff.setGender(Staff.Gender.valueOf(rs.getString("Gender")));
                staff.setAddress(rs.getString("Address"));
                staff.setRole(Staff.Role.valueOf(rs.getString("Role")));
                staff.setStatus(Staff.Status.valueOf(rs.getString("Status")));
                staff.setPasswordRecoveryToken(rs.getString("PasswordRecoveryToken"));
                staff.setHireDate(rs.getTimestamp("HireDate"));
                staff.setCitizenID(rs.getString("CitizenID"));
                staffList.add(staff);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return staffList;
    }
    // Lưu token khôi phục mật khẩu và thời gian hết hạn của token
    public void saveResetToken(String email, String token, LocalDateTime expiryTime) {
        String sql = "UPDATE Staff SET PasswordRecoveryToken = ?, TokenExpiry = ? WHERE Email = ?";
        try {
            executeNonQuery(sql, new Object[]{
                token,
                expiryTime.format(DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss")),
                email
            });
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    // Kiểm tra tính hợp lệ của token (thời gian hết hạn)
    public boolean isTokenValid(String token) {
        String sql = "SELECT TokenExpiry FROM Staff WHERE PasswordRecoveryToken = ?";
        try (ResultSet rs = executeQuery(sql, new Object[]{token})) {
            if (rs.next()) {
                LocalDateTime tokenExpiry = rs.getTimestamp("TokenExpiry").toLocalDateTime();
                return tokenExpiry.isAfter(LocalDateTime.now());
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    public void updatePasswordByEmail(String email, String newPassword) {
        String sql = "UPDATE Staff SET password = ? WHERE email = ?";
        try {
            executeNonQuery(sql, new Object[]{newPassword, email});
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
}
