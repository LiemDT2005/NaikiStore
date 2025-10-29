<%-- 
    Document   : Header
    Created on : Sep 21, 2025, 11:39:31 PM
    Author     : Apollous - CE190744
--%>
<%@page import="models.Customer"%>
<%@ page contentType="text/html" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<%
    String url = request.getRequestURI();
    boolean isAdmin = url.contains("/adminDashboard");
%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Naiki Store</title>
        <link rel="icon" href="${pageContext.request.contextPath}/assets/img/Favicon.png" type="image/x-icon">

        <!-- Bootstrap + Icons -->
        <link rel="stylesheet" href="${pageContext.request.contextPath}/styles/bootstrap.min.css">
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/styles/header.css?v=<%=System.currentTimeMillis()%>">

        <%-- Optional page-specific CSS --%>
        <% if (url.endsWith("home.jsp")) { %>
        <link rel="stylesheet" href="${pageContext.request.contextPath}/styles/homestyle.css">
        <% } else if (url.endsWith("checkout.jsp")) { %>
        <link rel="stylesheet" href="${pageContext.request.contextPath}/styles/checkout.css">
        <% } else if (url.endsWith("productDetail.jsp")) { %>
        <link rel="stylesheet" href="${pageContext.request.contextPath}/styles/productDetail.css">
        <% } else if (url.endsWith("viewProducts.jsp")) { %>
        <link rel="stylesheet" href="${pageContext.request.contextPath}/styles/list-type-of-product.css">
        <% } else if (url.endsWith("information-of-product.jsp")) { %>
        <link rel="stylesheet" href="${pageContext.request.contextPath}/styles/product-detail.css">
        <% } else if (url.endsWith("how-to-choose-your-size.jsp")) { %>
        <link rel="stylesheet" href="${pageContext.request.contextPath}/styles/hint-size.css">
        <% } %>
    </head>

    <body>
        <header class="header py-3 border-bottom shadow-sm bg-white">
            <div class="container-fluid px-4">
                <div class="d-flex align-items-center justify-content-between">
                    <!-- Toggle + Logo -->
                    <div class="d-flex align-items-center">
                        <c:if test="${fn:contains(pageContext.request.requestURI, 'adminDashboard')}">
                            <button class="btn btn-dark me-2" id="toggleSidebar">
                                <i class="fas fa-bars"></i>
                            </button>
                        </c:if>
                        <a href="${pageContext.request.contextPath}/home" class="d-flex align-items-center">
                            <img src="${pageContext.request.contextPath}/assets/img/HeaderLogo.png" alt="Logo"
                                 style="height: 120px;">
                        </a>
                    </div>

                    <!-- Search Bar -->
                    <c:if test="${not fn:contains(pageContext.request.requestURI, 'adminDashboard')}">
                        <div class="flex-grow-1 px-3">
                            <form action="${pageContext.request.contextPath}/product?view=list" method="get">
                                <div class="d-flex align-items-center search-bar">
                                    <input type="text" name="keyword" class="form-control border-0 bg-transparent"
                                           placeholder="Search...">
                                    <button class="btn text-dark" type="submit">
                                        <i class="fas fa-search"></i>
                                    </button>
                                </div>
                            </form>
                        </div>
                    </c:if>

                    <!-- Icon Section -->
                    <div class="d-flex align-items-center gap-4">
                        <!-- Cart -->

                        <a href="${pageContext.request.contextPath}/cart" class="text-dark text-decoration-none position-relative">
                            <div class="text-center icon-label">
                                <i class="bi bi-cart fs-3 position-relative">
                                    <c:if test="${not empty sessionScope.cartCount && sessionScope.cartCount > 0}">
                                        <span class="cart-badge position-absolute top-0 start-100 translate-middle badge rounded-pill bg-danger">
                                            ${sessionScope.cartCount}
                                        </span>
                                    </c:if>
                                </i>

                                <div>My cart</div>
                            </div>
                        </a>

                        <!-- Voucher -->
                        <a href="${pageContext.request.contextPath}/myvouchers" class="text-dark text-decoration-none">
                            <div class="text-center icon-label">
                                <i class="bi bi-ticket-detailed fs-3"></i>
                                <div>Vouchers</div>
                            </div>
                        </a>

                        <!-- About -->
                        <a href="${pageContext.request.contextPath}/home?view=aboutnaiki"
                           class="text-dark text-decoration-none">
                            <div class="text-center icon-label">
                                <i class="bi bi-at fs-3"></i>
                                <div>About us</div>
                            </div>
                        </a>
                        <!-- User -->
                        <%
                            Customer user = (Customer) session.getAttribute("user");

                            if (user == null) {

                        %>
                        <a href="${pageContext.request.contextPath}/login" class="btn btn-dark px-4 fw-bold">Login</a>
                        <% } else {
                        %>
                        <div class="dropdown">
                            <a class="d-flex align-items-center text-dark text-decoration-none dropdown-toggle"
                               href="#" role="button" id="userDropdown" data-bs-toggle="dropdown" aria-expanded="false">
                                <c:choose>
                                    <c:when test="${fn:startsWith(user.avatar, 'http')}">
                                        <!-- Avatar là link từ Google -->
                                        <img src="${user.avatar}" alt="Avatar" width="60" height="60"
                                             class="rounded-circle me-2" style="object-fit: cover;">
                                    </c:when>
                                    <c:otherwise>
                                        <!-- Avatar nội bộ -->
                                        <img src="${pageContext.request.contextPath}/assets/img/${user.avatar}"
                                             alt="Avatar" width="60" height="60" class="rounded-circle me-2"
                                             style="object-fit: cover;">
                                    </c:otherwise>
                                </c:choose>

                                <span>Hi, <%= user.getCustomerName()%></span>
                            </a>

                            <ul class="dropdown-menu dropdown-menu-end shadow-sm mt-2" aria-labelledby="userDropdown">
                                <li>
                                    <a class="dropdown-item" href="${pageContext.request.contextPath}/profilecustomer">
                                        <i class="bi bi-person-circle me-2"></i> Profile
                                    </a>
                                </li>
                                <li>
                                    <a class="dropdown-item" href="${pageContext.request.contextPath}/order">
                                        <i class="bi bi-bag-check me-2"></i> My Orders
                                    </a>
                                </li>

                                <li>
                                    <a class="dropdown-item" href="${pageContext.request.contextPath}/profilecustomer?view=changepassword">
                                        <i class="bi bi-shield-lock me-2"></i> Security Settings
                                    </a>
                                </li>
                                <li>
                                    <a class="dropdown-item" href="${pageContext.request.contextPath}/logout">
                                        <i class="bi bi-door-open me-2"></i> Log out
                                    </a>
                                </li>
                            </ul>
                        </div>

                        <% }%>

                    </div>
                </div>

                <!-- Category Nav -->
                <div class="nav-bottom text-center py-3" style="margin-left: -20px; margin-right: -20px;">
                    <a href="${pageContext.request.contextPath}/product?view=list">All</a>
                    <a href="${pageContext.request.contextPath}/product?view=list&category=2">Shirt</a>
                    <a href="${pageContext.request.contextPath}/product?view=list&category=3">Trousers</a>
                    <a href="${pageContext.request.contextPath}/product?view=list&category=1">Shoes</a>
                    <a href="${pageContext.request.contextPath}/product?view=list&category=4">Accessory</a>
                    <a href="${pageContext.request.contextPath}/product?view=list&category=5">Backpack</a>
                </div>

        </header>
