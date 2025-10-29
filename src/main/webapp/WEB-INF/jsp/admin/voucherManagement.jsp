<%@ page contentType="text/html" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Voucher Management</title>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/assets/css/bootstrap.min.css">
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/assets/css/dashboard.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css">

    <style>
        body {
            background-color: #f9fafb;
        }
        .widget-box {
            background: #ffffff;
            border-radius: 12px;
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.05);
            padding: 20px;
        }

        /* Toolbar Styles */
        .toolbar {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 20px;
        }
        .toolbar-filters {
            display: flex;
            gap: 12px;
            align-items: center;
        }
        .toolbar-filters input[type="text"],
        .toolbar-filters select {
            border: 1px solid #dfe3e8;
            border-radius: 8px;
            padding: 8px 12px;
            height: 40px;
            background-color: #fff;
        }
        .toolbar-filters input[type="text"] {
            min-width: 280px;
        }
        .btn {
            border-radius: 8px;
            font-weight: 500;
            padding: 8px 16px;
            border: none;
            cursor: pointer;
            display: inline-flex;
            align-items: center;
            gap: 6px;
        }
        .btn-primary {
            background-color: #435EBE; /* A nice blue */
            color: #fff;
        }
        .btn-primary:hover {
            background-color: #364b9a;
            color: #fff;
        }

        /* Table Styles */
        .custom-table {
            width: 100%;
            border-collapse: collapse;
        }
        .custom-table th, .custom-table td {
            padding: 16px 12px;
            border-bottom: 1px solid #e9ecef;
            text-align: left;
            vertical-align: middle;
        }
        .custom-table thead th {
            background-color: #f8f9fa;
            color: #6c757d;
            font-size: 13px;
            font-weight: 600;
            text-transform: uppercase;
            letter-spacing: .05em;
        }
        .custom-table tbody tr:hover {
            background-color: #f8f9fa;
        }

        /* Table Cell Content Styles */
        .voucher-code-tag {
            background-color: #e9ecef;
            color: #495057;
            padding: 4px 8px;
            border-radius: 6px;
            font-family: monospace;
            font-weight: 600;
        }
        .discount-info span {
            display: block;
        }
        .discount-info .max-amount {
            font-size: 0.85em;
            color: #6c757d;
        }
        .status-badge {
            padding: 4px 10px;
            border-radius: 12px;
            font-weight: 600;
            font-size: 12px;
        }
        .status-active {
            background-color: #e8f8f5;
            color: #1abc9c;
        }
        .status-inactive {
            background-color: #f4f6f7;
            color: #7f8c8d;
        }
        .action-buttons a {
            color: #6c757d;
            margin: 0 6px;
            font-size: 16px;
            text-decoration: none;
        }
        .action-buttons a:hover {
            color: #435EBE;
        }

        /* Empty State */
        .empty-state {
            text-align: center;
            padding: 60px 20px;
        }
        .empty-state i {
            font-size: 48px;
            color: #ced4da;
        }
        .empty-state p {
            margin-top: 16px;
            font-size: 18px;
            color: #6c757d;
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

        <div class="widget-box">
            <div class="toolbar">
                <div class="toolbar-filters">
                    <form method="get" action="${pageContext.request.contextPath}/managevouchers" class="toolbar-filters">
                        <input type="text" name="keyword" placeholder="Search by name or code..." value="${fn:escapeXml(param.keyword)}"/>
                        <select name="status">
                            <option value="">All Status</option>
                            <option value="active" ${param.status == 'active' ? 'selected' : ''}>Active</option>
                            <option value="inactive" ${param.status == 'inactive' ? 'selected' : ''}>Inactive</option>
                        </select>
                        <select name="sortBy">
                            <option value="newest" ${empty param.sortBy || param.sortBy == 'newest' ? 'selected' : ''}>Newest First</option>
                            <option value="oldest" ${param.sortBy == 'oldest' ? 'selected' : ''}>Oldest First</option>
                            <option value="expiry_asc" ${param.sortBy == 'expiry_asc' ? 'selected' : ''}>Expiry Date Asc</option>
                            <option value="expiry_desc" ${param.sortBy == 'expiry_desc' ? 'selected' : ''}>Expiry Date Desc</option>
                        </select>
                        <button type="submit" class="btn btn-primary"><i class="fa fa-filter"></i> Filter</button>
                    </form>
                </div>
                <div class="toolbar-actions">
                    <a class="btn btn-primary" href="${pageContext.request.contextPath}/addvoucher"><i class="fa fa-plus"></i> Add New Voucher</a>
                </div>
            </div>

            <div class="table-responsive">
                <table class="custom-table">
                    <thead>
                    <tr>
                        <th>Code</th>
                        <th>Name</th>
                        <th>Discount</th>
                        <th>Expiry Date</th>
                        <th>Availability</th>
                        <th>Status</th>
                        <th>Actions</th>
                    </tr>
                    </thead>
                    <tbody>
                    <c:forEach var="v" items="${voucherList}">
                        <tr>
                            <td><span class="voucher-code-tag">${v.code}</span></td>
                            <td>${v.name}</td>
                            <td>
                                <div class="discount-info">
                                    <span class="percentage"><fmt:formatNumber value="${v.discountPercentage}" pattern="#0.##"/>%</span>
                                    <c:if test="${not empty v.maxReducing}">
                                        <span class="max-amount">Max <fmt:formatNumber value="${v.maxReducing}" pattern="#,##0 'đ'"/></span>
                                    </c:if>
                                </div>
                            </td>
                            <td><fmt:formatDate value="${v.expiryDate}" pattern="dd-MM-yyyy"/></td>
                            <td>${empty v.usageCount ? 0 : v.usageCount} / ${v.quantity}</td>
                            <td>
                                <span class="status-badge ${v.active ? 'status-active' : 'status-inactive'}">${v.active ? 'Active' : 'Inactive'}</span>
                            </td>
                            <td class="action-buttons">
                                <a title="View Details" href="${pageContext.request.contextPath}/managevoucherdetail?id=${v.voucherID}"><i class="fa fa-eye"></i></a>
                                <a title="Edit" href="${pageContext.request.contextPath}/updatevoucher?id=${v.voucherID}"><i class="fa fa-pencil-alt"></i></a>
                                <a title="Delete" href="#"><i class="fa fa-trash-alt"></i></a>
                            </td>
                        </tr>
                    </c:forEach>
                    </tbody>
                </table>
                <c:if test="${empty voucherList}">
                    <div class="empty-state">
                        <i class="fa fa-tags"></i>
                        <p>No vouchers found.</p>
                        <span>Try adjusting your filters or add a new voucher.</span>
                    </div>
                </c:if>
            </div>
        </div>
    </div>
</main>
<jsp:include page="/components/footer/footer.jsp"/>

<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script src="${pageContext.request.contextPath}/assets/js/bootstrap.bundle.min.js"></script>
</body>
</html>