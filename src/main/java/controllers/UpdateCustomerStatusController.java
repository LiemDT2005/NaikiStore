package controllers;

import dao.CustomerDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
/**
 *
 * @author Tran Gia Dat - CE190694
 */
@WebServlet(name = "UpdateCustomerStatusController", urlPatterns = {"/update-customer-status"})
public class UpdateCustomerStatusController extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String customerId = req.getParameter("customerId");
        String newStatus = req.getParameter("newStatus");
        if (customerId != null && newStatus != null) {
            new CustomerDAO().updateStatus(customerId, newStatus);
        }
        String referer = req.getHeader("Referer");
        if (referer != null && referer.contains("/customers")) {
            resp.sendRedirect(referer);
        } else {
            resp.sendRedirect(req.getContextPath() + "/customers");
        }
    }
}
