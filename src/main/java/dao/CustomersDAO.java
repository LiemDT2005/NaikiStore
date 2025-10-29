/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dao;

import db.DBContext;
import models.Customer;
import models.Customer.Gender;
import models.Customer.Status;
import utils.PasswordUtils;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.List;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

/**
 *
 * @author Do Ho Gia Huy - CE191293
 */
public class CustomersDAO extends DBContext {

    public Customer loginWithEmailAndPassword(String email, String password) {
        Customer user = null;
        String query = "SELECT * FROM Customer WHERE Email = ?";
        try (ResultSet rs = executeQuery(query, new Object[]{email})) {
            while (rs.next()) {
                String hashedPassword = rs.getString("Password");
                if (PasswordUtils.checkPassword(password, hashedPassword)) {
                    user = new Customer();
                    user.setCustomerId(rs.getString("CustomerID"));
                    user.setCustomerName(rs.getString("CustomerName"));
                    user.setEmail(rs.getString("Email"));
                    user.setAvatar(rs.getString("Avatar"));
                    user.setPassword(rs.getString("Password"));
                    user.setPhone(rs.getString("Phone"));
                    user.setAddress(rs.getString("Address"));
                    user.setStatus(Status.valueOf(rs.getString("Status")));
                    user.setGender(Gender.valueOf(rs.getString("Gender")));
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return user;
    }

    public boolean emailExists(String email) {
        String query = "SELECT COUNT(*) FROM Customer WHERE Email = ?";
        try (ResultSet rs = executeQuery(query, new Object[]{email})) {
            if (rs.next()) {
                return rs.getInt(1) > 0;
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    //get next customerId to create new customer
    public String createCustomerID() {
        String sql = "SELECT CustomerID FROM Customer";
        try (ResultSet rs = executeQuery(sql)) {
            int maxNumber = 0;
            while (rs.next()) {
                String id = rs.getString(1);
                if (id != null) {
                    int number = extractNumber(id);
                    if (number > maxNumber) {
                        maxNumber = number;
                    }
                }
            }
            return String.format("C%03d", maxNumber + 1);
        } catch (Exception e) {
            System.out.println("Error function getNextCustomerId: " + e.getMessage());
        }
        return null;
    }

    //get number id max
    private int extractNumber(String id) {
        Pattern pattern = Pattern.compile("C(\\d+)");
        Matcher matcher = pattern.matcher(id);
        if (matcher.matches()) {
            return Integer.parseInt(matcher.group(1));
        }
        throw new IllegalArgumentException("Invalid ID format: " + id);
    }

    public void registerUser(Customer user) {
        String customerID = createCustomerID();
        user.setCustomerId(customerID);
        String sql = "INSERT INTO Customer (CustomerID, CustomerName, Email, Password, Phone, Address, Gender, Avatar, Status) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)";
        try {
            executeNonQuery(sql, new Object[]{
                    user.getCustomerId(),
                    user.getCustomerName(),
                    user.getEmail(),
                    user.getPassword(),
                    user.getPhone(),
                    user.getAddress(),
                    user.getGender().name(),
                    user.getAvatar(),
                    user.getStatus().name()
            });
            System.out.println("User registered successfully with ID: " + customerID);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
    public void registerUserAPI(Customer user) {
        String customerID = createCustomerID();
        user.setCustomerId(customerID);
        String sql = "INSERT INTO Customer (CustomerID, CustomerName, Email, Password, Gender, Avatar, Status) VALUES (?, ?, ?, ?, ?, ?, ?)";
        try {
            executeNonQuery(sql, new Object[]{
                user.getCustomerId(),
                user.getCustomerName(),
                user.getEmail(),
                user.getPassword(),
                user.getGender().name(),
                user.getAvatar(),
                user.getStatus().name()
            });
            System.out.println("User registered successfully with ID: " + customerID);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
    

    public Customer getUserByEmail(String email) {
        Customer user = null;
        String query = "SELECT * FROM Customer WHERE Email = ?";
        try (ResultSet rs = executeQuery(query, new Object[]{email})) {
            while (rs.next()) {
                user = new Customer();
                user.setCustomerId(rs.getString("CustomerID"));
                user.setCustomerName(rs.getString("CustomerName"));
                user.setEmail(rs.getString("Email"));
                user.setPhone(rs.getString("Phone"));
                user.setAddress(rs.getString("Address"));
                user.setStatus(Status.valueOf(rs.getString("Status")));
                user.setAvatar(rs.getString("Avatar"));
                user.setGender(Gender.valueOf(rs.getString("Gender")));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return user;
    }

    public void updatePassword(String customerId, String newPassword) {
        String sql = "UPDATE Customer SET Password = ? WHERE CustomerID = ?";
        try {
            String hashedPassword = PasswordUtils.hashPassword(newPassword);
            executeNonQuery(sql, new Object[]{hashedPassword, customerId});
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    // Lưu token khôi phục mật khẩu và thời gian hết hạn của token
    public void saveResetToken(String email, String token, LocalDateTime expiryTime) {
        String sql = "UPDATE Customer SET PasswordRecoveryToken = ?, TokenExpiry = ? WHERE Email = ?";
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
        String sql = "SELECT TokenExpiry FROM Customer WHERE PasswordRecoveryToken = ?";
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
        String sql = "UPDATE Customer SET password = ? WHERE email = ?";
        try {
            executeNonQuery(sql, new Object[]{newPassword, email});
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public void updateCustomer(Customer user) {
        String sql = "UPDATE Customer SET CustomerName = ?, Phone = ?, Address = ?, Avatar = ?, Gender = ? WHERE CustomerID = ?";
        try {
            executeNonQuery(sql, new Object[]{
                    user.getCustomerName(),
                    user.getPhone(),
                    user.getAddress(),
                    user.getAvatar(),
                    user.getGender().name(),
                    user.getCustomerId()
            });
            System.out.println("Save profile successfully with ID: " + user.getCustomerId());
        } catch (Exception e) {
            e.printStackTrace();
            
        }
    }


    public Customer getCustomerByID(String id) {
        Customer user = null;
        String query = "SELECT * FROM Customer WHERE CustomerID = ?";
        try (ResultSet rs = executeQuery(query, new Object[]{id})) {
            while (rs.next()) {
                user = new Customer();
                user.setCustomerId(rs.getString("CustomerID"));
                user.setCustomerName(rs.getString("CustomerName"));
                user.setEmail(rs.getString("Email"));
                user.setAvatar(rs.getString("Avatar"));
                user.setPassword(rs.getString("Password"));
                user.setPhone(rs.getString("Phone"));
                user.setAddress(rs.getString("Address"));
                user.setStatus(Status.valueOf(rs.getString("Status")));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return user;
    }

    public Customer getUserByID(String id) {
        Customer user = null;
        String query = "SELECT * FROM Customer WHERE CustomerID = ?";
        try (ResultSet rs = executeQuery(query, new Object[]{id})) {
            while (rs.next()) {
                user = new Customer();
                user.setCustomerId(rs.getString("CustomerID"));
                user.setCustomerName(rs.getString("CustomerName"));
                user.setEmail(rs.getString("Email"));
                user.setPhone(rs.getString("Phone"));
                user.setAddress(rs.getString("Address"));
                user.setStatus(Status.valueOf(rs.getString("Status")));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return user;
    }

    public void updateUser(Customer customer) {
        String sql = "UPDATE Customer SET CustomerName = ?, Email = ?, Phone = ?, Address = ?, Avatar = ? WHERE CustomerID = ?";
        try {
            executeNonQuery(sql, new Object[]{
                    customer.getCustomerName(),
                    customer.getEmail(),
                    customer.getPhone(),
                    customer.getAddress(),
                    customer.getAvatar(),
                    customer.getCustomerId()
            });
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public List<Customer> getAllCustomers() {
        List<Customer> customersList = new ArrayList<>();
        String query = "SELECT * FROM Customer";
        try (ResultSet rs = executeQuery(query)) {
            while (rs.next()) {
                Customer customer = new Customer();
                customer.setCustomerId(rs.getString("CustomerID"));
                customer.setCustomerName(rs.getString("CustomerName"));
                customer.setEmail(rs.getString("Email"));
                customer.setPhone(rs.getString("Phone"));
                customer.setAddress(rs.getString("Address"));
                customer.setAvatar(rs.getString("Avatar"));
                customer.setStatus(Status.valueOf(rs.getString("Status")));
                customersList.add(customer);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return customersList;
    }
}
