<%-- 
    Document   : rate
    Created on : Jul 6, 2025, 10:36:43 AM
    Author     : Admin
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%--<%@include file="/WEB-INF/include/header.jsp" %>--%>

<!DOCTYPE html>
<html lang="en">
    <head>
        <title>Rating</title>
        <style>
            .rating {
                direction: rtl;
                display: inline-flex;
            }

            .rating input[type="radio"] {
                display: none;
            }

            .rating label {
                font-size: 2rem;
                color: #ccc;
                cursor: pointer;
                padding: 0 4px;
            }

            .rating input[type="radio"]:checked ~ label {
                color: #ffc107;
            }

            .rating label:hover,
            .rating label:hover ~ label {
                color: #ffc107;
            }
        </style>
    </head>
    <body>
        <c:if test="${empty message}">
            <div class="container mt-5">
                <h3 class="mb-4">Rating</h3>

                <form method="POST" action="${pageContext.request.contextPath}/orderDetail">
                    <input type="hidden" name="orderId" value="${orderId}"/>
                    <input type="hidden" name="status" value="${status}"/>
                    <input type="hidden" name="customerId" value="${customerId}"/>
                    <input type="hidden" name="productId" value="${productId}"/>
                    <!-- Star rate -->
                    <c:set var="stars" value="${fn:split('5,4,3,2,1', ',')}" />
                    <div class="rating">
                        <c:forEach var="i" items="${stars}">
                            <input type="radio" id="star${i}" name="rating" value="${i}" 
                                   <c:if test="${rating eq i && action eq 'edit'}">checked</c:if> />
                            <label for="star${i}">&#9733;</label>
                        </c:forEach>
                    </div>

                    <!-- Comment -->
                    <div class="mb-3">
                        <label for="comment" class="form-label">Comment:</label>
                        <textarea class="form-control" id="comment" name="comment" rows="3" placeholder="Comment..."><c:if test="${action eq 'edit'}">${comment}</c:if></textarea>
                        </div>
                    <c:if test="${not empty rating && action eq 'edit'}">
                        <input type="hidden" name="action" value="edit"/>
                        <button type="submit" class="btn btn-primary btn-sm">Edit</button>
                    </c:if>
                    <c:if test="${action ne 'edit'}">
                        <input type="hidden" name="action" value="rating"/>
                        <button type="submit" class="btn btn-primary">Send your rating</button>
                    </c:if> 

                </form>

            </div>
        </c:if>
        <c:if test="${not empty message}">
            <p>${message}</p>
            <a href="${pageContext.request.contextPath}/orderDetail?orderId=${orderId}&status=${status}" class="btn btn-primary text-white mt-3">← Back to My Orders</a>
        </c:if>
    </body>
    <%--<%@include file="/WEB-INF/include/footer.jsp" %>--%>