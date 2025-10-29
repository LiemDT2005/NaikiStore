package controllers;

import dao.CustomersDAO;
import dao.StaffsDAO;
import jakarta.mail.MessagingException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.time.LocalDateTime;
import java.util.Random;
import models.Customer;
import models.Staff;
import utils.MailUtil;

@WebServlet(name = "ForgotPasswordServlet", urlPatterns = {"/forgotpassword"})
public class ForgotPasswordServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("/WEB-INF/auth/forgotpassword.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");
        HttpSession session = request.getSession();

        CustomersDAO customersDAO = new CustomersDAO();
        StaffsDAO staffsDAO = new StaffsDAO();

        if ("sendOtp".equalsIgnoreCase(action)) {
            String email = request.getParameter("email");

            Customer customer = customersDAO.getUserByEmail(email);
            Staff staff = staffsDAO.getStaffByEmail(email);

            if (customer == null && staff == null) {
                session.setAttribute("errorMessage", "Email does not exist.");
                response.sendRedirect(request.getContextPath() + "/forgotpassword");
                return;
            }

            // Chặn spam: kiểm tra thời điểm gửi lần trước
            LocalDateTime lastSent = (LocalDateTime) session.getAttribute("lastSent");
            if (lastSent != null && lastSent.isAfter(LocalDateTime.now().minusSeconds(60))) {
                session.setAttribute("errorMessage", "Please wait before requesting another OTP.");
                response.sendRedirect(request.getContextPath() + "/forgotpassword");
                return;
            }

            // Sinh OTP ngẫu nhiên
            String token = String.format("%06d", new Random().nextInt(999999));
            LocalDateTime expiry = LocalDateTime.now().plusMinutes(15);

            try {
                // Gửi mail
                MailUtil.sendOtp(email, token);

                // Lưu token vào DB tương ứng
                if (customer != null) {
                    customersDAO.saveResetToken(email, token, expiry);
                    session.setAttribute("role", "customer");
                } else {
                    staffsDAO.saveResetToken(email, token, expiry);
                    session.setAttribute("role", "staff");
                }

                session.setAttribute("email", email);
                session.setAttribute("otp", token);
                session.setAttribute("expiry", expiry);
                session.setAttribute("attempt", 0);
                session.setAttribute("lastSent", LocalDateTime.now());
                session.setAttribute("message", "OTP sent to your email.");

            } catch (MessagingException e) {
                e.printStackTrace();
                session.setAttribute("errorMessage", "Failed to send OTP. Try again.");
            }

            //Redirect để tránh gửi lại form
            response.sendRedirect(request.getContextPath() + "/forgotpassword");
            return;
        }

        else if ("verifyOtp".equalsIgnoreCase(action)) {
            session.removeAttribute("message");
            String enteredOtp = request.getParameter("otp");
            String sessionOtp = (String) session.getAttribute("otp");
            LocalDateTime expiry = (LocalDateTime) session.getAttribute("expiry");
            Integer attempt = (Integer) session.getAttribute("attempt");
            String email = (String) session.getAttribute("email");
            String role = (String) session.getAttribute("role");

            // Kiểm tra session
            if (email == null || role == null || sessionOtp == null || expiry == null) {
                session.setAttribute("errorMessage", "Session expired. Please request a new OTP.");
                response.sendRedirect(request.getContextPath() + "/forgotpassword");
                return;
            }

            // Nếu đã quá hạn
            if (expiry.isBefore(LocalDateTime.now())) {
                session.setAttribute("errorMessage", "OTP expired. Please try again later");
                response.sendRedirect(request.getContextPath() + "/forgotpassword");
                return;
            }

            // Tăng số lần thử
            if (attempt == null) attempt = 0;
            attempt++;

            // Kiểm tra OTP
            if (!enteredOtp.equals(sessionOtp)) {
                session.setAttribute("attempt", attempt);

                if (attempt >= 5) {
                    // Quá 5 lần → xem như hết hạn
                    session.setAttribute("expiry", LocalDateTime.now()); // Hết hạn ngay
                    session.setAttribute("errorMessage", "OTP expired due to too many failed attempts. Please request a new one later.");
                } else {
                    session.setAttribute("errorMessage", "Invalid OTP. Try again. (" + (5 - attempt) + " attempts left)");
                }

                response.sendRedirect(request.getContextPath() + "/forgotpassword");
                return;
            }

            // Nếu đúng OTP
            session.removeAttribute("attempt");
            session.removeAttribute("errorMessage");
            session.setAttribute("message", "OTP verified successfully!");
            session.setAttribute("otpVerified", true);
            response.sendRedirect(request.getContextPath() + "/resetpassword");
        }
    }

    @Override
    public String getServletInfo() {
        return "Forgot Password Servlet with OTP verification and anti-spam.";
    }
}
