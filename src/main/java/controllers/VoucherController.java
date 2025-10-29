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

/**
 *
 * @author Tran Gia Dat - CE190694
 */

@WebServlet(name = "VoucherController", urlPatterns = {"/myvouchers"})
public class VoucherController extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        VoucherDAO dao = new VoucherDAO();
        List<Voucher> vouchers = dao.getAllAvailableVouchers();
        req.setAttribute("voucherList", vouchers);
        req.getRequestDispatcher("/WEB-INF/jsp/customer/myVouchers.jsp").forward(req, resp);
    }
}
