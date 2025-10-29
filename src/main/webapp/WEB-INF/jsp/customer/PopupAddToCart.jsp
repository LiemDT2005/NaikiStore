<%-- 
    Document   : PopupAddToCart
    Created on : Oct 18, 2025, 10:50:56 PM
    Author     : Dang Thanh Liem - CE190697
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<c:if test="${not empty sessionScope.status}">
    <div id="popup" class="popup show">
        <div class="popup-content">
            <c:choose>
                <c:when test="${sessionScope.status == 'successful'}">
                    <i class="bi bi-check-circle-fill text-success" style="font-size: 2rem;"></i>
                </c:when>
                <c:otherwise>
                    <i class="bi bi-x-circle-fill text-danger" style="font-size: 2rem;"></i>
                </c:otherwise>
            </c:choose>

            <p class="mt-2">${sessionScope.message}</p>
            <button class="btn btn-primary mt-2" onclick="closePopup()">OK</button>
        </div>
    </div>

    <style>
        .popup {
            position: fixed;
            top: 0; left: 0; right: 0; bottom: 0;
            background: rgba(0,0,0,0.4);
            display: flex;
            align-items: center;
            justify-content: center;
            z-index: 1050;
        }

        .popup-content {
            background: #fff;
            padding: 25px 40px;
            border-radius: 12px;
            text-align: center;
            box-shadow: 0 5px 15px rgba(0,0,0,0.2);
            animation: fadeIn 0.3s ease;
        }

        @keyframes fadeIn {
            from { opacity: 0; transform: scale(0.9); }
            to { opacity: 1; transform: scale(1); }
        }
    </style>

    <script>
        function closePopup() {
            const popup = document.getElementById('popup');
            if (popup) popup.remove();
        }

        const status = '<c:out value="${sessionScope.status}" />';
        if (status === 'successful') {
            setTimeout(() => closePopup(), 2000);
        }

        document.addEventListener('click', e => {
            if (e.target.id === 'popup') closePopup();
        });
    </script>

    <c:remove var="status" scope="session" />
    <c:remove var="message" scope="session" />
</c:if>
