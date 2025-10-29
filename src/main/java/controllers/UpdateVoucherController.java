package controllers;

import dao.VoucherDAO;
import models.Voucher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.math.BigDecimal;
import java.sql.Date;

@WebServlet(name = "UpdateVoucherController", urlPatterns = {"/updatevoucher"})
public class UpdateVoucherController extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String idStr = req.getParameter("id");
        try {
            int id = Integer.parseInt(idStr);
            VoucherDAO dao = new VoucherDAO();
            Voucher voucher = dao.getVoucherById(id);
            req.setAttribute("voucher", voucher);
        } catch (Exception e) {
            req.setAttribute("error", "Invalid voucher id");
        }
        req.getRequestDispatcher("/WEB-INF/jsp/admin/editVoucher.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        String idStr = req.getParameter("voucherId");
        VoucherDAO dao = new VoucherDAO();

        try {
            int id = Integer.parseInt(idStr);
            Voucher v = new Voucher();
            v.setVoucherID(id);
            v.setName(req.getParameter("name"));
            v.setCode(req.getParameter("code"));
            v.setDescription(req.getParameter("description"));

            String discountStr = req.getParameter("discountPercentage");
            String maxReducingStr = req.getParameter("maxReducing");
            String minOrderStr = req.getParameter("minOrderValue");
            String expiryStr = req.getParameter("expiryDate");
            String quantityStr = req.getParameter("quantity");
            String maxUsagePerUserStr = req.getParameter("maxUsagePerUser");
            String activeStr = req.getParameter("active");

            if (discountStr != null && !discountStr.isEmpty()) {
                v.setDiscountPercentage(new BigDecimal(discountStr));
            }
            if (maxReducingStr != null && !maxReducingStr.isEmpty()) {
                v.setMaxReducing(new BigDecimal(maxReducingStr));
            }
            if (minOrderStr != null && !minOrderStr.isEmpty()) {
                v.setMinOrderValue(new BigDecimal(minOrderStr));
            }
            if (expiryStr != null && !expiryStr.isEmpty()) {
                v.setExpiryDate(Date.valueOf(expiryStr));
            }
            if (quantityStr != null && !quantityStr.isEmpty()) {
                v.setQuantity(Integer.parseInt(quantityStr));
            }
            if (maxUsagePerUserStr != null && !maxUsagePerUserStr.isEmpty()) {
                v.setMaxUsagePerUser(Integer.parseInt(maxUsagePerUserStr));
            }
            boolean isActive = "true".equalsIgnoreCase(activeStr) || "1".equals(activeStr) || "on".equalsIgnoreCase(activeStr);
            v.setActive(isActive);

            boolean ok = dao.updateVoucher(v);
            if (ok) {
                // Redirect to a voucher list after successful update
                resp.sendRedirect(req.getContextPath() + "/managevouchers");
            } else {
                req.setAttribute("voucher", v);
                req.setAttribute("error", "Failed to update voucher. Please check your input.");
                req.getRequestDispatcher("/WEB-INF/jsp/admin/editVoucher.jsp").forward(req, resp);
            }
        } catch (Exception e) {
            req.setAttribute("error", "Invalid input: " + e.getMessage());
            req.getRequestDispatcher("/WEB-INF/jsp/admin/editVoucher.jsp").forward(req, resp);
        }
    }
}
