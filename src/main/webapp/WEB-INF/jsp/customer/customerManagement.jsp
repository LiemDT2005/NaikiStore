<%@ page contentType="text/html" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!DOCTYPE html>
<html>
<head>
    <title>Customer Management</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/styles/bootstrap.min.css"/>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css">
    <style>
        .page-title { font-weight: 600; font-size: 24px; margin: 20px 0; }
        .avatar-img { width: 40px; height: 40px; object-fit: cover; border-radius: 50%; }
        .search-bar { max-width: 420px; }
        .modal-header .bi {
            font-size: 1.5rem;
            margin-right: 0.75rem;
        }
    </style>
</head>
<body>
<%@include file="/components/header/header.jsp" %>
<div class="container mt-4 mb-5">
    <%-- Phần tìm kiếm và tiêu đề trang (giữ nguyên) --%>
    <div class="d-flex align-items-center justify-content-between mb-3">
        <div class="page-title">Customer Management</div>
        <form class="d-flex search-bar" method="get" action="${pageContext.request.contextPath}/customers">
            <input type="text" class="form-control me-2" name="keyword" placeholder="Search by name or email" aria-label="Search by name or email" value="${fn:escapeXml(param.keyword)}"/>
            <input type="hidden" name="size" value="${size}"/>
            <button class="btn btn-primary" type="submit">Search</button>
        </form>
    </div>

    <%-- Bảng quản lý khách hàng --%>
    <div class="card">
        <div class="table-responsive">
            <table class="table table-striped table-hover mb-0">
                <thead class="table-light">
                <tr>
                    <th>Avatar</th>
                    <th>Username</th>
                    <th>Name</th>
                    <th>Email</th>
                    <th>Phone</th>
                    <th>Gender</th>
                    <th>Address</th>
                    <th>Status</th>
                    <th>Action</th>
                </tr>
                </thead>
                <tbody>
                <c:forEach var="cst" items="${customers}">
                    <tr data-customer-name="${fn:escapeXml(cst.customerName)}">
                        <td>
                            <c:choose>
                                <c:when test="${not empty cst.avatar}">
                                    <img class="avatar-img" src="${cst.avatar}" alt="avatar"/>
                                </c:when>
                                <c:otherwise>
                                    <div class="avatar-img bg-secondary d-inline-flex align-items-center justify-content-center text-white">${fn:substring(cst.customerName, 0, 1)}</div>
                                </c:otherwise>
                            </c:choose>
                        </td>
                        <td><a href="${pageContext.request.contextPath}/customerdetail?id=${cst.customerID}">${cst.customerID}</a></td>
                        <td>${cst.customerName}</td>
                        <td>${cst.email}</td>
                        <td>${cst.phone}</td>
                        <td>${cst.gender}</td>
                        <td>${cst.address}</td>
                        <td>
                            <c:choose>
                                <c:when test="${cst.status eq 'Active'}"><span class="badge bg-success">Active</span></c:when>
                                <c:when test="${cst.status eq 'Banned'}"><span class="badge bg-danger">Banned</span></c:when>
                                <c:otherwise><span class="badge bg-secondary">${cst.status}</span></c:otherwise>
                            </c:choose>
                        </td>
                        <td>
                            <form method="post" action="${pageContext.request.contextPath}/update-customer-status" id="form-${cst.customerID}" class="d-inline">
                                <input type="hidden" name="customerId" value="${cst.customerID}"/>
                                <c:choose>
                                    <c:when test="${cst.status eq 'Active'}">
                                        <input type="hidden" name="newStatus" value="Banned"/>
                                        <%-- **SỬA LỖI TẠI ĐÂY**: Đảm bảo `data-customer-name` có giá trị từ JSTL --%>
                                        <button type="button" class="btn btn-sm btn-danger"
                                                data-bs-toggle="modal"
                                                data-bs-target="#confirmationModal"
                                                data-form-id="form-${cst.customerID}"
                                                data-customer-name="${fn:escapeXml(cst.customerName)}"
                                                data-action="Ban">
                                            Ban
                                        </button>
                                    </c:when>
                                    <c:otherwise>
                                        <input type="hidden" name="newStatus" value="Active"/>
                                        <button type="button" class="btn btn-sm btn-success"
                                                data-bs-toggle="modal"
                                                data-bs-target="#confirmationModal"
                                                data-form-id="form-${cst.customerID}"
                                                data-customer-name="${fn:escapeXml(cst.customerName)}"
                                                data-action="Unban">
                                            Unban
                                        </button>
                                    </c:otherwise>
                                </c:choose>
                            </form>
                        </td>
                    </tr>
                </c:forEach>
                <c:if test="${empty customers}">
                    <tr><td colspan="9" class="text-center text-muted">No customers found.</td></tr>
                </c:if>
                </tbody>
            </table>
        </div>
    </div>

    <%-- Phần phân trang (giữ nguyên) --%>
    <c:if test="${totalPages > 1}">
        <%-- ... code phân trang của bạn ... --%>
    </c:if>
</div>

<%-- Modal xác nhận --%>
<div class="modal fade" id="confirmationModal" tabindex="-1" aria-labelledby="modalLabel" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title d-flex align-items-center" id="modalLabel"></h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body" id="modalBody">
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
                <button type="button" class="btn" id="confirmActionBtn">Confirm</button>
            </div>
        </div>
    </div>
</div>

<%@include file="/components/footer/footer.jsp" %>
<script src="${pageContext.request.contextPath}/scripts/bootstrap.bundle.min.js"></script>

<%-- JavaScript đã sửa lỗi và bổ sung fallback lấy tên --%>
<script>
    document.addEventListener('DOMContentLoaded', function () {
        const confirmationModal = document.getElementById('confirmationModal');
        if (!confirmationModal) return;

        const confirmActionBtn = document.getElementById('confirmActionBtn');
        const modalTitle = document.getElementById('modalLabel');
        const modalBody = document.getElementById('modalBody');

        let formToSubmit = null;

        function buildBodyMessage(action, customerName) {
            modalBody.innerHTML = '';
            const actionWord = (action === 'Ban') ? 'ban' : 'unban';
            const before = document.createTextNode(`Are you sure you want to ${actionWord} the account of customer "`);
            const strong = document.createElement('strong');
            strong.textContent = customerName || '(unknown)';
            const after = document.createTextNode('"?');
            modalBody.append(before, strong, after);
        }

        confirmationModal.addEventListener('show.bs.modal', function (event) {
            const button = event.relatedTarget;
            if (!button) return;

            const formId = button.getAttribute('data-form-id');
            let customerName = (button.getAttribute('data-customer-name') || '').trim();

            const row = button.closest('tr');
            if (!customerName && row && row.dataset) {
                customerName = (row.dataset.customerName || '').trim();
            }
            if (!customerName && row) {
                const nameCell = row.querySelector('td:nth-child(3)');
                if (nameCell) customerName = (nameCell.textContent || '').trim();
            }

            const action = button.getAttribute('data-action');
            formToSubmit = document.getElementById(formId);

            if (action === 'Ban') {
                modalTitle.innerHTML = '<i class="bi bi-exclamation-triangle-fill text-danger"></i> Confirm ban account';
                buildBodyMessage(action, customerName);
                confirmActionBtn.className = 'btn btn-danger';
                confirmActionBtn.textContent = 'Confirm ban';
            } else {
                modalTitle.innerHTML = '<i class="bi bi-check-circle-fill text-success"></i> Confirm unban account';
                buildBodyMessage(action, customerName);
                confirmActionBtn.className = 'btn btn-success';
                confirmActionBtn.textContent = 'Confirm unban';
            }
        });

        confirmActionBtn.addEventListener('click', function () {
            if (formToSubmit) {
                formToSubmit.submit();
            }
        });
    });
</script>

</body>
</html>