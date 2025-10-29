<%@ page contentType="text/html" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Voucher Details</title>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/assets/css/bootstrap.min.css">
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/assets/css/dashboard.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css">

    <style>
        body {
            background-color: #f4f7fa; /* A softer background color */
        }

        .voucher-card {
            background: #ffffff;
            border-radius: 12px;
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.08);
            padding: 24px;
            margin-top: 20px;
        }

        .voucher-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            border-bottom: 1px solid #e9ecef;
            padding-bottom: 16px;
            margin-bottom: 24px;
        }

        .voucher-title h3 {
            margin: 0;
            font-size: 24px;
            font-weight: 600;
            color: #2c3e50;
        }

        .badge-status {
            padding: 6px 12px;
            border-radius: 16px;
            font-weight: 600;
            font-size: 13px;
            margin-left: 12px;
            vertical-align: middle;
        }

        .badge-active {
            background-color: #e8f8f5;
            color: #1abc9c;
        }

        .badge-inactive {
            background-color: #f4f6f7;
            color: #7f8c8d;
        }

        .action-buttons .btn {
            margin-left: 8px;
            border-radius: 8px;
            font-weight: 500;
        }

        .details-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(300px, 1fr));
            gap: 24px;
        }

        .detail-item {
            margin-bottom: 20px;
        }

        .detail-item .label {
            color: #7f8c8d;
            font-size: 13px;
            text-transform: uppercase;
            letter-spacing: .05em;
            margin-bottom: 6px;
            display: block;
        }

        .detail-item .label i {
            margin-right: 6px;
        }

        .detail-item .value {
            font-size: 16px;
            color: #2c3e50;
            font-weight: 500;
        }

        .voucher-code {
            background-color: #ecf0f1;
            color: #2c3e50;
            padding: 4px 10px;
            border-radius: 6px;
            font-family: monospace;
            font-weight: bold;
            font-size: 1.1em;
        }

        .progress {
            height: 8px;
            margin-top: 8px;
        }
    </style>
</head>
<body class="ttr-opened-sidebar ttr-pinned-sidebar">
<jsp:include page="/components/header/header.jsp"/>

<main class="ttr-wrapper">
    <div class="container-fluid">
        <div class="db-breadcrumb">
            <h4 class="breadcrumb-title">Voucher Management</h4>
        </div>

        <c:if test="${empty voucher}">
            <div class="alert alert-danger">Voucher not found.</div>
        </c:if>

        <c:if test="${not empty voucher}">
            <div class="voucher-card">
                <div class="voucher-header">
                    <div class="voucher-title">
                        <h3>
                                ${voucher.name}
                            <span class="badge-status ${voucher.active ? 'badge-active' : 'badge-inactive'}">
                                    ${voucher.active ? 'Active' : 'Inactive'}
                            </span>
                        </h3>
                    </div>
                    <div class="action-buttons">
                        <a href="${pageContext.request.contextPath}/updatevoucher?id=${voucher.voucherID}" class="btn btn-sm btn-outline-secondary"><i class="fas fa-pencil-alt"></i> Edit</a>
                        <form method="post" action="${pageContext.request.contextPath}/deletevoucher" style="display:inline" onsubmit="return confirm('Are you sure you want to permanently delete this voucher?');">
                            <input type="hidden" name="voucherId" value="${voucher.voucherID}" />
                            <button type="submit" class="btn btn-sm btn-outline-danger"><i class="fas fa-trash"></i> Delete</button>
                        </form>
                        <c:choose>
                            <c:when test="${voucher.active}">
                                <a href="${pageContext.request.contextPath}/updatevoucher?id=${voucher.voucherID}&toggle=deactivate" class="btn btn-sm btn-outline-warning"><i class="fas fa-toggle-off"></i> Deactivate</a>
                            </c:when>
                            <c:otherwise>
                                <a href="${pageContext.request.contextPath}/updatevoucher?id=${voucher.voucherID}&toggle=activate" class="btn btn-sm btn-outline-success"><i class="fas fa-toggle-on"></i> Activate</a>
                            </c:otherwise>
                        </c:choose>
                    </div>
                </div>

                <div class="row">
                    <div class="col-md-7">
                        <div class="detail-item">
                            <span class="label"><i class="fas fa-tags"></i> Voucher Code</span>
                            <span class="value voucher-code">${voucher.code}</span>
                        </div>
                        <div class="detail-item">
                            <span class="label"><i class="fas fa-info-circle"></i> Description</span>
                            <span class="value">${voucher.description}</span>
                        </div>

                        <div class="row">
                            <div class="col-sm-4">
                                <div class="detail-item">
                                    <span class="label"><i class="fas fa-percent"></i> Discount</span>
                                    <span class="value"><fmt:formatNumber value="${voucher.discountPercentage}" pattern="#0.##"/>%</span>
                                </div>
                            </div>
                            <div class="col-sm-4">
                                <div class="detail-item">
                                    <span class="label"><i class="fas fa-arrow-down"></i> Max Discount</span>
                                    <span class="value"><fmt:formatNumber value="${voucher.maxReducing}" pattern="#,##0 'đ'"/></span>
                                </div>
                            </div>
                            <div class="col-sm-4">
                                <div class="detail-item">
                                    <span class="label"><i class="fas fa-shopping-cart"></i> Min Order Value</span>
                                    <span class="value"><fmt:formatNumber value="${voucher.minOrderValue}" pattern="#,##0 'đ'"/></span>
                                </div>
                            </div>
                        </div>
                    </div>

                    <div class="col-md-5">
                        <div class="detail-item">
                            <span class="label"><i class="fas fa-calendar-alt"></i> Expiry Date</span>
                            <span class="value"><fmt:formatDate value="${voucher.expiryDate}" pattern="dd-MM-yyyy"/></span>
                        </div>
                        <div class="detail-item">
                            <span class="label"><i class="fas fa-user-check"></i> Max Usage Per User</span>
                            <span class="value">${voucher.maxUsagePerUser}</span>
                        </div>
                        <div class="detail-item">
                            <c:set var="usedCount" value="${empty voucher.usageCount ? 0 : voucher.usageCount}" />
                            <c:set var="percentageUsed" value="${(usedCount / voucher.quantity) * 100}" />
                            <span class="label"><i class="fas fa-chart-pie"></i> Availability</span>
                            <span class="value">${usedCount} used / ${voucher.quantity} total</span>
                            <div class="progress">
                                <div class="progress-bar" role="progressbar" style="width: ${percentageUsed}%;" aria-valuenow="${percentageUsed}" aria-valuemin="0" aria-valuemax="100"></div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </c:if>
    </div>
</main>
<jsp:include page="/components/footer/footer.jsp"/>
</body>
</html>