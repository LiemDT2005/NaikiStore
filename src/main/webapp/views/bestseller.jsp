<%-- 
    Document   : bestseller
    Created on : Oct 18, 2025, 12:55:07 PM
    Author     : Admin
--%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!-- BEST SELLERS -->
<div class="container my-5">
    <h4 class="fw-bold mb-3 text-uppercase">Best Sellers</h4>

    <div id="bestSellerCarousel" class="carousel slide" data-bs-ride="false">
        <div class="carousel-inner">

            <!-- Slide 1 -->
            <div class="carousel-item active">
                <div class="d-flex justify-content-center flex-wrap gap-4">
                    <c:forEach var="product" items="${listBestSeller}" varStatus="loop">
                        <c:if test="${loop.index < 5}">
                            <div class="card product-card text-center shadow-sm position-relative"
                                 style="width: 200px; overflow: hidden; cursor: pointer; transition: all 0.3s ease;">
                                <img src="${product.imageUrl}" 
                                     class="card-img-top product-img"
                                     alt="${product.productName}"
                                     style="height: 180px; object-fit: cover; transition: transform 0.3s ease;">
                                <div class="card-body bg-white">
                                    <h6 class="card-title text-truncate mb-1">${product.productName}</h6>
                                    <p class="fw-bold mb-1">
                                    <fmt:formatNumber value="${product.price}" pattern="#,##0" />đ
                                    </p>
                                    <small class="text-muted">
                                        Sold: ${product.soldQuantity}
                                    </small>
                                </div>

                                <div class="overlay">
                                    <a href="${pageContext.request.contextPath}/productdetail?productId=${product.productId}" 
                                       class="btn btn-light btn-sm fw-semibold shadow">
                                        <i class="bi bi-eye"></i> View
                                    </a>
                                </div>
                            </div>

                        </c:if>
                    </c:forEach>
                </div>
            </div>

            <!-- Slide 2 -->
            <div class="carousel-item">
                <div class="d-flex justify-content-center flex-wrap gap-4">
                    <c:forEach var="product" items="${listBestSeller}" varStatus="loop">
                        <c:if test="${loop.index >= 5 && loop.index < 10}">
                            <div class="card product-card text-center shadow-sm position-relative"
                                 style="width: 200px; overflow: hidden; cursor: pointer; transition: all 0.3s ease;">
                                <img src="${product.imageUrl}" 
                                     class="card-img-top product-img"
                                     alt="${product.productName}"
                                     style="height: 180px; object-fit: cover; transition: transform 0.3s ease;">
                                <div class="card-body bg-white">
                                    <h6 class="card-title text-truncate mb-1">${product.productName}</h6>
                                    <p class="fw-bold mb-1">
                                    <fmt:formatNumber value="${product.price}" pattern="#,##0" />đ
                                    </p>
                                    <small class="text-muted">
                                        Sold: ${product.soldQuantity}
                                    </small>
                                </div>

                                <div class="overlay">
                                    <a href="${pageContext.request.contextPath}/productdetail?productId=${product.productId}" 
                                       class="btn btn-light btn-sm fw-semibold shadow">
                                        <i class="bi bi-eye"></i> View
                                    </a>
                                </div>
                            </div>
                        </c:if>
                    </c:forEach>
                </div>
            </div>

        </div>

        <!-- Nút chuyển -->
        <span class="custom-arrow left" data-bs-target="#bestSellerCarousel" data-bs-slide="prev">
            <i class="bi bi-arrow-left"></i>
        </span>
        <span class="custom-arrow right" data-bs-target="#bestSellerCarousel" data-bs-slide="next">
            <i class="bi bi-arrow-right"></i>
        </span>
    </div>
</div> 
