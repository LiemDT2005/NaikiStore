<%-- 
    Document   : toastMessage
    Created on : 21 Oct 2025, 00:46:28
    Author     : Do Ho Gia Huy - CE191293
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%-- LƯU MESSAGE VÀO BIẾN TẠM + TẠO TIMESTAMP --%>
<c:set var="successMsg" value="${message}" />
<c:set var="errorMsg" value="${errorMessage}" />
<c:set var="msgTimestamp" value="<%= System.currentTimeMillis()%>" />

<%-- XÓA NGAY KHỎI SESSION --%>
<c:remove var="message" scope="session" />
<c:remove var="errorMessage" scope="session" />
<!-- jQuery + Toastr -->
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script src="//cdnjs.cloudflare.com/ajax/libs/toastr.js/latest/js/toastr.min.js"></script>
<link rel="stylesheet" href="//cdnjs.cloudflare.com/ajax/libs/toastr.js/latest/css/toastr.min.css" />

<script>
    // ============================================
    // 🛡️ AN TOÀN: Hiển thị message CHỈ 1 LẦN
    // ============================================
    function showToastOnce(message, type, timestamp) {
        try {
            if (typeof (Storage) === "undefined") {
                if (type === 'success') {
                    toastr.success(message, 'Success', {timeOut: 2000, progressBar: true, closeButton: true});
                } else {
                    toastr.error(message, 'Error', {timeOut: 3000, progressBar: true, closeButton: true});
                }
                return;
            }

            var storageKey = 'toastTimestamp_' + type;
            var lastShown = localStorage.getItem(storageKey);

            if (!lastShown || lastShown !== String(timestamp)) {
                if (type === 'success') {
                    toastr.success(message, 'Success', {timeOut: 2000, progressBar: true, closeButton: true});
                } else {
                    toastr.error(message, 'Error', {timeOut: 3000, progressBar: true, closeButton: true});
                }
                localStorage.setItem(storageKey, timestamp);
            }
        } catch (e) {
            if (type === 'success') {
                toastr.success(message, 'Success', {timeOut: 2000, progressBar: true, closeButton: true});
            } else {
                toastr.error(message, 'Error', {timeOut: 3000, progressBar: true, closeButton: true});
            }
        }
    }

    // ✅ Hiển thị messages
    <c:if test="${not empty successMsg}">
    showToastOnce('${successMsg}', 'success', ${msgTimestamp});
    </c:if>

    <c:if test="${not empty errorMsg}">
    showToastOnce('${errorMsg}', 'error', ${msgTimestamp});
    </c:if>
</script>
