/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controllers;

import dao.CustomersDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import jakarta.servlet.http.Part;
import models.Customer;
import utils.PasswordUtils;
import static utils.PasswordUtils.hashPassword;

/**
 *
 * @author Do Ho Gia Huy - CE191293
 */
@WebServlet(name = "ProfileCustomerServlet", urlPatterns = {"/profilecustomer"})
@MultipartConfig
public class ProfileCustomerServlet extends HttpServlet {

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
            out.println("<title>Servlet InformationServlet</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet InformationServlet at " + request.getContextPath() + "</h1>");
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
        // Lấy thông tin user từ session
        HttpSession session = request.getSession();
        Customer loggedUser = (Customer) session.getAttribute("user");

        // Truyền thông tin user sang JSP
        if (loggedUser != null) {  // Ẩn password trước khi gửi đi
            request.setAttribute("user", loggedUser);
        }
        String view = request.getParameter("view");
        if (view == null || view.equalsIgnoreCase("profile")) {
            request.getRequestDispatcher("/WEB-INF/jsp/customer/customerprofile.jsp").forward(request, response);
        } else if (view.equalsIgnoreCase("changepassword")) {
            request.getRequestDispatcher("/WEB-INF/jsp/customer/customerchangepassword.jsp").forward(request, response);
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
        HttpSession session = request.getSession();
        Customer loggedUser = (Customer) session.getAttribute("user");
        String action = request.getParameter("action");
        if (action == null || action.equalsIgnoreCase("profile")) {
            try {
                // Lấy dữ liệu từ form
                String fullName = request.getParameter("fullName");
                String phone = request.getParameter("phone");
                String address = request.getParameter("address");
                String gender = request.getParameter("gender");

                // Validate dữ liệu
                if (fullName == null || !fullName.matches("^[\\p{L}]+([ -][\\p{L}]+)*$")) {
                    session.setAttribute("errorMessage", "Name must contain only letters, spaces, or hyphens (supports Vietnamese characters).");
                    response.sendRedirect("profilecustomer");
                    return;
                } else if (phone == null || !phone.matches("^(03[2-9]|05[689]|07[06-9]|08[1-9]|09[0-46-9])[0-9]{7}$")) {
                    session.setAttribute("errorMessage", "Phone number must be 10 digits and start with valid Vietnamese mobile.");
                    response.sendRedirect("profilecustomer");
                    return;
                } else if (address == null || !address.matches("^(?=.*\\p{L})(?!.*[,/.-]{2})[\\p{L}0-9]+(?:[ \\p{L}0-9,/-]*[\\p{L}0-9])?$")) {
                    session.setAttribute("errorMessage", "Address must contain at least one letter and can include letters, numbers, spaces, comma, dash, and slash. No consecutive special characters allowed.");
                    response.sendRedirect("profilecustomer");
                    return;
                }
                // Xử lý avatar (nếu có upload mới)
                Part avatarPart = request.getPart("avatar");
                String avatarFileName = loggedUser.getAvatar(); // Giữ avatar cũ nếu không upload mới

                if (avatarPart != null && avatarPart.getSize() > 0) {
                    // Validate file type
                    String submittedFileName = avatarPart.getSubmittedFileName();
                    String fileExtension = submittedFileName.substring(submittedFileName.lastIndexOf(".")).toLowerCase();

                    if (!fileExtension.matches("\\.(jpg|jpeg|png|gif)")) {
                        session.setAttribute("errorMessage", "Only image files (JPG, PNG, GIF) are allowed!");
                        response.sendRedirect("profilecustomer");
                        return;
                    }

                    // Validate file size (max 5MB)
                    if (avatarPart.getSize() > 5 * 1024 * 1024) {
                        session.setAttribute("errorMessage", "File size must be less than 5MB!");
                        response.sendRedirect("profilecustomer");
                        return;
                    }

                    String realPath = getServletContext().getRealPath("/assets/img");
                    String fileName = submittedFileName.substring(submittedFileName.lastIndexOf("/") + 1);
                    fileName = fileName.substring(fileName.lastIndexOf("\\") + 1);

                    // Tạo tên file unique để tránh conflict
                    fileName = System.currentTimeMillis() + "_" + fileName;

                    avatarPart.write(realPath + "/" + fileName);
                    avatarFileName = fileName;
                }

                // Cập nhật lại thông tin người dùng
                loggedUser.setCustomerName(fullName);
                loggedUser.setPhone(phone);
                loggedUser.setAddress(address);
                loggedUser.setGender(Customer.Gender.valueOf(gender));
                loggedUser.setAvatar(avatarFileName);

                CustomersDAO dao = new CustomersDAO();
                dao.updateCustomer(loggedUser);

                // Cập nhật lại session với thông tin mới
                session.setAttribute("user", loggedUser);

                // ✅ SET MESSAGE THÀNH CÔNG
                session.setAttribute("message", "Profile updated successfully!");
                response.sendRedirect("profilecustomer");

            } catch (Exception e) {
                e.printStackTrace();
                // ❌ SET ERROR MESSAGE
                session.setAttribute("errorMessage", "Failed to update profile. Please try again!");
                response.sendRedirect("profilecustomer");
            }
        } else if (action.equalsIgnoreCase("changepassword")) {
            try {
                String current = request.getParameter("currentPassword");
                String newPass = request.getParameter("newPassword");
                String confirm = request.getParameter("confirmPassword");

                CustomersDAO dao = new CustomersDAO();

                System.out.println("currentpass: " + current);
                System.out.println("new: " + newPass);
                System.out.println("confirm: " + confirm);
                System.out.println("getpass " + loggedUser.getPassword());

                if (!PasswordUtils.checkPassword(current, loggedUser.getPassword())) {
                    session.setAttribute("errorMessage", "Current password is incorrect.");
                    response.sendRedirect("profilecustomer?view=changepassword");
                    return;
                } else if (newPass == null || !newPass.matches("^(?=.*[a-z])(?=.*[A-Z])(?=.*\\d)(?=.*[@#$%^&+=!]).{6,20}$")) {
                    session.setAttribute("errorMessage", "Password must be 6-20 characters with at least one uppercase letter, one lowercase letter, one number, and one special character (@#$%^&+=!).");
                    response.sendRedirect("profilecustomer?view=changepassword");
                    return;
                } else if (newPass.equals(confirm) == false) {
                    session.setAttribute("errorMessage", "New password and confirm password do not match.");
                    response.sendRedirect("profilecustomer?view=changepassword");
                    return;
                } else {

                    dao.updatePasswordByEmail(loggedUser.getEmail(), hashPassword(newPass));

                    session.setAttribute("message", "Password changed successfully!");
                    response.sendRedirect("profilecustomer?view=changepassword");
                }
            } catch (Exception e) {
                e.printStackTrace();
                session.setAttribute("errorMessage", "Failed to change password. Please try again!");
                response.sendRedirect("profilecustomer?view=changepassword");
            }
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
