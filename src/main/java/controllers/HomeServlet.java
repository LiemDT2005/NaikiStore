/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controllers;

import dao.CartItemDAO;
import dao.ProductDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.List;
import models.Product;
import jakarta.servlet.http.HttpSession;
import java.sql.SQLException;
import models.CartItem;
import java.util.ArrayList;
import java.util.List;
import models.Customer;

/**
 *
 * @author Dang Thanh Liem - CE190697
 */
@WebServlet(name = "HomeServlet", urlPatterns = {"/home"})
public class HomeServlet extends HttpServlet {

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
            out.println("<title>Servlet HomeServlet</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet HomeServlet at " + request.getContextPath() + "</h1>");
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

        String view = request.getParameter("view");
        if (view == null || view.equals("home")) {

            ProductDAO pDAO = new ProductDAO();
            List<Product> listBestSeller = pDAO.getBestSeller();

            if (!listBestSeller.isEmpty()) {
                request.setAttribute("listBestSeller", listBestSeller);
            }
            System.out.println(listBestSeller.size());

            Customer user = (Customer) session.getAttribute("user");

            if (user != null) {
            String customerID = user.getCustomerId();

            CartItemDAO cartDAO = new CartItemDAO();

            try {
                int cartCount = cartDAO.getCartItemCountByCustomerId(customerID);

                session.setAttribute("cartCount", cartCount);

            } catch (SQLException e) {
                e.printStackTrace();
            }
            }
            request.getRequestDispatcher("/views/home.jsp").forward(request, response);
        } else if (view.equals("aboutnaiki")) {
            request.getRequestDispatcher("/views/aboutUs.jsp").forward(request, response);
        } else if (view.equals("privacy")) {
            request.getRequestDispatcher("/views/privacyPolicy.jsp").forward(request, response);
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
