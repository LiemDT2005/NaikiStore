package dao;

import db.DBContext;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import models.Category;

/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
/**
 * Category DAO - Data Access Object of Category
 *
 * @author Truong Doan Minh Phuc - CE190744
 */
public class CategoryDAO {

    private Connection conn;

    public CategoryDAO() {
        conn = new DBContext().getConnection();
    }

    /**
     * Gets all existing categories in the database.
     * 
     * @return The Category's list
     * @throws SQLException if having error while executing
     */
    public ArrayList<Category> getAllCategories() throws SQLException {
        ArrayList<Category> categories = new ArrayList<>();

        String query = "SELECT * FROM Category";

        PreparedStatement statement = conn.prepareStatement(query);
        ResultSet result = statement.executeQuery();

        while (result.next()) {
            categories.add(new Category(
                    result.getInt("CategoryID"),
                    result.getString("CategoryName"),
                    result.getString("Description")
            ));
        }

        return categories;
    }
    
    /**
     * Gets a category by the category ID.
     * 
     * @param categoryID The category ID
     * @return The category
     * @throws SQLException if having error while executing
     */
    public Category getCategoryByID(int categoryID) throws SQLException {
        Category category = new Category();

        String query = "SELECT * FROM Category WHERE CategoryID = ?";

        PreparedStatement statement = conn.prepareStatement(query);
        ResultSet result = statement.executeQuery();
        
        category.setCategoryID(result.getInt("CategoryID"));
        category.setCategoryName(result.getString("CategoryName"));
        category.setCategoryDescription(result.getString("Description"));

        return category;
    }

    /**
     * Adds a new category.
     * 
     * @param categoryID The category ID
     * @param categoryName The category name
     * @param description The category description
     * @return True if the category have been added, else False
     * @throws SQLException Throws the exception of SQL if having error while executing
     */
    public boolean addCategory(int categoryID, String categoryName, String description) throws SQLException {
        String query = "INSERT INTO Category (CategoryID, CategoryName, Description) VALUES (?, ?, ?)";

        PreparedStatement statement = conn.prepareStatement(query);
        statement.setInt(1, categoryID);
        statement.setString(2, categoryName);
        statement.setString(3, description);

        return statement.executeUpdate() > 0;
    }
    
    
    /**
     * Updates all category details.
     * 
     * @param categoryID The category ID
     * @param categoryName The category name
     * @param description The category description
     * @return True if have been changed, else False
     * @throws SQLException if having error while executing
     */
    public boolean updateCategory(int categoryID, String categoryName, String description) throws SQLException {
        String query = "UPDATE Category SET CategoryName = ?, Description = ? WHERE CategoryID = ?";
        
        PreparedStatement statement = conn.prepareStatement(query);
        statement.setString(1, categoryName);
        statement.setString(2, description);
        statement.setInt(3, categoryID); 
        
        return statement.executeUpdate() > 0;
    }

}
