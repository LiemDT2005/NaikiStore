package controllers;

import dao.VoucherDAO;
import models.Voucher;
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
@WebServlet(name = "VoucherDetailController", urlPatterns = {"/voucherdetail"})
public class VoucherDetailController extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String idParam = req.getParameter("id");
        Voucher voucher = null;
        if (idParam != null) {
            try {
                int id = Integer.parseInt(idParam);
                VoucherDAO dao = new VoucherDAO();
                voucher = dao.getVoucherById(id);
            } catch (NumberFormatException ignored) {}
        }
        req.setAttribute("voucher", voucher);
        req.getRequestDispatcher("/WEB-INF/jsp/customer/voucherDetail.jsp").forward(req, resp);
    }
}
