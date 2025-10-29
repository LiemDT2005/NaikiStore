package controllers;

import dao.VoucherDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet(name = "DeleteVoucherController", urlPatterns = {"/deletevoucher"})
public class DeleteVoucherController extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String idStr = req.getParameter("voucherId");
        try {
            int id = Integer.parseInt(idStr);
            VoucherDAO dao = new VoucherDAO();
            boolean ok = dao.deleteVoucher(id);
            if (ok) {
                resp.sendRedirect(req.getContextPath() + "/managevouchers");
            } else {
                // fallback: redirect to detail with error param
                resp.sendRedirect(req.getContextPath() + "/manage-voucherdetail?id=" + id + "&error=delete_failed");
            }
        } catch (Exception e) {
            resp.sendRedirect(req.getContextPath() + "/manage-vouchers?error=invalid_id");
        }
    }
}
