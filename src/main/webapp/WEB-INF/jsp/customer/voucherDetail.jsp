<%@ page contentType="text/html" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html>
<head>
    <title>Voucher Details</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/styles/bootstrap.min.css"/>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css">
    <style>
        body {
            background-color: #f8f9fa;
        }
        .voucher-card {
            border: none;
            border-radius: 0.75rem;
            box-shadow: 0 4px 15px rgba(0, 0, 0, 0.08);
            transition: all 0.3s ease-in-out;
        }
        .voucher-card .card-header {
            background-color: #ffffff;
            border-bottom: 1px solid #dee2e6;
            font-weight: 600;
            font-size: 1.25rem;
            padding: 1rem 1.5rem;
            display: flex;
            align-items: center;
        }
        .voucher-card .card-header i {
            margin-right: 0.75rem;
            color: #0d6efd;
        }
        .voucher-code-wrapper {
            background-color: #e9f3ff;
            padding: 1.5rem;
            border-radius: 0.5rem;
            text-align: center;
            margin-bottom: 1.5rem;
        }
        .voucher-code-wrapper .voucher-name {
            font-size: 1.3rem;
            font-weight: 600;
            margin-bottom: 0.75rem;
        }
        .voucher-code-box {
            display: inline-flex;
            align-items: center;
            border: 2px dashed #0d6efd;
            padding: 0.5rem 1rem;
            border-radius: 0.25rem;
            background-color: #ffffff;
            font-family: 'Courier New', Courier, monospace;
            font-size: 1.25rem;
            font-weight: bold;
            color: #0a58ca;
        }
        .voucher-code-box .copy-btn {
            margin-left: 1rem;
            font-size: 1rem;
            cursor: pointer;
        }
        .info-list dt {
            font-weight: 500;
            color: #6c757d;
            display: flex;
            align-items: center;
            margin-bottom: 0.5rem;
        }
        .info-list dd {
            font-weight: 600;
            color: #212529;
            margin-left: 1.75rem;
            margin-bottom: 1.25rem;
        }
        .info-list .info-icon {
            margin-right: 0.75rem;
            width: 20px;
            text-align: center;
            color: #495057;
        }
        .progress-wrapper {
            margin-left: 1.75rem;
        }
    </style>
</head>
<body>
<%@include file="/components/header/header.jsp" %>
<div class="container my-5">

    <c:choose>
        <c:when test="${not empty voucher}">
            <div class="card voucher-card">
                <div class="card-header">
                    <i class="bi bi-ticket-detailed"></i> Voucher Details
                </div>
                <div class="card-body p-4">

                    <div class="voucher-code-wrapper">
                        <div class="voucher-name">${voucher.name}</div>
                        <div class="d-flex justify-content-center">
                            <div class="voucher-code-box">
                                <span id="voucherCode">${voucher.code}</span>
                                <button onclick="copyCode()" class="btn btn-sm btn-link copy-btn" title="Copy code">
                                    <i class="bi bi-clipboard"></i>
                                </button>
                            </div>
                        </div>
                    </div>

                    <div class="row mt-4">
                        <div class="col-lg-6">
                            <dl class="info-list">
                                <dt><i class="bi bi-card-text info-icon"></i>Description</dt>
                                <dd>${voucher.description}</dd>

                                <dt><i class="bi bi-tag-fill info-icon"></i>Discount</dt>
                                <dd>
                                    <span class="text-danger fw-bold fs-5">
                                        <fmt:formatNumber value="${voucher.discountPercentage}" maxFractionDigits="2"/>%
                                    </span>
                                    <c:if test="${voucher.maxReducing != null}">
                                        , max <fmt:formatNumber value="${voucher.maxReducing}" type="currency" currencySymbol="$"/>
                                    </c:if>
                                </dd>

                                <dt><i class="bi bi-cart-check-fill info-icon"></i>Minimum Order Value</dt>
                                <dd>
                                    <c:choose>
                                        <c:when test="${voucher.minOrderValue != null}">
                                            <fmt:formatNumber value="${voucher.minOrderValue}" type="currency" currencySymbol="$"/>
                                        </c:when>
                                        <c:otherwise>Not required</c:otherwise>
                                    </c:choose>
                                </dd>
                            </dl>
                        </div>

                        <div class="col-lg-6">
                            <dl class="info-list">
                                <dt><i class="bi bi-bar-chart-line-fill info-icon"></i>Usage</dt>
                                <dd>
                                    <div class="progress-wrapper">
                                        <span>Used: ${voucher.usageCount} / ${voucher.quantity}</span>
                                        <div class="progress mt-1" style="height: 10px;">
                                            <div class="progress-bar" role="progressbar"
                                                 style="width: ${(voucher.usageCount / voucher.quantity) * 100}%"
                                                 aria-valuenow="${voucher.usageCount}"
                                                 aria-valuemin="0" aria-valuemax="${voucher.quantity}"></div>
                                        </div>
                                    </div>
                                </dd>

                                <dt><i class="bi bi-person-fill-check info-icon"></i>Max Usage/User</dt>
                                <dd>${voucher.maxUsagePerUser} time(s)</dd>

                                <dt><i class="bi bi-calendar-x-fill info-icon"></i>Expiry Date</dt>
                                <dd><fmt:formatDate value="${voucher.expiryDate}" pattern="yyyy-MM-dd"/></dd>

                                <dt><i class="bi bi-power info-icon"></i>Status</dt>
                                <dd>
                                    <c:choose>
                                        <c:when test="${voucher.active}"><span class="badge bg-success">Active</span></c:when>
                                        <c:otherwise><span class="badge bg-secondary">Inactive</span></c:otherwise>
                                    </c:choose>
                                </dd>
                            </dl>
                        </div>
                    </div>
                </div>
            </div>
        </c:when>
        <c:otherwise>
            <div class="alert alert-warning text-center">
                <i class="bi bi-exclamation-triangle-fill"></i> Voucher not found.
            </div>
        </c:otherwise>
    </c:choose>
</div>
<%@include file="/components/footer/footer.jsp" %>
<script src="${pageContext.request.contextPath}/scripts/bootstrap.bundle.min.js"></script>
<script>
    function copyCode() {
        const codeElement = document.getElementById('voucherCode');
        const code = codeElement.innerText;
        navigator.clipboard.writeText(code).then(() => {
            const copyBtn = document.querySelector('.copy-btn');
            const originalIcon = copyBtn.innerHTML;
            copyBtn.innerHTML = '<i class="bi bi-check-lg text-success"></i>';
            copyBtn.setAttribute('title', 'Copied!');
            setTimeout(() => {
                copyBtn.innerHTML = originalIcon;
                copyBtn.setAttribute('title', 'Copy code');
            }, 2000);
        }).catch(err => {
            console.error('Failed to copy: ', err);
        });
    }
</script>
</body>
</html>