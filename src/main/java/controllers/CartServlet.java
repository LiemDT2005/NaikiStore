/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controllers;

import dao.CartItemDAO;
import dao.ProductVariantDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.math.BigDecimal;
import java.sql.SQLException;
import java.util.List;
import models.CartItem;
import models.Customer;

/**
 * CartServlet - Quản lý hiển thị & thao tác giỏ hàng Dang Thanh Liem - CE190697
 */
@WebServlet(name = "CartServlet", urlPatterns = {"/cart"})
public class CartServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        Customer user = (Customer) session.getAttribute("user");

        if (user == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        String customerID = user.getCustomerId();
        CartItemDAO cartDAO = new CartItemDAO();

        try {
            List<CartItem> listCartItems = cartDAO.getAllCartByCustomerId(customerID);
            request.setAttribute("listCartItems", listCartItems);

            if (!listCartItems.isEmpty()) {
                BigDecimal total = cartDAO.getTotalByCustomerId(customerID);
                request.setAttribute("total", total);
            } else {
                session.setAttribute("flashMessage", "Cart is empty!");
            }

            int cartCount = cartDAO.getCartItemCountByCustomerId(customerID);
            session.setAttribute("cartCount", cartCount);

            request.getRequestDispatcher("/WEB-INF/jsp/customer/cart.jsp").forward(request, response);
        } catch (SQLException e) {
            throw new ServletException("Error loading cart data", e);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        Customer user = (Customer) session.getAttribute("user");

        if (user == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        String customerID = user.getCustomerId();
        String productStr = request.getParameter("productID");
        String action = request.getParameter("action");
        CartItemDAO cartDAO = new CartItemDAO();
        ProductVariantDAO productVRDAO = new ProductVariantDAO();

        String message = null;
        int rowsAffected = 0;

        try {
            switch (action) {
                case "increase": {
                    int cartId = Integer.parseInt(request.getParameter("cartId"));
                    int currentQty = Integer.parseInt(request.getParameter("quantity"));
                    rowsAffected = cartDAO.updateQuantity(cartId, currentQty + 1);
                    break;
                }
                case "decrease": {
                    int cartId = Integer.parseInt(request.getParameter("cartId"));
                    int currentQty = Integer.parseInt(request.getParameter("quantity"));

                    if (currentQty > 1) {
                        rowsAffected = cartDAO.updateQuantity(cartId, currentQty - 1);
                    } else {
                        rowsAffected = cartDAO.deleteCartById(cartId);
                    }
                    break;
                }
                case "updateQuantity": {
                    int cartId = Integer.parseInt(request.getParameter("cartId"));
                    int currentQty = Integer.parseInt(request.getParameter("quantity"));
                    if (currentQty > 1) {
                        rowsAffected = cartDAO.updateQuantity(cartId, currentQty - 1);
                    } else {
                        rowsAffected = cartDAO.deleteCartById(cartId);
                    }
                    break;
                }
                case "delete": {
                    int cartId = Integer.parseInt(request.getParameter("cartId"));
                    rowsAffected = cartDAO.deleteCartById(cartId);
                    break;
                }
                case "add": {
                    //Thêm sản phẩm vào giỏ
                    String size = request.getParameter("size");
                    String color = request.getParameter("color");
                    String qtyStr = request.getParameter("quantity");

                    if (qtyStr == null || qtyStr.isEmpty() || productStr == null || productStr.isEmpty()) {
                        message = "Missing product information!";
                        break;
                    }

                    int quantity = Integer.parseInt(qtyStr);
                    int productID = Integer.parseInt(productStr);
                    int productVariantID = productVRDAO.getPVId(productID, size, color);
//                  int productVariantID = 0;
                    if (productVariantID <= 0) {
                        session.setAttribute("status", "error");
                        session.setAttribute("message", "Invalid product variant!");
                        response.sendRedirect(request.getContextPath() + "/product?view=detail&productId=" + productID);
                        return;
                    }

                    rowsAffected = cartDAO.addToCart(customerID, productVariantID, quantity);

                    if (rowsAffected > 0) {
                        int cartCount = cartDAO.getCartItemCountByCustomerId(customerID);
                        session.setAttribute("status", "successful");
                        session.setAttribute("message", "Product added to cart successfully!");
                        session.setAttribute("cartCount", cartCount);
                    } else {
                        session.setAttribute("message", "Failed to add product to cart.");
                    }
                    response.sendRedirect(request.getContextPath() + "/product?view=detail&productId=" + productID);
                    return;
                }
                default:
                    message = "Invalid action!";
                    break;
            }

            if (rowsAffected == 0 && message == null) {
                message = " Unable to update cart. Please try again.";
            }

            int cartCount = cartDAO.getCartItemCountByCustomerId(customerID);
            session.setAttribute("cartCount", cartCount);

            session.setAttribute("flashMessage", message);

            response.sendRedirect(request.getContextPath() + "/cart");

        } catch (SQLException e) {
            throw new ServletException("Database error while updating cart", e);
        } catch (NumberFormatException e) {
            throw new ServletException("Invalid quantity format", e);
        }
    }

    @Override
    public String getServletInfo() {
        return "CartServlet - manage user's shopping cart";
    }
}
