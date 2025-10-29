<%-- 
    Document   : order
    Created on : Oct 11, 2025, 9:26:11 AM
    Author     : Dang Thanh Liem - CE190697
--%>

<%@ page contentType="text/html" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@include file="/components/header/header.jsp" %>

<div class="container mt-5">
    <h2 class="mb-4">My Orders</h2>

    <c:if test="${not empty error}">
        <div class="alert alert-danger">${error}</div>
    </c:if>

    <c:if test="${empty orders}">
        <p class="text-muted">You have no orders yet.</p>
    </c:if>

    <c:if test="${not empty orders}">
        <div class="vstack gap-4">
            <c:forEach var="wrap" items="${orders}">
                <div class="card shadow-sm border border-light-subtle">
                    <div class="card-body">
                        <!-- Header -->
                        <div class="d-flex justify-content-between align-items-center mb-2">
                            <div class="fw-semibold text-secondary">
                                <i class="bi bi-calendar-event me-1"></i>
                                <fmt:formatDate value="${wrap.order.createdAt}" pattern="dd-MM-yyyy HH:mm" />
                            </div>
                            <div>
                                <c:choose>
                                    <c:when test="${wrap.order.status eq 'waiting'}">
                                        <span class="badge bg-warning text-dark">Waiting</span>
                                    </c:when>
                                    <c:when test="${wrap.order.status eq 'shipping'}">
                                        <span class="badge bg-primary">Shipping</span>
                                    </c:when>
                                    <c:when test="${wrap.order.status eq 'completed'}">
                                        <div class="d-flex flex-column align-items-end">
                                            <span class="badge bg-success mb-1">Completed</span>
                                        </div>
                                    </c:when>
                                    <c:when test="${wrap.order.status eq 'cancelled'}">
                                        <span class="badge bg-danger">Cancelled</span>
                                    </c:when>
                                    <c:when test="${wrap.order.status eq 'returned'}">
                                        <span class="badge bg-dark">Returned</span>
                                    </c:when>
                                    <c:otherwise>
                                        <span class="badge bg-secondary">${wrap.order.status}</span>
                                    </c:otherwise>
                                </c:choose>
                            </div>
                        </div>

                        <!-- Body -->
                        <div class="d-flex align-items-center mb-3">
                            <img src="${wrap.imageURL}" 
                                 alt="Product image"
                                 class="rounded border"
                                 style="width: 80px; height: 80px; object-fit: cover; margin-right: 16px;">
                            <div class="flex-grow-1">
                                <div class="mb-1">
                                    <strong>Products:</strong>
                                    <c:forEach var="pname" items="${wrap.productNames}" varStatus="i">
                                        ${pname}<c:if test="${!i.last}">, </c:if>
                                    </c:forEach>
                                </div>
                                <div>
                                    <strong>Payment:</strong>
                                    <c:choose>
                                        <c:when test="${wrap.order.paymentMethod eq 'cash'}">
                                            <span class="badge bg-secondary">Cash</span>
                                        </c:when>
                                        <c:when test="${wrap.order.paymentMethod eq 'bank transfer'}">
                                            <span class="badge bg-info text-dark">Bank Transfer</span>
                                        </c:when>
                                        <c:otherwise>
                                            <span class="badge bg-light text-dark">${wrap.order.paymentMethod}</span>
                                        </c:otherwise>
                                    </c:choose>
                                </div>
                            </div>
                        </div>

                        <!-- Footer -->
                        <div class="d-flex justify-content-between align-items-center">
                            <div class="fs-6 fw-semibold">
                                Total: 
                                <span class="text-danger">
                                    <fmt:formatNumber value="${wrap.order.totalPrice}" type="number" groupingUsed="true"/> ₫
                                </span>
                            </div>
                            <a href="${pageContext.request.contextPath}/orderDetail?orderID=${wrap.order.orderID}&status=${wrap.order.status}" 
                               class="btn btn-outline-primary btn-sm">
                                View Details
                            </a>
                        </div>
                    </div>
                </div>
            </c:forEach>
        </div>
    </c:if>

    <nav aria-label="Page navigation" class="mt-4">
        <ul class="pagination">
            <li class="page-item ${currentPage <= 1 ? 'disabled' : ''}">
                <a class="page-link" href="?page=${currentPage - 1}" aria-label="Previous">
                    <span aria-hidden="true">&laquo;</span>
                </a>
            </li>

            <c:forEach var="i" begin="1" end="${totalPages}">
                <li class="page-item ${i == currentPage ? 'active' : ''}">
                    <a class="page-link" href="?page=${i}">${i}</a>
                </li>
            </c:forEach>

            <li class="page-item ${currentPage >= totalPages ? 'disabled' : ''}">
                <a class="page-link" href="?page=${currentPage + 1}" aria-label="Next">
                    <span aria-hidden="true">&raquo;</span>
                </a>
            </li>
        </ul>
    </nav>

</div>

<%@include file="/components/footer/footer.jsp" %>
