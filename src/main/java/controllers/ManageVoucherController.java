package controllers;

import dao.VoucherDAO;
import models.Voucher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.List;

@WebServlet(name = "ManageVoucherController", urlPatterns = {"/managevouchers"})
public class ManageVoucherController extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String keyword = req.getParameter("keyword");
        String status = req.getParameter("status");
        String sortBy = req.getParameter("sortBy");

        VoucherDAO dao = new VoucherDAO();
        List<Voucher> vouchers = dao.getAllVouchersForManager(keyword, status, sortBy);

        req.setAttribute("voucherList", vouchers);
        req.setAttribute("keyword", keyword);
        req.setAttribute("status", status);
        req.setAttribute("sortBy", sortBy);
        req.getRequestDispatcher("/WEB-INF/jsp/admin/voucherManagement.jsp").forward(req, resp);
    }
}
