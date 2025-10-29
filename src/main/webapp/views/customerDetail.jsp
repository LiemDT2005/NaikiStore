<%@ page contentType="text/html" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <title>Customer Detail</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/styles/bootstrap.min.css"/>
    <style>
        .nav-tabs .nav-link.active { font-weight: 600; }
        .section-title { font-weight: 600; font-size: 18px; margin: 16px 0; }
        .value { font-weight: 500; }
        .label { color: #6c757d; width: 160px; display: inline-block; }
    </style>
</head>
<body>
<jsp:include page="/components/header/header.jsp"/>
<div class="container mt-4 mb-5">
    <a href="${pageContext.request.contextPath}/customers" class="btn btn-link p-0 mb-3">&larr; Back to Customers</a>

    <ul class="nav nav-tabs" role="tablist">
        <li class="nav-item" role="presentation">
            <button class="nav-link active" data-bs-toggle="tab" data-bs-target="#tab-detail" type="button" role="tab">Customer Detail</button>
        </li>
        <li class="nav-item" role="presentation">
            <button class="nav-link" data-bs-toggle="tab" data-bs-target="#tab-orders" type="button" role="tab">Order History</button>
        </li>
    </ul>

    <div class="tab-content border border-top-0 p-3 bg-white">
        <div class="tab-pane fade show active" id="tab-detail" role="tabpanel">
            <c:choose>
                <c:when test="${not empty customer}">
                    <div class="row">
                        <div class="col-md-6">
                            <div class="section-title">Basic Info</div>
                            <p><span class="label">Customer ID:</span> <span class="value">${customer.customerID}</span></p>
                            <p><span class="label">Name:</span> <span class="value">${customer.customerName}</span></p>
                            <p><span class="label">Email:</span> <span class="value">${customer.email}</span></p>
                            <p><span class="label">Phone:</span> <span class="value">${customer.phone}</span></p>
                            <p><span class="label">Gender:</span> <span class="value">${customer.gender}</span></p>
                            <p><span class="label">Status:</span>
                                <c:choose>
                                    <c:when test="${customer.status eq 'Active'}"><span class="badge bg-success">Active</span></c:when>
                                    <c:when test="${customer.status eq 'Banned'}"><span class="badge bg-danger">Banned</span></c:when>
                                    <c:otherwise><span class="badge bg-secondary">${customer.status}</span></c:otherwise>
                                </c:choose>
                            </p>
                        </div>
                        <div class="col-md-6">
                            <div class="section-title">Billing Info</div>
                            <p><span class="label">Address:</span> <span class="value">${customer.address}</span></p>
                        </div>
                    </div>
                </c:when>
                <c:otherwise>
                    <div class="text-muted">Customer not found.</div>
                </c:otherwise>
            </c:choose>
        </div>
        <div class="tab-pane fade" id="tab-orders" role="tabpanel">
            <div class="text-muted">Order history will be displayed here.</div>
        </div>
    </div>
</div>
<%@include file="/components/footer/footer.jsp" %>
<script src="${pageContext.request.contextPath}/scripts/bootstrap.bundle.min.js"></script>
</body>
</html>