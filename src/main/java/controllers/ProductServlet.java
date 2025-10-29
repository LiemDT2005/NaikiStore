/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controllers;

import dao.CategoryDAO;
import dao.FeedbackDAO;
import dao.ImageDAO;
import dao.ProductDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import models.Category;
import models.Feedback;
import models.Product;
import utils.PaginationUtil;

/**
 *
 * @author Admin
 */
@WebServlet(name = "Product", urlPatterns = {"/product"})
public class ProductServlet extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try ( PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet Product</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet Product at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            String view = request.getParameter("view");
            ProductDAO productDAO = new ProductDAO();
            FeedbackDAO feedbackDAO = new FeedbackDAO();
            ImageDAO imageDAO = new ImageDAO();
            if ("detail".equalsIgnoreCase(view)) {
                int productId = Integer.parseInt(request.getParameter("productId"));
                Product product = productDAO.getProductById(productId);

                if (product == null) {
                    response.sendRedirect(request.getContextPath() + "/listProduct");
                } else {
                    double starAVG = 0;
                    double avg = feedbackDAO.productsFeedbackStarAVG(productId);
                    if (!Double.isNaN(avg)) {
                        starAVG = avg;
                    }

                    HashMap<String, List<String>> attributeProduct = new HashMap<>();
                    List<Feedback> listReview = productDAO.listReview(productId);
                    request.setAttribute("totalReviews", listReview.size());
                    request.setAttribute("listReview", listReview);
                    attributeProduct.put("listSize", productDAO.getAllSizeByProductId(productId));
                    attributeProduct.put("listColor", productDAO.getAllColorByProductId(productId));
                    attributeProduct.put("listImage", imageDAO.getAllImageByProductId(productId));
                    request.setAttribute("attributeProduct", attributeProduct);
                    request.setAttribute("starAVG", starAVG);
                    request.setAttribute("product", product);

                    request.getRequestDispatcher("WEB-INF/jsp/customer/information-of-product.jsp").forward(request, response);
                }
            } else if ("list".equalsIgnoreCase(view)) {
                CategoryDAO categoryDAO = new CategoryDAO();
                List<Product> listProduct;

                // --- Nhận tham số lọc từ request ---
                String keyword = request.getParameter("keyword");
                String categoryParam = request.getParameter("category");
                String minPriceStr = request.getParameter("minPrice");
                String maxPriceStr = request.getParameter("maxPrice");
                String rateParam = request.getParameter("rate");
                String pageParam = request.getParameter("page");

                Integer rate = null;
                if (rateParam != null && !rateParam.isEmpty()) {
                    try {
                        rate = Integer.parseInt(rateParam);
                    } catch (NumberFormatException e) {
                        rate = null;
                    }
                }

                Double minPrice = null;
                Double maxPrice = null;
                try {
                    if (minPriceStr != null && !minPriceStr.isEmpty()) {
                        minPrice = Double.parseDouble(minPriceStr);
                    }
                    if (maxPriceStr != null && !maxPriceStr.isEmpty()) {
                        maxPrice = Double.parseDouble(maxPriceStr);
                    }
                } catch (NumberFormatException e) {
                    minPrice = null;
                    maxPrice = null;
                }

                // --- Phân trang ---
                int currentPage = 1;
                if (pageParam != null && !pageParam.isEmpty()) {
                    try {
                        currentPage = Math.max(1, Integer.parseInt(pageParam));
                    } catch (NumberFormatException e) {
                        currentPage = 1;
                    }
                }

                int offset = PaginationUtil.getOffset(currentPage, PaginationUtil.NUMBER_OF_ITEMS_PER_PAGE);

                // --- Lấy tổng số sản phẩm theo filter ---
                int totalItems = productDAO.countFilteredProducts(categoryParam, keyword, rate, minPrice, maxPrice);
                int totalPages = PaginationUtil.getTotalPages(totalItems);

                // --- Lấy danh sách sản phẩm theo filter + phân trang ---
                listProduct = productDAO.getFilteredProducts(categoryParam, keyword, rate, minPrice, maxPrice, offset, PaginationUtil.NUMBER_OF_ITEMS_PER_PAGE);

                // --- Lấy danh sách category ---
                ArrayList<Category> categoryList = new ArrayList<>();
                try {
                    categoryList = categoryDAO.getAllCategories();
                } catch (SQLException ex) {
                    Logger.getLogger(ProductServlet.class.getName()).log(Level.SEVERE, null, ex);
                }

                //Gửi dữ liệu sang JSP
                request.setAttribute("listProduct", listProduct);
                request.setAttribute("categoryList", categoryList);
                request.setAttribute("currentPage", currentPage);
                request.setAttribute("totalPages", totalPages);

                // Giữ lại filter cho JSP
                request.setAttribute("selectedCategory", categoryParam);
                request.setAttribute("selectedRate", rate);
                request.setAttribute("keyword", keyword);
                request.setAttribute("minPrice", minPriceStr);
                request.setAttribute("maxPrice", maxPriceStr);

                request.getRequestDispatcher("/views/viewProducts.jsp").forward(request, response);
            }

        } catch (ServletException | IOException | NumberFormatException e) {
            e.printStackTrace();
            request.getRequestDispatcher("/views/home.jsp").forward(request, response);
        }

    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
