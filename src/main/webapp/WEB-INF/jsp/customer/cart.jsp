<%-- 
    Document   : cart
    Created on : Oct 10, 2025, 8:15:32 PM
    Author     : Dang Thanh Liem - CE190697
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<fmt:setLocale value="vi_VN" />
<%@include file="/components/header/header.jsp"%>

<c:set var="total" value="${sessionScope.total}" scope="page"/>
<c:remove var="total" scope="session"/>
<c:if test="${not empty sessionScope.flashMessage}">
    <div class="alert alert-danger">${sessionScope.flashMessage}</div>
    <c:remove var="flashMessage" scope="session"/>
</c:if>
<style>
    .my-link {
        transition: all 0.3s ease; /* Tạo hiệu ứng mượt */
    }

    .my-link:hover {
        transform: scale(1.05); /* To lên 5% */
        box-shadow: 0 0.5rem 1rem rgba(0, 0, 0, 0.15); /* Bóng đổ nhẹ */
    }
</style>
<div class="container my-5">
    <h2 class="text-center fw-bold mb-4">My Cart</h2>
    <div class="row">
        <!-- Cart Items -->
        <div class="col-lg-8">
            <c:if test="${not empty listCartItems}">
                <div class="border p-3 mb-3 rounded">
                    <c:forEach var="cartItem" items="${listCartItems}">
                        <div class="card mb-3 my-link cart-item">
                            <div class="row g-0 align-items-center">
                                <!-- Product Image -->
                                <div class="col-md-3">
                                    <img src="${cartItem.imageURL}" class="img-fluid rounded-start" alt="${cartItem.product.productName}">
                                </div>

                                <!-- Product Info -->
                                <div class="col-md-9">
                                    <div class="card-body position-relative">
                                        <h5 class="card-title fw-bold">${cartItem.product.productName}</h5>
                                        <p class="card-text small text-muted mb-1">
                                            Size: ${cartItem.size} <br>
                                            Color: ${cartItem.color} <br>
                                            Added on:
                                            <fmt:formatDate value="${cartItem.createdAt}" pattern="dd/MM/yyyy HH:mm" />
                                        </p>

                                        <p class="card-text small text-muted mb-2">
                                            Unit price:
                                            <span class="unit-price">
                                                <fmt:formatNumber value="${cartItem.price}" pattern="#,##0" />đ
                                            </span>
                                        </p>

                                        <form method="POST" action="${pageContext.request.contextPath}/cart" class="d-inline">
                                            <input type="hidden" name="cart" value="edit">
                                            <input type="hidden" name="cartId" value="${cartItem.cartItemID}">
                                            <input type="hidden" name="action" value="" class="actionField">

                                            <div class="d-flex align-items-center mb-2 position-absolute bottom-0 end-0 me-3 mb-2">
                                                <!-- Giảm -->
                                                <button type="button" class="btn btn-outline-dark btn-sm me-1"
                                                        onclick="updateCart(this.form, 'decrease')">−</button>

                                                <!-- Nhập số lượng -->
                                                <input type="number" name="quantity" min="1" 
                                                       value="${cartItem.quantity}" 
                                                       class="form-control text-center" style="width: 60px;"
                                                       onchange="updateCart(this.form, 'updateQuantity')">

                                                <!-- Tăng -->
                                                <button type="button" class="btn btn-outline-dark btn-sm ms-1"
                                                        onclick="updateCart(this.form, 'increase')">+</button>
                                            </div>
                                        </form>

                                        <p class="fw-bold text-danger">
                                            Total:
                                            <span class="item-total">
                                                <fmt:formatNumber value="${cartItem.price * cartItem.quantity}" pattern="#,##0" />đ
                                            </span>
                                        </p>

                                        <!--Xoa -->
                                        <form method="post" action="${pageContext.request.contextPath}/cart" class="mt-2">
                                            <input type="hidden" name="action" value="delete">
                                            <input type="hidden" name="cartId" value="${cartItem.cartItemID}">
                                            <button type="submit" class="btn btn-dark btn-sm me-2">Delete</button>
                                        </form>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </c:forEach>
                </div>
            </c:if>
        </div>

        <!-- Order Summary -->
        <div class="col-lg-4">
            <c:if test="${not empty listCartItems}">
                <div class="bg-white border p-4 rounded shadow-sm sticky-top" style="top: 100px;">
                    <h4 class="fw-bold mb-3">Order summary</h4>
                    <div class="d-flex justify-content-between mb-2">
                        <span>Subtotal:</span>
                        <span id="subtotal"><fmt:formatNumber value="${total}" pattern="#,##0" />đ</span>
                    </div>
                    <hr>
                    <div class="d-flex justify-content-between mb-3">
                        <strong class="text-danger fs-5">TOTAL:</strong>
                        <strong class="text-danger fs-5" id="grandtotal">
                            <fmt:formatNumber value="${total}" pattern="#,##0" />đ
                        </strong>
                    </div>
                    <a href="${pageContext.request.contextPath}/checkout?action=buyall"
                       class="btn btn-dark w-100">Order now</a>
                </div>
            </c:if>
        </div>
    </div>

    <!-- Empty cart -->
    <c:if test="${empty listCartItems}">
        <p class="text-danger fs-5 fw-bold text-center mt-4">
            Your cart is empty. Try to see something else!
        </p>
    </c:if>
</div>
<script>
    function updateCart(form, actionType) {
        form.querySelector('.actionField').value = actionType;
        form.submit();
    }
</script>
<%@include file="/components/footer/footer.jsp"%>
