/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controllers;

import dao.CustomersDAO;
import dao.StaffsDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import models.Customer;
import models.Staff;
import utils.PasswordUtils;

/**
 *
 * @author Do Ho Gia Huy - CE191293
 */
@WebServlet(name = "ResetPasswordServlet", urlPatterns = {"/resetpassword"})
public class ResetPasswordServlet extends HttpServlet {

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
            out.println("<title>Servlet ResetPasswordServlet</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet ResetPasswordServlet at " + request.getContextPath() + "</h1>");
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
        request.getRequestDispatcher("/WEB-INF/auth/resetpassword.jsp").forward(request, response);
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

        HttpSession session = request.getSession();
        Boolean verified = (Boolean) session.getAttribute("otpVerified");
        String email = (String) session.getAttribute("email");
        String role = (String) session.getAttribute("role");

        if (verified == null || !verified || email == null || role == null) {
            response.sendRedirect(request.getContextPath() + "/forgotpassword.jsp");
            return;
        }
        session.removeAttribute("message");
        String newPassword = request.getParameter("newPassword");
        String confirmPassword = request.getParameter("confirmPassword");
        if (newPassword == null || !newPassword.matches("^(?=.*[a-z])(?=.*[A-Z])(?=.*\\d)(?=.*[@#$%^&+=!]).{6,20}$")) {
            session.setAttribute("errorMessage", "Password must be 6-20 characters with at least one uppercase letter, one lowercase letter, one number, and one special character (@#$%^&+=!).");
            response.sendRedirect(request.getContextPath() + "/resetpassword");
            return;
        } else if (!newPassword.equals(confirmPassword)) {
            session.setAttribute("errorMessage", "Password and Confirm Password do not match.");
            response.sendRedirect(request.getContextPath() + "/resetpassword");
            return;
        }
        String hashedPassword = PasswordUtils.hashPassword(newPassword);

        if ("customer".equals(role)) {
            new CustomersDAO().updatePasswordByEmail(email, hashedPassword);
        } else if ("staff".equals(role)) {
            new StaffsDAO().updatePasswordByEmail(email, hashedPassword);
        }

        // Xóa session data sau khi đổi mật khẩu
        session.removeAttribute("otpVerified");
        session.removeAttribute("otp");
        session.removeAttribute("email");
        session.removeAttribute("role");
        session.removeAttribute("errorMessage");
        session.setAttribute("message", "Your password has been reset successfully.");
        response.sendRedirect("login");

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
