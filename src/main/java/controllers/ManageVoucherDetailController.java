package controllers;

import dao.VoucherDAO;
import models.Voucher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

@WebServlet(name = "ManageVoucherDetailController", urlPatterns = {"/managevoucherdetail"})
public class ManageVoucherDetailController extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String idRaw = req.getParameter("id");
        Voucher voucher = null;
        try {
            int id = Integer.parseInt(idRaw);
            VoucherDAO dao = new VoucherDAO();
            voucher = dao.getVoucherById(id);
        } catch (Exception ignored) {}

        req.setAttribute("voucher", voucher);
        req.getRequestDispatcher("/WEB-INF/jsp/admin/voucherDetail.jsp").forward(req, resp);
    }
}
