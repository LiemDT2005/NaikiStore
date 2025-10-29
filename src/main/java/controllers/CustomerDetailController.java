package controllers;

import dao.CustomerDAO;
import models.Customers;
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

@WebServlet(name = "CustomerDetailController", urlPatterns = {"/customerdetail"})
public class CustomerDetailController extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String id = req.getParameter("id");
        Customers customer = null;
        if (id != null && !id.trim().isEmpty()) {
            customer = new CustomerDAO().getCustomerById(id);
        }
        req.setAttribute("customer", customer);
        req.getRequestDispatcher("/WEB-INF/jsp/customer/customerDetail.jsp").forward(req, resp);
    }
}
