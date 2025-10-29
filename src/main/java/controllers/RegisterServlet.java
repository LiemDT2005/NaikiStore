/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controllers;

import dao.CustomersDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import models.Customer;
import static utils.PasswordUtils.hashPassword;

/**
 *
 * @author Do Ho Gia Huy - CE191293
 */
@WebServlet(name = "RegisterServlet", urlPatterns = {"/register"})
public class RegisterServlet extends HttpServlet {

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
            out.println("<title>Servlet RegisterServlet</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet RegisterServlet at " + request.getContextPath() + "</h1>");
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
        request.getRequestDispatcher("/WEB-INF/auth/register.jsp").forward(request, response);
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
        response.setContentType("text/html;charset=UTF-8");
        request.setCharacterEncoding("UTF-8");
        HttpSession session = request.getSession();
        try {
            String name = request.getParameter("name");
            String email = request.getParameter("email");
            String password = request.getParameter("password");
            String confirmPassword = request.getParameter("confirmpassword");
            String phone = request.getParameter("phone");
            String address = request.getParameter("address");

            CustomersDAO udao = new CustomersDAO();
            // Mã hóa mật khẩu
            String hashedPassword = hashPassword(password);
            if (name == null || !name.matches("^[\\p{L}]+([ -][\\p{L}]+)*$")) {
                session.setAttribute("enteredName", name);
                session.setAttribute("enteredEmail", email);
                session.setAttribute("enteredPhone", phone);
                session.setAttribute("enteredAddress", address);
                session.setAttribute("errorMessage", "Name must contain only letters, spaces, or hyphens (supports Vietnamese characters).");
                response.sendRedirect("register");
                return;
            } else if (email == null || !email.matches("^[a-zA-Z0-9]+([._+-][a-zA-Z0-9]+)*@[a-zA-Z0-9]+([.-][a-zA-Z0-9]+)*\\.[a-zA-Z]{2,}$")) {
                session.setAttribute("enteredName", name);
                session.setAttribute("enteredEmail", email);
                session.setAttribute("enteredPhone", phone);
                session.setAttribute("enteredAddress", address);
                session.setAttribute("errorMessage", "Invalid email format. Example: user@example.com");
                response.sendRedirect("register");
                return;
            } else if (udao.emailExists(email)) {
                session.setAttribute("errorMessage", "Email already exists. Please use another email.");
                response.sendRedirect("register");
                return;
            } else if (password == null || !password.matches("^(?=.*[a-z])(?=.*[A-Z])(?=.*\\d)(?=.*[@#$%^&+=!]).{6,20}$")) {
                session.setAttribute("enteredName", name);
                session.setAttribute("enteredEmail", email);
                session.setAttribute("enteredPhone", phone);
                session.setAttribute("enteredAddress", address);
                session.setAttribute("errorMessage", "Password must be 6-20 characters with at least one uppercase letter, one lowercase letter, one number, and one special character (@#$%^&+=!).");
                response.sendRedirect("register");
                return;
            } else if (password.equals(confirmPassword) == false) {
                session.setAttribute("enteredName", name);
                session.setAttribute("enteredEmail", email);
                session.setAttribute("enteredPhone", phone);
                session.setAttribute("enteredAddress", address);
                session.setAttribute("errorMessage", "Password and Confirm Password do not match.");
                response.sendRedirect("register");
                return;
            } else if (phone == null || !phone.matches("^(03[2-9]|05[689]|07[06-9]|08[1-9]|09[0-46-9])[0-9]{7}$")) {
                session.setAttribute("enteredName", name);
                session.setAttribute("enteredEmail", email);
                session.setAttribute("enteredPhone", phone);
                session.setAttribute("enteredAddress", address);
                session.setAttribute("errorMessage", "Phone number must be 10 digits and start with valid Vietnamese mobile.");
                response.sendRedirect("register");
                return;
            } else if (address == null || !address.matches("^(?=.*\\p{L})(?!.*[,/.-]{2})[\\p{L}0-9]+(?:[ \\p{L}0-9,/-]*[\\p{L}0-9])?$")) {
                session.setAttribute("enteredName", name);
                session.setAttribute("enteredEmail", email);
                session.setAttribute("enteredPhone", phone);
                session.setAttribute("enteredAddress", address);
                session.setAttribute("errorMessage", "Address must contain at least one letter and can include letters, numbers, spaces, comma, dash, and slash. No consecutive special characters allowed.");
                response.sendRedirect("register");
                return;
            } else {
                Customer user = new Customer();
                user.setCustomerName(name);
                user.setEmail(email);
                user.setPassword(hashedPassword);
                user.setPhone(phone);
                user.setAddress(address);
                user.setStatus(Customer.Status.ACTIVE);
                user.setGender(Customer.Gender.MALE);
                user.setAvatar("login/defaultAvatar.png");
                session.removeAttribute("errorMessage");
                udao.registerUser(user);
                session.setAttribute("message", "Register successfully!");
                response.sendRedirect("login");
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
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
