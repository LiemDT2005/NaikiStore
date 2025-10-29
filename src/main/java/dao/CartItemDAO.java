/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
 /*
 * Author: Dang Thanh Liem - CE190697
 * Description: Data Access Object for CartItem table.
 * Handles add, update, delete, and fetch operations.
 */
package dao;

import db.DBContext;
import java.math.BigDecimal;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import models.CartItem;
import models.Product;

public class CartItemDAO extends DBContext {

    /**
     * Get all cart items of a customer by ID.
     */
    public List<CartItem> getAllCartByCustomerId(String customerId) throws SQLException {
        List<CartItem> list = new ArrayList<>();

        String sql = "SELECT ci.CartItemID, ci.Quantity, ci.CreatedAt, "
                + "pv.ProductVariantID, pv.Size, pv.Color, pv.ImageURL, "
                + "p.ProductID, p.ProductName, p.Price "
                + "FROM CartItem ci "
                + "JOIN ProductVariant pv ON ci.ProductVariantID = pv.ProductVariantID "
                + "JOIN Product p ON pv.ProductID = p.ProductID "
                + "WHERE ci.CustomerID = ? "
                + "ORDER BY ci.CreatedAt DESC";

        try (ResultSet rs = this.executeQuery(sql, new Object[]{customerId})) {
            while (rs.next()) {
                Product product = new Product();
                product.setProductId(rs.getInt("ProductID"));
                product.setProductName(rs.getString("ProductName"));
                product.setPrice(rs.getBigDecimal("Price"));

                CartItem item = new CartItem();
                item.setCartItemID(rs.getInt("CartItemID"));
                item.setCustomerID(customerId);
                item.setProductVariantID(rs.getInt("ProductVariantID"));
                item.setQuantity(rs.getInt("Quantity"));
                item.setSize(rs.getString("Size"));
                item.setColor(rs.getString("Color"));
                item.setImageURL(rs.getString("ImageURL"));
                item.setProduct(product);
                item.setPrice(product.getPrice());
                item.setCreatedAt(rs.getTimestamp("CreatedAt"));

                list.add(item);
            }
        }
        return list;
    }

    /**
     * Calculate total cart value by customer ID.
     */
    public BigDecimal getTotalByCustomerId(String customerId) throws SQLException {
        String sql = "SELECT SUM(p.Price * ci.Quantity) AS Total "
                + "FROM CartItem ci "
                + "JOIN ProductVariant pv ON ci.ProductVariantID = pv.ProductVariantID "
                + "JOIN Product p ON pv.ProductID = p.ProductID "
                + "WHERE ci.CustomerID = ?";
        try (ResultSet rs = this.executeQuery(sql, new Object[]{customerId})) {

            if (rs.next() && rs.getBigDecimal("Total") != null) {
                return rs.getBigDecimal("Total");
            }
        }
        return BigDecimal.ZERO;
    }

    /**
     * Find a specific cart item by customerID and productVariantID.
     */
    public CartItem findCartItem(String customerId, int productVariantId) throws SQLException {
        String sql = "SELECT CartItemID, Quantity FROM CartItem "
                + "WHERE CustomerID = ? AND ProductVariantID = ?";
        try (ResultSet rs = this.executeQuery(sql, new Object[]{customerId, productVariantId})) {
            if (rs.next()) {
                CartItem item = new CartItem();
                item.setCartItemID(rs.getInt("CartItemID"));
                item.setQuantity(rs.getInt("Quantity"));
                return item;
            }
        }
        return null;
    }

    /**
     * Add product to cart. If the product already exists, increase quantity.
     */
    public int addToCart(String customerId, int productVariantId, int quantity) throws SQLException {
        CartItem existing = findCartItem(customerId, productVariantId);
        int rowsAffected = 0;
        if (existing != null) {
            String update = "UPDATE CartItem SET Quantity = Quantity + ? WHERE CartItemID = ?";
            rowsAffected = this.executeNonQuery(update, new Object[]{quantity, existing.getCartItemID()});
        } else {
            String insert = "INSERT INTO CartItem (CustomerID, ProductVariantID, Quantity, CreatedAt) "
                    + "VALUES (?, ?, ?, GETDATE())";
            rowsAffected = this.executeNonQuery(insert, new Object[]{customerId, productVariantId, quantity});
        }
        return rowsAffected;
    }

    public int getCartItemCountByCustomerId(String customerId) throws SQLException {
        String sql = "SELECT SUM(Quantity) AS TotalItems FROM [CartItem] WHERE CustomerID = ?";
        try ( ResultSet rs = this.executeQuery(sql, new Object[]{customerId})) {
            if (rs.next()) {
                return rs.getInt("TotalItems");
            }
        }
        return 0;
    }

    /**
     * Update cart item quantity.
     */
    public int updateQuantity(int cartItemId, int quantity) throws SQLException {
        String sql = "UPDATE CartItem SET Quantity = ? WHERE CartItemID = ?";
        int rowsAffected = this.executeNonQuery(sql, new Object[]{quantity, cartItemId});

        if (rowsAffected == 0) {
            System.out.println("No lines are affected!");
        }
        return rowsAffected;
    }

    /**
     * Delete a cart item by its ID.
     */
    public int deleteCartById(int cartItemId) throws SQLException {
        String sql = "DELETE FROM CartItem WHERE CartItemID = ?";
        int rowsAffected = this.executeNonQuery(sql, new Object[]{cartItemId});

        if (rowsAffected == 0) {
            System.out.println("No lines are affected!");
        }
        return rowsAffected;
    }
}
