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

@WebServlet(name = "AddVoucherController", urlPatterns = {"/addvoucher"})
public class AddVoucherController extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.getRequestDispatcher("/WEB-INF/jsp/admin/addVoucher.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        String name = req.getParameter("name");
        String code = req.getParameter("code");
        String description = req.getParameter("description");
        String discountStr = req.getParameter("discountPercentage");
        String maxReducingStr = req.getParameter("maxReducing");
        String minOrderStr = req.getParameter("minOrderValue");
        String expiryDateStr = req.getParameter("expiryDate");
        String quantityStr = req.getParameter("quantity");
        String maxUsagePerUserStr = req.getParameter("maxUsagePerUser");
        String activeStr = req.getParameter("isActive");

        String error = null;
        try {
            if (name == null || name.trim().isEmpty()) {
                throw new IllegalArgumentException("Voucher name is required");
            }
            if (code == null || code.trim().isEmpty()) {
                throw new IllegalArgumentException("Voucher code is required");
            }

            Voucher v = new Voucher();
            v.setName(name.trim());
            v.setCode(code.trim());
            v.setDescription(description != null ? description.trim() : null);
            if (discountStr != null && !discountStr.isEmpty()) {
                v.setDiscountPercentage(new BigDecimal(discountStr));
            }
            if (maxReducingStr != null && !maxReducingStr.isEmpty()) {
                v.setMaxReducing(new BigDecimal(maxReducingStr));
            }
            if (minOrderStr != null && !minOrderStr.isEmpty()) {
                v.setMinOrderValue(new BigDecimal(minOrderStr));
            }
            if (expiryDateStr != null && !expiryDateStr.isEmpty()) {
                v.setExpiryDate(Date.valueOf(expiryDateStr));
            }
            if (quantityStr != null && !quantityStr.isEmpty()) {
                v.setQuantity(Integer.parseInt(quantityStr));
            }
            if (maxUsagePerUserStr != null && !maxUsagePerUserStr.isEmpty()) {
                v.setMaxUsagePerUser(Integer.parseInt(maxUsagePerUserStr));
            }
            v.setActive("on".equalsIgnoreCase(activeStr) || "true".equalsIgnoreCase(activeStr) || "1".equalsIgnoreCase(activeStr));

            VoucherDAO dao = new VoucherDAO();
            boolean ok = dao.addVoucher(v);
            if (ok) {
                resp.sendRedirect(req.getContextPath() + "/managevouchers");
                return;
            } else {
                error = "Failed to add voucher. Code may be duplicated or data invalid.";
            }
        } catch (Exception ex) {
            error = ex.getMessage();
        }

        req.setAttribute("error", error);
        req.getRequestDispatcher("/WEB-INF/jsp/admin/addVoucher.jsp").forward(req, resp);
    }
}
