<%-- 
    Document   : dashboard
    Created on : Oct 11, 2025, 9:09:01 AM
    Author     : PhucTDMCE190744
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
        <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons/font/bootstrap-icons.css" rel="stylesheet">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/styles/manager.css?v=<%= System.currentTimeMillis()%>">
        <title>Dashboard</title>
    </head>
    <body>
        <%@include file="/components/admin_header/dashboard_header.jsp" %>

        <!-- Main inner content takes full height -->
        <div>
            <div class="border border-danger">
                <div class="text-center d-flex flex-column align-items-center justify-content-center">
                    <img src="${pageContext.request.contextPath}/assets/img/HeaderLogo.png" alt="Naiki Logo" style="width: 300px;">
                    <h3 class="mt-3 fw-bold">Welcome to Naiki Admin Dashboard</h3>
                </div>
            </div>
        </div>

    </body>
</html>
