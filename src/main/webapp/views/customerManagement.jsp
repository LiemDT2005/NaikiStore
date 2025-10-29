<%@ page contentType="text/html" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!DOCTYPE html>
<html>
<head>
    <title>Customer Management</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/styles/bootstrap.min.css"/>
    <style>
        .page-title { font-weight: 600; font-size: 24px; margin: 20px 0; }
        .avatar-img { width: 40px; height: 40px; object-fit: cover; border-radius: 50%; }
        .search-bar { max-width: 420px; }
    </style>
</head>
<body>
<%@include file="/components/header/header.jsp" %>
<div class="container mt-4 mb-5">
    <div class="d-flex align-items-center justify-content-between mb-3">
        <div class="page-title">Customer Management</div>
        <form class="d-flex search-bar" method="get" action="${pageContext.request.contextPath}/customers">
            <input type="text" class="form-control me-2" name="keyword" placeholder="Search by name or email" value="${fn:escapeXml(param.keyword)}"/>
            <input type="hidden" name="size" value="${size}"/>
            <button class="btn btn-primary" type="submit">Search</button>
        </form>
    </div>

    <div class="card">
        <div class="table-responsive">
            <table class="table table-striped mb-0">
                <thead class="table-light">
                <tr>
                    <th>Avatar</th>
                    <th>Username</th>
                    <th>Name</th>
                    <th>Email</th>
                    <th>Phone</th>
                    <th>Gender</th>
                    <th>Address</th>
                    <th>Status</th>
                    <th>Action</th>
                </tr>
                </thead>
                <tbody>
                <c:forEach var="cst" items="${customers}">
                    <tr>
                        <td>
                            <c:choose>
                                <c:when test="${not empty cst.avatar}">
                                    <img class="avatar-img" src="${cst.avatar}" alt="avatar"/>
                                </c:when>
                                <c:otherwise>
                                    <div class="avatar-img bg-secondary d-inline-flex align-items-center justify-content-center text-white">${cst.customerName != null && cst.customerName.length() > 0 ? cst.customerName.substring(0,1) : 'U'}</div>
                                </c:otherwise>
                            </c:choose>
                        </td>
                        <td><a href="${pageContext.request.contextPath}/customer-detail?id=${cst.customerID}">${cst.customerID}</a></td>
                        <td>${cst.customerName}</td>
                        <td>${cst.email}</td>
                        <td>${cst.phone}</td>
                        <td>${cst.gender}</td>
                        <td>${cst.address}</td>
                        <td>
                            <c:choose>
                                <c:when test="${cst.status eq 'Active'}"><span class="badge bg-success">Active</span></c:when>
                                <c:when test="${cst.status eq 'Banned'}"><span class="badge bg-danger">Banned</span></c:when>
                                <c:otherwise><span class="badge bg-secondary">${cst.status}</span></c:otherwise>
                            </c:choose>
                        </td>
                        <td>
                            <form method="post" action="${pageContext.request.contextPath}/update-customer-status" class="d-inline">
                                <input type="hidden" name="customerId" value="${cst.customerID}"/>
                                <c:choose>
                                    <c:when test="${cst.status eq 'Active'}">
                                        <input type="hidden" name="newStatus" value="Banned"/>
                                        <button type="submit" class="btn btn-sm btn-danger">Ban</button>
                                    </c:when>
                                    <c:otherwise>
                                        <input type="hidden" name="newStatus" value="Active"/>
                                        <button type="submit" class="btn btn-sm btn-success">Unban</button>
                                    </c:otherwise>
                                </c:choose>
                            </form>
                        </td>
                    </tr>
                </c:forEach>
                <c:if test="${empty customers}">
                    <tr><td colspan="9" class="text-center text-muted">No customers found.</td></tr>
                </c:if>
                </tbody>
            </table>
        </div>
    </div>

    <c:if test="${totalPages > 1}">
        <nav class="mt-3" aria-label="Page navigation">
            <ul class="pagination">
                <li class="page-item ${page <= 1 ? 'disabled' : ''}">
                    <a class="page-link" href="${pageContext.request.contextPath}/customers?keyword=${param.keyword}&size=${size}&page=${page-1}">Previous</a>
                </li>
                <c:forEach var="p" begin="1" end="${totalPages}">
                    <li class="page-item ${p == page ? 'active' : ''}">
                        <a class="page-link" href="${pageContext.request.contextPath}/customers?keyword=${param.keyword}&size=${size}&page=${p}">${p}</a>
                    </li>
                </c:forEach>
                <li class="page-item ${page >= totalPages ? 'disabled' : ''}">
                    <a class="page-link" href="${pageContext.request.contextPath}/customers?keyword=${param.keyword}&size=${size}&page=${page+1}">Next</a>
                </li>
            </ul>
        </nav>
    </c:if>
</div>
<%@include file="/components/footer/footer.jsp" %>
<script src="${pageContext.request.contextPath}/scripts/bootstrap.bundle.min.js"></script>
<script>
    document.addEventListener('DOMContentLoaded', function() {
        document.querySelectorAll('form[action$="/update-customer-status"]').forEach(function(form) {
            form.addEventListener('submit', function(e) {
                var newStatus = form.querySelector('input[name="newStatus"]').value;
                var customerName = form.closest('tr').querySelector('td:nth-child(3)').textContent.trim();
                var msg = newStatus === 'Banned'
                    ? 'Do you want to ban this customer' + (customerName ? ' (' + customerName + ')' : '') + '?'
                    : 'Do you want to unban this customer' + (customerName ? ' (' + customerName + ')' : '') + '?';
                if (!confirm(msg)) {
                    e.preventDefault();
                }
            });
        });
    });
</script>
</body>
</html>