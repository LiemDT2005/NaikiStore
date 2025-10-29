    <%--
    Document   : dashboard
    Created on : Oct 11, 2025, 9:09:01 AM
    Author     : PhucTDMCE190744
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
        <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons/font/bootstrap-icons.css" rel="stylesheet">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/styles/manager.css?v=<%= System.currentTimeMillis()%>">
        
        <title></title>
    </head>
    <body>
        <%@include file="/components/admin_header/dashboard_header.jsp" %>

        <!-- Main inner content takes full height -->
        <div class="main-inner" id="content-area">
            <!-- Code trong phạm vi block code bên dưới -->
            <!-- START BLOCK CODE -->

            <div class="container-fluid py-4">
                <table class="table">
                    <thead>
                        <tr>Category ID</tr>
                        <tr>Category Name</tr>
                        <tr>Category Description</tr>
                    </thead>
                    <tbody>
                        <c:forEach var="category" items="${categories}">
                            <tr>{category.categoryID}</tr>
                            <tr>{category.categoryName}</tr>
                            <tr>{category.categoryDescription}</tr>
                        </c:forEach>
                    </tbody>
                </table>
            </div>
            <!-- END BLOCK CODE -->

        </div>


        <!-- Scripts -->
        <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>

        <script>
            document.getElementById("toggleSidebar").addEventListener("click", function () {
                const sidebar = document.getElementById("sidebar");
                const mainContent = document.getElementById("mainContent");
                sidebar.classList.toggle("collapsed");
                mainContent.classList.toggle("full-width");
            });
        </script>
    </body>
</html>
