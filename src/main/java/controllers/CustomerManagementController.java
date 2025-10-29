package controllers;

import dao.CustomerDAO;
import models.Customers;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.List;

/**
 *
 * @author Tran Gia Dat - CE190694
 */

@WebServlet(name = "CustomerManagementController", urlPatterns = {"/customers"})
public class CustomerManagementController extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String keyword = req.getParameter("keyword");
        int page = 1;
        int size = 10;
        try {
            page = Integer.parseInt(req.getParameter("page"));
        } catch (Exception ignored) {
        }
        try {
            size = Integer.parseInt(req.getParameter("size"));
        } catch (Exception ignored) {
        }
        if (page < 1) page = 1;
        if (size < 1) size = 10;

        CustomerDAO dao = new CustomerDAO();
        int total = dao.countAll(keyword);
        int totalPages = (int) Math.ceil(total / (double) size);
        if (totalPages == 0) totalPages = 1;
        if (page > totalPages) page = totalPages;

        List<Customers> list;
        if (keyword != null && !keyword.trim().isEmpty()) {
            list = dao.searchCustomers(keyword, page, size);
        } else {
            list = dao.getAllCustomers(page, size);
        }

        req.setAttribute("customers", list);
        req.setAttribute("keyword", keyword);
        req.setAttribute("page", page);
        req.setAttribute("size", size);
        req.setAttribute("total", total);
        req.setAttribute("totalPages", totalPages);
        req.getRequestDispatcher("/WEB-INF/jsp/customer/customerManagement.jsp").forward(req, resp);
    }
}
