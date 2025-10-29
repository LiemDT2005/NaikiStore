<%@ page contentType="text/html" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html>
<head>
    <title>My Vouchers</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/styles/bootstrap.min.css"/>
    <style>
        .page-title { font-weight: 600; font-size: 24px; margin: 20px 0; }
        .voucher-table th, .voucher-table td { vertical-align: middle; }
    </style>
</head>
<body>
<%@include file="/components/header/header.jsp" %>
<div class="container mt-4 mb-5">
    <div class="page-title">My Vouchers</div>
    <div class="card">
        <div class="card-body p-0">
            <div class="table-responsive">
                <table class="table table-striped voucher-table mb-0">
                    <thead class="table-light">
                    <tr>
                        <th>Code</th>
                        <th>Description</th>
                        <th>Discount (%)</th>
                        <th>Max Discount</th>
                        <th>Min Order</th>
                        <th>Expiry Date</th>
                        <th>Remaining</th>
                        <th></th>
                    </tr>
                    </thead>
                    <tbody>
                    <c:forEach var="v" items="${voucherList}">
                        <tr>
                            <td><span class="badge bg-primary">${v.code}</span></td>
                            <td>${v.description}</td>
                            <td>
                                <c:choose>
                                    <c:when test="${v.discountPercentage != null}">
                                        <fmt:formatNumber value="${v.discountPercentage}" maxFractionDigits="2"/>
                                    </c:when>
                                    <c:otherwise>0</c:otherwise>
                                </c:choose>
                            </td>
                            <td>
                                <c:choose>
                                    <c:when test="${v.maxReducing != null}">
                                        <fmt:formatNumber value="${v.maxReducing}" type="currency"/>
                                    </c:when>
                                    <c:otherwise>-</c:otherwise>
                                </c:choose>
                            </td>
                            <td>
                                <c:choose>
                                    <c:when test="${v.minOrderValue != null}">
                                        <fmt:formatNumber value="${v.minOrderValue}" type="currency"/>
                                    </c:when>
                                    <c:otherwise>-</c:otherwise>
                                </c:choose>
                            </td>
                            <td>
                                <fmt:formatDate value="${v.expiryDate}" pattern="yyyy-MM-dd"/>
                            </td>
                            <td>${v.quantity}</td>
                            <td>
                                <a class="btn btn-sm btn-outline-secondary" href="${pageContext.request.contextPath}/voucherdetail?id=${v.voucherID}">Details</a>
                            </td>
                        </tr>
                    </c:forEach>
                    <c:if test="${empty voucherList}">
                        <tr>
                            <td colspan="8" class="text-center text-muted">No vouchers available.</td>
                        </tr>
                    </c:if>
                    </tbody>
                </table>
            </div>
        </div>
    </div>
</div>
<%@include file="/components/footer/footer.jsp" %>
<script src="${pageContext.request.contextPath}/scripts/bootstrap.bundle.min.js"></script>
</body>
</html>