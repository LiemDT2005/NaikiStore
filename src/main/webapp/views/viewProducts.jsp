<%-- 
    Document   : viewProducts
    Created on : Oct 9, 2025
    Author     : Dang Thanh Liem - CE190697
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<fmt:setLocale value="vi_VN" />
<%@include file="/components/header/header.jsp"%>
<div class="container-fluid mt-4">
    <div class="row position-relative">
        <!-- Sidebar Filter (Left Column) -->
        <aside class="col-lg-3 col-md-4 mb-4">
            <form action="${pageContext.request.contextPath}/product" method="get" class="sidebar p-3 shadow-sm bg-white rounded">
                <input type="hidden" name="view" value="list">
                <!-- CATEGORY -->
                <div class="filter-section mb-4">
                    <h6 class="fw-bold mb-3">Category</h6>
                    <%--Tat ca san pham --%>
                    <div class="form-check">
                        <input class="form-check-input" type="radio" name="category" value=""
                               id="cat-all"
                               <c:if test="${empty param.category}">checked</c:if>>
                               <label class="form-check-label" for="cat-all">
                                   All
                               </label>
                        </div>

                    <c:forEach var="cat" items="${categoryList}">
                        <div class="form-check">
                            <input class="form-check-input" type="radio" name="category" value="${cat.categoryID}"
                                   id="cat-${cat.categoryID}"
                                   <c:if test="${param.category != null && fn:contains(param.category, cat.categoryID)}">checked</c:if>>
                            <label class="form-check-label" for="cat-${cat.categoryID}">
                                ${cat.categoryName}
                            </label>
                        </div>
                    </c:forEach>
                </div>

                <!-- PRICE RANGE -->
                <div class="filter-section mb-4">
                    <h6 class="fw-bold mb-3">Price Range</h6>
                    <div class="input-group mb-2">
                        <input type="number" class="form-control" name="minPrice" placeholder="From" value="${param.minPrice}">
                        <span class="input-group-text">-</span>
                        <input type="number" class="form-control" name="maxPrice" placeholder="To" value="${param.maxPrice}">
                    </div>
                </div>

                <!-- RATING -->
                <div class="filter-section">
                    <h6 class="fw-bold mb-3">Rating</h6>
                    <c:forEach var="r" begin="1" end="5">
                        <c:set var="rev" value="${6 - r}" />
                        <div class="form-check">
                            <input class="form-check-input" type="radio" name="rate" id="rate-${rev}" value="${rev}"
                                   <c:if test="${param.rate == rev}">checked</c:if>>
                            <label class="form-check-label" for="rate-${rev}">
                                <c:forEach var="i" begin="1" end="${rev}">
                                    <i class="bi bi-star-fill text-warning"></i>
                                </c:forEach>
                                <c:forEach var="i" begin="1" end="${5 - rev}">
                                    <i class="bi bi-star text-warning"></i>
                                </c:forEach>
                                &nbsp;and up
                            </label>
                        </div>
                    </c:forEach>
                </div>

                <!-- APPLY FILTER -->
                <div class="d-grid mt-4">
                    <button type="submit" class="btn btn-dark">Filter Products</button>
                </div>
            </form>
        </aside>

        <!-- Product Grid -->
        <main class="col-lg-9 col-md-8">
            <div class="d-flex justify-content-between align-items-center mb-3">
                <h4 class="fw-bold text-dark mb-0">All Products</h4>
            </div>

            <div class="row g-4">
                <c:if test="${empty listProduct}">
                    <p class="text-danger text-center">No products found!</p>
                </c:if>

                <c:forEach var="product" items="${listProduct}">
                    <!-- 4 sản phẩm mỗi hàng -->
                    <div class="col-12 col-sm-6 col-md-4 col-lg-3">
                        <div class="product-card card border-0 shadow-sm">
                            <div class="image-container">
                                <img src="${product.imageUrl}" alt="${product.productName}" class="product-img">
                                <div class="overlay">
                                    <a href="<%=request.getContextPath()%>/product?view=detail&productId=${product.productId}" class="btn btn-light btn-sm">
                                        <i class="bi bi-eye"></i> View
                                    </a>
                                </div>
                            </div>
                            <div class="card-body text-center">
                                <h6 class="fw-bold text-uppercase text-truncate">${product.productName}</h6>
                                <fmt:formatNumber value="${product.price}" pattern="#,##0" />đ
                            </div>
                        </div>
                    </div>
                </c:forEach>
            </div>

            <!-- Pagination -->
            <!-- Pagination -->
            <div class="d-flex justify-content-center mt-4">
                <nav aria-label="Page navigation example">
                    <ul class="pagination">
                        <!-- Previous -->
                        <c:if test="${currentPage > 1}">
                            <c:url var="prevUrl" value="/product">
                                <c:param name="view" value="list"/>
                                <c:if test="${not empty param.category}"><c:param name="category" value="${param.category}"/></c:if>
                                <c:if test="${not empty param.minPrice}"><c:param name="minPrice" value="${param.minPrice}"/></c:if>
                                <c:if test="${not empty param.maxPrice}"><c:param name="maxPrice" value="${param.maxPrice}"/></c:if>
                                <c:if test="${not empty param.rate}"><c:param name="rate" value="${param.rate}"/></c:if>
                                <c:if test="${not empty param.keyword}"><c:param name="keyword" value="${param.keyword}"/></c:if>
                                <c:param name="page" value="${currentPage - 1}"/>
                            </c:url>
                            <li class="page-item"><a class="page-link" href="${prevUrl}">&laquo;</a></li>
                            </c:if>

                        <!-- Logic rút gọn hiển thị -->
                        <c:set var="startPage" value="${currentPage - 2}" />
                        <c:set var="endPage" value="${currentPage + 2}" />
                        <c:if test="${startPage < 1}">
                            <c:set var="endPage" value="${endPage + (1 - startPage)}" />
                            <c:set var="startPage" value="1" />
                        </c:if>
                        <c:if test="${endPage > totalPages}">
                            <c:set var="startPage" value="${startPage - (endPage - totalPages)}" />
                            <c:set var="endPage" value="${totalPages}" />
                        </c:if>
                        <c:if test="${startPage < 1}">
                            <c:set var="startPage" value="1" />
                        </c:if>

                        <!-- Hiện trang đầu -->
                        <c:if test="${startPage > 1}">
                            <c:url var="firstUrl" value="/product">
                                <c:param name="view" value="list"/>
                                <c:param name="page" value="1"/>
                            </c:url>
                            <li class="page-item"><a class="page-link" href="${firstUrl}">1</a></li>
                            <li class="page-item disabled"><span class="page-link">...</span></li>
                            </c:if>

                        <!-- Vòng lặp trang trong khoảng -->
                        <c:forEach begin="${startPage}" end="${endPage}" var="i">
                            <c:url var="pageUrl" value="/product">
                                <c:param name="view" value="list"/>
                                <c:if test="${not empty param.category}"><c:param name="category" value="${param.category}"/></c:if>
                                <c:if test="${not empty param.minPrice}"><c:param name="minPrice" value="${param.minPrice}"/></c:if>
                                <c:if test="${not empty param.maxPrice}"><c:param name="maxPrice" value="${param.maxPrice}"/></c:if>
                                <c:if test="${not empty param.rate}"><c:param name="rate" value="${param.rate}"/></c:if>
                                <c:if test="${not empty param.keyword}"><c:param name="keyword" value="${param.keyword}"/></c:if>
                                <c:param name="page" value="${i}"/>
                            </c:url>
                            <li class="page-item ${i == currentPage ? 'active' : ''}">
                                <a class="page-link" href="${pageUrl}">${i}</a>
                            </li>
                        </c:forEach>

                        <!-- Hiện trang cuối -->
                        <c:if test="${endPage < totalPages}">
                            <li class="page-item disabled"><span class="page-link">...</span></li>
                                <c:url var="lastUrl" value="/product">
                                    <c:param name="view" value="list"/>
                                    <c:param name="page" value="${totalPages}"/>
                                </c:url>
                            <li class="page-item"><a class="page-link" href="${lastUrl}">${totalPages}</a></li>
                            </c:if>

                        <!-- Next -->
                        <c:if test="${currentPage < totalPages}">
                            <c:url var="nextUrl" value="/product">
                                <c:param name="view" value="list"/>
                                <c:if test="${not empty param.category}"><c:param name="category" value="${param.category}"/></c:if>
                                <c:if test="${not empty param.minPrice}"><c:param name="minPrice" value="${param.minPrice}"/></c:if>
                                <c:if test="${not empty param.maxPrice}"><c:param name="maxPrice" value="${param.maxPrice}"/></c:if>
                                <c:if test="${not empty param.rate}"><c:param name="rate" value="${param.rate}"/></c:if>
                                <c:if test="${not empty param.keyword}"><c:param name="keyword" value="${param.keyword}"/></c:if>
                                <c:param name="page" value="${currentPage + 1}"/>
                            </c:url>
                            <li class="page-item"><a class="page-link" href="${nextUrl}">&raquo;</a></li>
                            </c:if>
                    </ul>

                </nav>
            </div>

        </main>
    </div>
</div>


<%@include file="/components/footer/footer.jsp"%>
