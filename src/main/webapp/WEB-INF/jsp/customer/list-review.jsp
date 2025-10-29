<%-- 
    Document   : list-review
    Created on : Oct 18, 2025, 12:12:16 PM
    Author     : Admin
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!DOCTYPE html>
<html>
    <!-- Comment Section -->
    <hr class="my-4">
    <h4>Customer Reviews (${totalReviews})</h4>
    <c:choose>
        <c:when test="${not empty listReview}">
            <c:forEach var="fb" items="${listReview}">
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
</html>
