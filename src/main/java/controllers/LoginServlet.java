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
import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import models.Customer;
import models.Staff;

/**
 *
 * @author Do Ho Gia Huy - CE191293
 */
@WebServlet(name="LoginServlet", urlPatterns={"/login"})
public class LoginServlet extends HttpServlet {
   
    /** 
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code> methods.
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet AccountServlet</title>");  
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet AccountServlet at " + request.getContextPath () + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    } 

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /** 
     * Handles the HTTP <code>GET</code> method.
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        // Kiểm tra nếu cookie tồn tại và tự động điền email/password vào form
        Cookie[] cookies = request.getCookies();
        String email = "";
        String password = "";

        if (cookies != null) {
            for (Cookie cookie : cookies) {
                if ("email".equals(cookie.getName())) {
                    email = cookie.getValue();
                }
                if ("password".equals(cookie.getName())) {
                    password = cookie.getValue();
                }
            }
        }

        // Đặt thuộc tính cho request để hiển thị trên form
        request.setAttribute("email", email);
        request.setAttribute("password", password);

        // Chuyển hướng về trang đăng nhập
         request.getRequestDispatcher("/WEB-INF/auth/login.jsp").forward(request, response);
    } 

    /** 
     * Handles the HTTP <code>POST</code> method.
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
    response.setContentType("text/html; charset=UTF-8");

    try {
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String rememberMe = request.getParameter("rememberMe");

        CustomersDAO customersDAO = new CustomersDAO();
        StaffsDAO staffsDAO = new StaffsDAO();

        Customer user = customersDAO.loginWithEmailAndPassword(email, password);
        Staff staff = staffsDAO.loginWithEmailAndPassword(email, password);

        HttpSession session = request.getSession();

        // Kiểm tra nếu có user hoặc staff hợp lệ
        if (user != null || staff != null) {
            boolean isActive = (user != null && user.getStatus() == Customer.Status.ACTIVE)
                    || (staff != null && staff.getStatus() == Staff.Status.ACTIVE);

            if (isActive) {
                // Xử lý "Remember Me"
                if ("on".equals(rememberMe)) {
                    Cookie emailCookie = new Cookie("email", email);
                    Cookie passwordCookie = new Cookie("password", password);

                    emailCookie.setMaxAge(7 * 24 * 60 * 60);
                    emailCookie.setPath("/");
                    passwordCookie.setMaxAge(7 * 24 * 60 * 60);
                    passwordCookie.setPath("/");
                    response.addCookie(emailCookie);
                    response.addCookie(passwordCookie);
                } else {
                    Cookie emailCookie = new Cookie("email", "");
                    Cookie passwordCookie = new Cookie("password", "");
                    passwordCookie.setMaxAge(0);
                    passwordCookie.setPath("/");
                    emailCookie.setMaxAge(0);
                    emailCookie.setPath("/");
                    response.addCookie(emailCookie);
                    response.addCookie(passwordCookie);
                }

                // Điều hướng dựa vào vai trò người dùng
                if (user != null) {
                    session.setAttribute("user", user);
                    session.setAttribute("message", "Login successful!");
                    response.sendRedirect("home");
                } else if ("STAFF".equals(staff.getRole().toString())) {
                    session.setAttribute("user", staff);
                    session.setAttribute("message", "Login successful!");
                    response.sendRedirect("contact-list");
                } else {
                    session.setAttribute("user", staff);
                    session.setAttribute("message", "Login successful!");
                    response.sendRedirect("dashboard");
                }

            } else {
                session.setAttribute("enteredEmail", email);
                session.setAttribute("errorMessage", "Your account has been locked.");
                response.sendRedirect("login");
            }
        } else {
            session.setAttribute("enteredEmail", email);
            session.setAttribute("errorMessage", "Incorrect email or password.");
            response.sendRedirect("login");
        }
    } catch (Exception e) {
        e.printStackTrace();
        request.getSession().setAttribute("errorMessage", "An error occurred. Please try again.");
        response.sendRedirect("login");
    }
    }

    /** 
     * Returns a short description of the servlet.
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
