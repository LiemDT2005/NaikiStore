
/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dao;

import db.DBContext;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import models.Feedback;
import models.Product;
import utils.PaginationUtil;

/**
 *
 * @author Admin
 */
public class ProductDAO extends DBContext {

    public String productsFeedbackStar(String customerId, int productId) {
        try {
            String query = "SELECT Rating FROM Feedback\n"
                    + "WHERE CustomerID = ? AND ProductID = ?";
            Object[] params = {customerId, productId};
            ResultSet rs = this.executeQuery(query, params);
            if (rs.next()) {
                return rs.getString(1);
            }
        } catch (SQLException ex) {
            Logger.getLogger(ProductDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return null;
    }

    //Get comment
    public String productsComment(String customerId, int productId) {
        try {
            String query = "SELECT Comment FROM Feedback\n"
                    + "WHERE CustomerID = ? AND ProductID = ?";
            Object[] params = {customerId, productId};
            ResultSet rs = this.executeQuery(query, params);
            if (rs.next()) {
                return rs.getString(1);
            }
        } catch (SQLException ex) {
            Logger.getLogger(ProductDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return null;
    }

    public List<String> getAllSizeByProductId(int productId) {
        String query = "SELECT Size FROM ProductVariant\n"
                + "WHERE ProductID = ?\n"
                + "GROUP BY Size";
        List<String> listSize = new ArrayList<>();
        try {
            Object[] params = {productId};
            ResultSet rs = this.executeQuery(query, params);
            String size;
            while (rs.next()) {
                size = rs.getString(1);
                if (!(size == null || size.isEmpty())) {
                    listSize.add(size);
                }
            }
        } catch (SQLException e) {
            System.out.println(e.getCause());
        }
        return listSize;
    }

    public List<String> getAllColorByProductId(int productId) {
        String query = "SELECT Color FROM ProductVariant\n"
                + "WHERE ProductID = ?\n"
                + "GROUP BY Color";
        List<String> listColor = new ArrayList<>();
        try {
            Object[] params = {productId};
            ResultSet rs = this.executeQuery(query, params);
            String color;
            while (rs.next()) {
                color = rs.getString(1);
                if (!(color == null || color.isEmpty())) {
                    listColor.add(color);
                }
            }
        } catch (SQLException e) {
            System.out.println(e.getCause());
        }
        return listColor;
    }

    public List<Feedback> listReview(int productId) {
        List<Feedback> listReview = new ArrayList<>();
        try {
            String query = "SELECT c.CustomerName, rating, comment, f.CreatedAt FROM Feedback f\n"
                    + "JOIN Customer c ON f.CustomerID = c.CustomerID\n"
                    + "WHERE ProductID = ?";
            Object[] params = {productId};
            ResultSet rs = this.executeQuery(query, params);
            while (rs.next()) {
                listReview.add(new Feedback(rs.getString(1), rs.getInt(2), rs.getString(3), rs.getTimestamp(4).toLocalDateTime()));
            }
        } catch (SQLException ex) {
            Logger.getLogger(ProductDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return listReview;
    }

    private static final Logger LOGGER = Logger.getLogger(ProductDAO.class.getName());

    // Lấy tất cả sản phẩm (active)
    public List<Product> getAllProduct() {
        List<Product> list = new ArrayList<>();
        try {
            String query = "SELECT p.ProductID, p.CategoryID, p.ProductName, p.Description, p.Price, "
                    + "p.CreatedAt, p.UpdatedAt, p.IsActive, i.ImageURL "
                    + "FROM Product p "
                    + "LEFT JOIN ( "
                    + "    SELECT ProductID, MIN(ImageURL) AS ImageURL "
                    + "    FROM Image "
                    + "    GROUP BY ProductID "
                    + ") i ON p.ProductID = i.ProductID "
                    + "WHERE p.IsActive = 1 "
                    + "ORDER BY p.CreatedAt DESC";

            ResultSet rs = this.executeQuery(query, null);
            while (rs.next()) {
                list.add(mapRowToProductWithImage(rs));
            }
        } catch (SQLException ex) {
            LOGGER.log(Level.SEVERE, "Error in getAllProduct()", ex);
        }
        return list;
    }

    // Tìm kiếm sản phẩm theo từ khóa
    public List<Product> getProductsByNameKeyword(String keyword) {
        List<Product> list = new ArrayList<>();
        try {
            String query = "SELECT p.*, i.ImageURL "
                    + "FROM Product p "
                    + "LEFT JOIN ( "
                    + "    SELECT ProductID, MIN(ImageURL) AS ImageURL "
                    + "    FROM Image "
                    + "    GROUP BY ProductID "
                    + ") i ON p.ProductID = i.ProductID "
                    + "WHERE LOWER(p.ProductName) LIKE ? AND p.IsActive = 1 "
                    + "ORDER BY p.CreatedAt DESC";

            ResultSet rs = this.executeQuery(query, new Object[]{"%" + keyword.toLowerCase() + "%"});
            while (rs.next()) {
                list.add(mapRowToProductWithImage(rs));
            }
        } catch (SQLException ex) {
            LOGGER.log(Level.SEVERE, "Error in getProductsByNameKeyword()", ex);
        }
        return list;
    }

    // Đếm tổng số sản phẩm
    public int productsCount() {
        int count = 0;
        try {
            String query = "SELECT COUNT(*) AS Total FROM Product";
            ResultSet rs = this.executeQuery(query, null);
            if (rs.next()) {
                count = rs.getInt("Total");
            }
            System.out.println("DB connection: " + (this.getConnection() != null));
            System.out.println("Product count: " + count);
        } catch (SQLException ex) {
            LOGGER.log(Level.SEVERE, "Error in productsCount()", ex);
        }
        return count;
    }

    // Phân trang sản phẩm
    public List<Product> getPagination(int indexPage) {
        List<Product> list = new ArrayList<>();
        try {
            String query = "SELECT p.*, i.ImageURL "
                    + "FROM Product p "
                    + "LEFT JOIN ( "
                    + "    SELECT ProductID, MIN(ImageURL) AS ImageURL "
                    + "    FROM Image "
                    + "    GROUP BY ProductID "
                    + ") i ON p.ProductID = i.ProductID "
                    + "ORDER BY p.ProductID "
                    + "OFFSET ? ROWS FETCH NEXT ? ROWS ONLY";

            int offset = Math.max(0, (indexPage - 1) * PaginationUtil.NUMBER_OF_ITEMS_PER_PAGE);
            int limit = PaginationUtil.NUMBER_OF_ITEMS_PER_PAGE;

            ResultSet rs = this.executeQuery(query, new Object[]{offset, limit});
            while (rs.next()) {
                list.add(mapRowToProductWithImage(rs));
            }
        } catch (SQLException ex) {
            LOGGER.log(Level.SEVERE, "Error in getPagination()", ex);
        }
        return list;
    }

    // Lấy sản phẩm theo ID     
    public Product getProductById(int productId) {
        Product p = null;
        try {
            String query = "SELECT p.*, i.ImageURL "
                    + "FROM Product p "
                    + "LEFT JOIN ( "
                    + "    SELECT ProductID, MIN(ImageURL) AS ImageURL "
                    + "    FROM Image "
                    + "    GROUP BY ProductID "
                    + ") i ON p.ProductID = i.ProductID "
                    + "WHERE p.ProductID = ?";

            ResultSet rs = this.executeQuery(query, new Object[]{productId});
            if (rs.next()) {
                p = mapRowToProductWithImage(rs);
            }
        } catch (SQLException ex) {
            LOGGER.log(Level.SEVERE, "Error in getProductById()", ex);
        }
        return p;
    }

    // Hàm hỗ trợ: map ResultSet -> Product
    private Product mapRowToProductWithImage(ResultSet rs) throws SQLException {
        Product p = new Product();
        p.setProductId(rs.getInt("ProductID"));
        p.setCategoryId(rs.getInt("CategoryID"));
        p.setProductName(rs.getString("ProductName"));
        p.setDescription(rs.getString("Description"));
        p.setPrice(rs.getBigDecimal("Price"));
        p.setCreatedAt(rs.getTimestamp("CreatedAt").toLocalDateTime());
        p.setUpdatedAt(rs.getTimestamp("UpdatedAt").toLocalDateTime());
        p.setIsActive(rs.getBoolean("IsActive"));
        p.setImageUrl(rs.getString("ImageURL"));
        return p;
    }

    //Get top10 best seller product
    public List<Product> getBestSeller() {
        List<Product> list = new ArrayList<>();
        try {
            String query = "SELECT TOP 10 \n"
                    + "p.ProductID, p.CategoryID, p.ProductName, p.Price, MIN(pv.ImageURL) AS ImageURL, SUM(od.Quantity) AS QuantityOfSold\n"
                    + "FROM Product p\n"
                    + "JOIN ProductVariant pv ON p.ProductID = pv.ProductID\n"
                    + "JOIN OrderDetail od ON pv.ProductVariantID = od.ProductVariantID\n"
                    + "JOIN [Order] o ON od.OrderID = o.OrderID\n"
                    + "WHERE o.Status = 'completed' AND p.IsActive = 1\n"
                    + "GROUP BY p.ProductID, p.CategoryID, p.ProductName, p.Price\n"
                    + "ORDER BY SUM(od.Quantity) DESC";

            ResultSet rs = this.executeQuery(query);
            while (rs.next()) {
                list.add(new Product(rs.getInt("ProductID"), rs.getInt("CategoryID"), rs.getString("ProductName"), rs.getBigDecimal("Price"), rs.getInt("QuantityOfSold"), rs.getString("ImageURL")));
            }
        } catch (SQLException ex) {
            LOGGER.log(Level.SEVERE, "Error in getProductsByNameKeyword()", ex);
        }
        return list;
    }

    // Lấy danh sách sản phẩm theo filter + phân trang
    public List<Product> getFilteredProducts(String category, String keyword, Integer rate, Double minPrice, Double maxPrice, int offset, int limit) {
        List<Product> list = new ArrayList<>();
        try {
            StringBuilder query = new StringBuilder(
                    "SELECT DISTINCT p.*, i.ImageURL, "
                    + "ISNULL((SELECT AVG(f2.Rating) FROM Feedback f2 WHERE f2.ProductID = p.ProductID), 0) AS AvgRating "
                    + "FROM Product p "
                    + "LEFT JOIN ( "
                    + "    SELECT ProductID, MIN(ImageURL) AS ImageURL "
                    + "    FROM Image "
                    + "    GROUP BY ProductID "
                    + ") i ON p.ProductID = i.ProductID "
                    + "LEFT JOIN Feedback f ON p.ProductID = f.ProductID "
                    + "WHERE p.IsActive = 1"
            );

            List<Object> params = new ArrayList<>();

            // Category filter
            if (category != null && !category.isEmpty()) {
                query.append(" AND p.CategoryID = ?");
                params.add(Integer.parseInt(category));
            }

            // Keyword filter
            if (keyword != null && !keyword.trim().isEmpty()) {
                query.append(" AND LOWER(p.ProductName) LIKE ?");
                params.add("%" + keyword.toLowerCase() + "%");
            }

            // Price filter
            if (minPrice != null) {
                query.append(" AND p.Price >= ?");
                params.add(minPrice);
            }
            if (maxPrice != null) {
                query.append(" AND p.Price <= ?");
                params.add(maxPrice);
            }

            // Rating filter
            if (rate != null) {
                query.append(" AND (SELECT AVG(f2.Rating) FROM Feedback f2 WHERE f2.ProductID = p.ProductID) >= ?");
                params.add(rate);
            }

            query.append(" ORDER BY p.CreatedAt DESC OFFSET ? ROWS FETCH NEXT ? ROWS ONLY");
            params.add(offset);
            params.add(limit);

            ResultSet rs = this.executeQuery(query.toString(), params.toArray());
            while (rs.next()) {
                Product p = mapRowToProductWithImage(rs);
                list.add(p);
            }

        } catch (SQLException ex) {
            Logger.getLogger(ProductDAO.class.getName()).log(Level.SEVERE, "Error in getFilteredProducts()", ex);
        }
        return list;
    }

    // Đếm tổng số sản phẩm theo bộ lọc
    public int countFilteredProducts(String category, String keyword, Integer rate, Double minPrice, Double maxPrice) {
        int count = 0;
        try {
            StringBuilder query = new StringBuilder(
                    "SELECT COUNT(DISTINCT p.ProductID) AS Total "
                    + "FROM Product p "
                    + "LEFT JOIN Feedback f ON p.ProductID = f.ProductID "
                    + "WHERE p.IsActive = 1"
            );
            List<Object> params = new ArrayList<>();

            // Category filter
            if (category != null && !category.isEmpty()) {
                query.append(" AND p.CategoryID = ?");
                params.add(Integer.parseInt(category));
            }

            // Keyword filter
            if (keyword != null && !keyword.trim().isEmpty()) {
                query.append(" AND LOWER(p.ProductName) LIKE ?");
                params.add("%" + keyword.toLowerCase() + "%");
            }

            // Price filter
            if (minPrice != null) {
                query.append(" AND p.Price >= ?");
                params.add(minPrice);
            }
            if (maxPrice != null) {
                query.append(" AND p.Price <= ?");
                params.add(maxPrice);
            }

            // Rating filter
            if (rate != null) {
                query.append(" AND (SELECT AVG(f2.Rating) FROM Feedback f2 WHERE f2.ProductID = p.ProductID) >= ?");
                params.add(rate);
            }

            ResultSet rs = this.executeQuery(query.toString(), params.toArray());
            if (rs.next()) {
                count = rs.getInt("Total");
            }

        } catch (SQLException ex) {
            Logger.getLogger(ProductDAO.class.getName()).log(Level.SEVERE, "Error in countFilteredProducts()", ex);
        }
        return count;
    }

}
