<%@ page contentType="text/html" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <title>Customer Detail</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/styles/bootstrap.min.css"/>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css">

    <style>
        body {
            background-color: #f8f9fa;
        }
        .customer-card {
            border: none;
            border-radius: 0.75rem;
            box-shadow: 0 4px 20px rgba(0, 0, 0, 0.08);
        }
        .profile-header {
            display: flex;
            align-items: center;
            gap: 1.5rem;
        }
        .avatar {
            flex-shrink: 0;
            width: 80px;
            height: 80px;
            border-radius: 50%;
            background-color: #e9ecef;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 2.5rem;
            color: #adb5bd;
        }
        .profile-info h3 {
            margin-bottom: 0.25rem;
            font-weight: 600;
        }
        .profile-info .text-muted {
            margin-bottom: 0.5rem;
        }
        .detail-list {
            padding-left: 0;
            list-style: none;
        }
        .detail-list li {
            display: flex;
            align-items: flex-start;
            margin-bottom: 1.25rem;
            font-size: 0.95rem;
        }
        .detail-list .icon {
            width: 30px;
            color: #0d6efd;
            font-size: 1.2rem;
            margin-right: 0.75rem;
            margin-top: 0.1rem;
        }
        .detail-list .label {
            color: #6c757d;
            display: block;
            font-weight: 500;
        }
        .detail-list .value {
            color: #212529;
            font-weight: 600;
        }
    </style>
</head>
<body>
<jsp:include page="/components/header/header.jsp"/>

<div class="container my-5">
    <c:choose>
        <c:when test="${not empty customer}">
            <div class="card customer-card">
                <div class="card-body p-4 p-md-5">

                    <div class="profile-header">
                        <div class="avatar">
                            <i class="bi bi-person-fill"></i>
                        </div>
                        <div class="profile-info">
                            <h3>${customer.customerName}</h3>
                            <p class="text-muted mb-2">${customer.email}</p>
                            <c:choose>
                                <c:when test="${customer.status eq 'Active'}"><span class="badge bg-success">Active</span></c:when>
                                <c:when test="${customer.status eq 'Banned'}"><span class="badge bg-danger">Banned</span></c:when>
                                <c:otherwise><span class="badge bg-secondary">${customer.status}</span></c:otherwise>
                            </c:choose>
                        </div>
                    </div>

                    <hr class="my-4">

                    <h5 class="mb-4">Contact & Account Information</h5>
                    <div class="row">
                        <div class="col-md-6">
                            <ul class="detail-list">
                                <li>
                                    <i class="bi bi-person-vcard icon"></i>
                                    <div>
                                        <span class="label">Customer ID</span>
                                        <span class="value">${customer.customerID}</span>
                                    </div>
                                </li>
                                <li>
                                    <i class="bi bi-telephone-fill icon"></i>
                                    <div>
                                        <span class="label">Phone</span>
                                        <span class="value">${customer.phone}</span>
                                    </div>
                                </li>
                            </ul>
                        </div>
                        <div class="col-md-6">
                            <ul class="detail-list">
                                <li>
                                    <i class="bi bi-gender-ambiguous icon"></i>
                                    <div>
                                        <span class="label">Gender</span>
                                        <span class="value">${customer.gender}</span>
                                    </div>
                                </li>
                                <li>
                                    <i class="bi bi-geo-alt-fill icon"></i>
                                    <div>
                                        <span class="label">Address</span>
                                        <span class="value">${customer.address}</span>
                                    </div>
                                </li>
                            </ul>
                        </div>
                    </div>
                </div>
            </div>
        </c:when>
        <c:otherwise>
            <div class="alert alert-warning text-center">
                <i class="bi bi-exclamation-triangle-fill"></i> Customer not found.
            </div>
        </c:otherwise>
    </c:choose>
</div>

<%@include file="/components/footer/footer.jsp" %>
<script src="${pageContext.request.contextPath}/scripts/bootstrap.bundle.min.js"></script>
</body>
</html>

