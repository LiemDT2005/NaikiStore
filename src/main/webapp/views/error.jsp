<%-- 
    Document   : error
    Created on : 11 Oct 2025, 14:48:56
    Author     : Do Ho Gia Huy - CE191293
--%>

<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Error - Naiki Store</title>
    <link rel="icon" href="${pageContext.request.contextPath}/assets/img/Favicon.png" type="image/x-icon">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/styles/bootstrap.min.css">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css">

    <style>
        body {
            background-color: #f8f9fa;
            display: flex;
            align-items: center;
            justify-content: center;
            height: 100vh;
            text-align: center;
            font-family: 'Segoe UI', sans-serif;
        }

        .error-box {
            background: #fff;
            padding: 50px 60px;
            border-radius: 16px;
            box-shadow: 0 8px 24px rgba(0,0,0,0.1);
            animation: fadeIn 0.6s ease-in-out;
        }

        @keyframes fadeIn {
            from { opacity: 0; transform: translateY(20px); }
            to { opacity: 1; transform: translateY(0); }
        }

        .error-icon {
            font-size: 60px;
            color: #dc3545;
            margin-bottom: 20px;
        }

        h2 {
            color: #333;
            font-weight: 700;
            margin-bottom: 10px;
        }

        p {
            color: #666;
            font-size: 1.1rem;
            margin-bottom: 30px;
        }

        .btn-home {
            background-color: #dc3545;
            color: #fff;
            border-radius: 8px;
            padding: 10px 24px;
            transition: all 0.3s ease;
        }

        .btn-home:hover {
            background-color: #b02a37;
            transform: translateY(-2px);
        }
    </style>
</head>
<body>
    <div class="error-box">
        <div class="error-icon">
            <i class="bi bi-exclamation-triangle-fill"></i>
        </div>

        <h2>Something went wrong!</h2>
        <p>
            <c:choose>
                <c:when test="${not empty error}">
                    ${error}
                </c:when>
                <c:otherwise>
                    An unexpected error occurred. Please try again later.
                </c:otherwise>
            </c:choose>
        </p>

        <a href="${pageContext.request.contextPath}/home" class="btn btn-home">
            <i class="bi bi-house-door"></i> Back to Homepage
        </a>
    </div>
</body>
</html>

