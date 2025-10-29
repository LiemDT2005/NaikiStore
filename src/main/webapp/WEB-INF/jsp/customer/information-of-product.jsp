<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>


<%@include file="/components/header/header.jsp"%>

<div class="container mt-5">

    <div class="row">
        <!-- Product Images -->
        <div class="col-md-7 product-images text-center">
            <c:choose>
                <%-- Nếu có ảnh --%>
                <c:when test="${not empty attributeProduct.listImage}">
                    <c:set var="listImage" value="${attributeProduct.listImage}" />

                    <div class="d-flex justify-content-center align-items-start gap-3">
                        <!-- Images -->
                        <div class="d-flex flex-column align-items-center" style="gap: 20px;">
                            <c:forEach var="img" items="${listImage}">
                                <img src="${img}" 
                                     alt="Thumbnail" 
                                     class="thumbnail rounded" 
                                     style="width: 90px; height: 90px; object-fit: cover; cursor: pointer;"
                                     onclick="changeImage(event, this.src)">
                            </c:forEach>
                        </div>

                        <!-- Main image -->
                        <div>
                            <img src="${listImage[0]}" 
                                 alt="Product" 
                                 class="img-fluid rounded product-image" 
                                 id="mainImage">
                        </div>
                    </div>
                </c:when>

                <%-- Nếu không có ảnh --%>
                <c:otherwise>
                    <img src="${pageContext.request.contextPath}/assets/img/no-image.png" 
                         alt="No image available" 
                         class="img-fluid rounded mb-3 product-image" 
                         id="mainImage">
                </c:otherwise>
            </c:choose>
        </div>

        <!-- Product Details -->
        <div class="col-md-5">
            <h2 class="mb-3">${product.productName}</h2>
            <p class="mb-4">${product.description}</p>

            <div class="mb-3">
                <span class="h4 me-2">${product.getFormattedPrice()} VNĐ</span>
            </div>

            <!-- Star Rating -->
            <div class="d-flex align-items-center mb-3">
                <c:set var="fullStars" value="${starAVG - (starAVG % 1)}" />
                <c:set var="halfStar" value="${starAVG % 1 >= 0.5}" />
                <c:forEach var="i" begin="1" end="5">
                    <c:choose>
                        <c:when test="${i <= fullStars}">
                            <i class="bi bi-star-fill text-warning"></i>
                        </c:when>
                        <c:when test="${halfStar and i == fullStars + 1}">
                            <i class="bi bi-star-half text-warning"></i>
                        </c:when>
                        <c:otherwise>
                            <i class="bi bi-star text-warning"></i>
                        </c:otherwise>
                    </c:choose>
                </c:forEach>
                <span class="ms-2">(${starAVG}) · ${totalReviews} reviews</span>
            </div>

            <form method="POST" action="${pageContext.request.contextPath}/cart">
                <!-- Size -->
                <c:if test="${not empty attributeProduct.listSize}">
                    <div class="mb-4">
                        <h5>Size</h5>
                        <c:forEach var="size" items="${attributeProduct.listSize}">
                            <div class="btn-group" role="group">
                                <input type="radio" required name="size" id="size_${size}" value="${size}" class="btn-check">
                                <label class="btn btn-outline-dark" for="size_${size}">${size}</label>
                            </div>
                        </c:forEach>
                        <div class="mt-2">
                            <a href="${pageContext.request.contextPath}/productdetail?view=hint-size" class="btn btn-info btn-sm">
                                <i class="bi bi-question-circle"></i> How to choose your size
                            </a>
                        </div>
                    </div>
                </c:if>

                <!-- Color -->
                <c:if test="${not empty attributeProduct.listColor}">
                    <div class="mb-4">
                        <h5>Color</h5>
                        <c:forEach var="color" items="${attributeProduct.listColor}">
                            <div class="btn-group" role="group">
                                <input type="radio" required name="color" id="color_${color}" value="${color}" class="btn-check">
                                <label class="btn btn-outline-dark" for="color_${color}">${color}</label>
                            </div>
                        </c:forEach>
                    </div>
                </c:if>

                <!-- Quantity -->
                <div class="mb-4">
                    <label for="quantity" class="form-label">Quantity:</label>
                    <input required type="number" class="form-control" name="quantity" id="quantity" value="1" min="1" style="width: 80px;">
                </div>

                <input type="hidden" name="productID" value="${product.productId}">
                <button type="submit" name="action" value="add" class="btn btn-outline-secondary btn-lg mb-3">
                    <i class="bi bi-cart-plus"></i> Add to Cart
                </button>
                <button type="submit" name="action" value="buy" class="btn btn-primary btn-lg mb-3">
                    <i class="bi bi-cart"></i> Buy Now
                </button>
            </form>
        </div>
    </div>

    <!-- Comment Section -->
    <hr class="my-4">
    <h4>Customer Reviews (${totalReviews})</h4>
    <c:choose>
        <c:when test="${not empty listComment}">
            <c:forEach var="fb" items="${listComment}">
                <div class="border p-3 rounded mb-3">
                    <div class="d-flex justify-content-between">
                        <strong>${fb.customerName}</strong>
                        <small class="text-muted">
                            ${fn:substring(fb.createdAt, 8, 10)}/${fn:substring(fb.createdAt, 5, 7)}/${fn:substring(fb.createdAt, 0, 4)}
                        </small>
                    </div>

                    <div>
                        <c:forEach var="i" begin="1" end="5">
                            <c:choose>

                                <c:when test="${i <= fb.rating}">
                                    <i class="bi bi-star-fill text-warning"></i>
                                </c:when>

                                <c:when test="${i - 0.5 <= fb.rating}">
                                    <i class="bi bi-star-half text-warning"></i>
                                </c:when>

                                <c:otherwise>
                                    <i class="bi bi-star text-warning"></i>
                                </c:otherwise>
                            </c:choose>
                        </c:forEach>
                        <span class="ms-2 text-muted">${fb.rating}/5</span>
                    </div>

                    <p class="mt-2 mb-0">${fb.comment}</p>
                </div>
            </c:forEach>
        </c:when>
        <c:otherwise>
            <p class="text-muted">No reviews yet. Be the first to comment!</p>
        </c:otherwise>
    </c:choose>
</div>



<%@include file="/WEB-INF/jsp/customer/PopupAddToCart.jsp"%>
<%@include file="/components/footer/footer.jsp"%>