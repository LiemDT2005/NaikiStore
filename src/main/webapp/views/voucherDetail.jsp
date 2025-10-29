<%@ page contentType="text/html" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html>
<head>
    <title>Voucher Detail</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/styles/bootstrap.min.css"/>
    <style>
        .section-title { font-weight: 600; font-size: 20px; margin-bottom: 12px; }
        .label { color: #6c757d; }
    </style>
</head>
<body>
<%@include file="/components/header/header.jsp" %>
<div class="container mt-4 mb-5">
    <a href="${pageContext.request.contextPath}/my-vouchers" class="btn btn-link p-0 mb-3">&larr; Back to List</a>

    <div class="card">
        <div class="card-body">
            <h4 class="mb-3">Voucher Information</h4>
            <c:choose>
                <c:when test="${not empty voucher}">
                    <div class="row g-3">
                        <div class="col-md-6">
                            <div class="section-title">Basic</div>
                            <p><span class="label">Name:</span> ${voucher.name}</p>
                            <p><span class="label">Status:</span>
                                <c:choose>
                                    <c:when test="${voucher.active}"><span class="badge bg-success">Active</span></c:when>
                                    <c:otherwise><span class="badge bg-secondary">Inactive</span></c:otherwise>
                                </c:choose>
                            </p>
                            <p><span class="label">Code:</span> <span class="badge bg-primary">${voucher.code}</span></p>
                            <p><span class="label">Description:</span> ${voucher.description}</p>
                        </div>
                        <div class="col-md-6">
                            <div class="section-title">Rules</div>
                            <p><span class="label">Discount:</span>
                                <fmt:formatNumber value="${voucher.discountPercentage}" maxFractionDigits="2"/> %
                                <c:if test="${voucher.maxReducing != null}">
                                    (max <fmt:formatNumber value="${voucher.maxReducing}" type="currency"/>)
                                </c:if>
                            </p>
                            <p><span class="label">Expiry Date:</span> <fmt:formatDate value="${voucher.expiryDate}" pattern="yyyy-MM-dd"/></p>
                            <p><span class="label">Quantity:</span> ${voucher.quantity}</p>
                            <p><span class="label">Usage Count:</span> ${voucher.usageCount}</p>
                            <p><span class="label">Max Usage per User:</span> ${voucher.maxUsagePerUser}</p>
                            <p><span class="label">Min Order Value:</span> 
                                <c:choose>
                                    <c:when test="${voucher.minOrderValue != null}">
                                        <fmt:formatNumber value="${voucher.minOrderValue}" type="currency"/>
                                    </c:when>
                                    <c:otherwise>-</c:otherwise>
                                </c:choose>
                            </p>
                        </div>
                    </div>
                </c:when>
                <c:otherwise>
                    <div class="text-muted">Voucher not found.</div>
                </c:otherwise>
            </c:choose>
        </div>
    </div>
</div>
<%@include file="/components/footer/footer.jsp" %>
<script src="${pageContext.request.contextPath}/scripts/bootstrap.bundle.min.js"></script>
</body>
</html>