/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controllers;

import models.OrderWithDetails;
import dao.OrderDAO;
import dao.OrderDetailDAO;
import models.OrderWithDetails;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import models.Customer;
import models.Order;
import utils.PaginationUtil;

/**
 *
 * @author Dang Thanh Liem - CE190697
 */
@WebServlet(name = "OrderServlet", urlPatterns = {"/order"})
public class OrderServlet extends HttpServlet {

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
            out.println("<title>Servlet OrderServlet</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet OrderServlet at " + request.getContextPath() + "</h1>");
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
        HttpSession session = request.getSession();
        Customer user = (Customer) session.getAttribute("user");

        String customerID = user.getCustomerId();
        try {
            OrderDAO orderDAO = new OrderDAO();
            OrderDetailDAO detailDAO = new OrderDetailDAO();

            // Đếm tổng số đơn hàng
            int totalOrders = orderDAO.countOrdersByCustomerId(customerID);
            int totalPages = PaginationUtil.getTotalPages(totalOrders, PaginationUtil.NUMBER_OF_ITEMS_PER_PAGE);

            // Trang hiện tại
            int currentPage = 1;
            String pageParam = request.getParameter("page");
            if (pageParam != null) {
                try {
                    currentPage = Integer.parseInt(pageParam);
                    if (currentPage < 1) {
                        currentPage = 1;
                    }
                    if (currentPage > totalPages) {
                        currentPage = totalPages;
                    }
                } catch (NumberFormatException ignored) {
                }
            }

            int offset = PaginationUtil.getOffset(currentPage, PaginationUtil.NUMBER_OF_ITEMS_PER_PAGE);

            //Lấy danh sách đơn hàng + dữ liệu hiển thị
            List<Order> orderList = orderDAO.getOrdersByCustomerIdWithPaging(
                    customerID, offset, PaginationUtil.NUMBER_OF_ITEMS_PER_PAGE);
            if (orderList == null || orderList.isEmpty()) {
                request.setAttribute("orders", new ArrayList<Order>());
                request.setAttribute("currentPage", currentPage);
                request.setAttribute("totalPages", totalPages);
                request.getRequestDispatcher("/WEB-INF/jsp/customer/order.jsp").forward(request, response);
                return;
            }

            List<OrderWithDetails> ordersWithDetails = new ArrayList<>();

            for (Order order : orderList) {
                List<String> productNames = detailDAO.getProductNamesByOrderId(order.getOrderID());
                String imageURL = detailDAO.getFirstProductImageByOrderId(order.getOrderID());
                if (imageURL == null) {
                    imageURL = "default.jpg";
                }

                OrderWithDetails dto = new OrderWithDetails();
                dto.setOrder(order);
                dto.setProductNames(productNames);
                dto.setImageURL(imageURL);

                ordersWithDetails.add(dto);
            }

            // Gửi dữ liệu sang JSP
            request.setAttribute("orders", ordersWithDetails);
            request.setAttribute("currentPage", currentPage);
            request.setAttribute("totalPages", totalPages);
            request.getRequestDispatcher("/WEB-INF/jsp/customer/order.jsp").forward(request, response);

        } catch (SQLException e) {
            e.printStackTrace();
            request.setAttribute("error", "Unable to connect to database.");
            request.getRequestDispatcher("/WEB-INF/jsp/customer/order.jsp").forward(request, response);
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Unable to load order list.");
            request.getRequestDispatcher("/WEB-INF/jsp/customer/order.jsp").forward(request, response);
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
