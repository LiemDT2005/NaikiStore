<%@ page contentType="text/html" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Edit Voucher</title>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/assets/css/bootstrap.min.css">
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/assets/css/dashboard.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css">
    <style>
        body { background-color: #f9fafb; }
        .widget-box { background: #ffffff; border-radius: 12px; box-shadow: 0 4px 12px rgba(0,0,0,0.05); padding: 24px; margin-bottom: 24px; }
        .widget-box h5 { font-weight: 600; margin-bottom: 20px; color: #343a40; border-bottom: 1px solid #e9ecef; padding-bottom: 12px; }
        .main-layout { display: grid; grid-template-columns: 2fr 1fr; gap: 24px; }
        .form-grid { display: grid; grid-template-columns: repeat(2, 1fr); gap: 20px; }
        .form-group.full-width { grid-column: 1 / -1; }
        .form-group label { display: block; color: #495057; margin-bottom: 8px; font-size: 14px; font-weight: 500; }
        .form-group input[type="text"], .form-group input[type="number"], .form-group input[type="date"], .form-group textarea { width: 100%; padding: 10px 12px; border: 1px solid #ced4da; border-radius: 8px; font-size: 14px; }
        .form-group input:focus, .form-group textarea:focus { border-color: #435EBE; box-shadow: 0 0 0 0.2rem rgba(67, 94, 190, 0.25); outline: none; }
        .btn { border-radius: 8px; font-weight: 500; padding: 10px 18px; border: none; cursor: pointer; text-decoration: none; display: inline-flex; align-items: center; justify-content: center; gap: 8px; width: 100%; margin-bottom: 12px; }
        .btn-primary { background-color: #435EBE; color: #fff; }
        .btn-secondary { background-color: #e9ecef; color: #495057; }
        .btn-danger { background-color: #e74c3c; color: white; }
        .btn-danger-outline { background-color: transparent; color: #e74c3c; border: 1px solid #e74c3c; }
        .error-message{ background:#f8d7da; color:#721c24; border:1px solid #f5c6cb; padding:12px; border-radius:8px; margin-bottom:20px; }
        .toggle-switch { position: relative; display: inline-block; width: 50px; height: 28px; }
        .toggle-switch input { opacity: 0; width: 0; height: 0; }
        .slider { position: absolute; cursor: pointer; top: 0; left: 0; right: 0; bottom: 0; background-color: #ccc; transition: .4s; border-radius: 28px; }
        .slider:before { position: absolute; content: ""; height: 20px; width: 20px; left: 4px; bottom: 4px; background-color: white; transition: .4s; border-radius: 50%; }
        input:checked + .slider { background-color: #1abc9c; }
        input:checked + .slider:before { transform: translateX(22px); }
        @media(max-width: 992px) { .main-layout { grid-template-columns: 1fr; } }
        @media(max-width: 768px) { .form-grid { grid-template-columns: 1fr; } }

        /* --- CSS FOR DELETE MODAL --- */
        .modal-overlay { position: fixed; top: 0; left: 0; width: 100%; height: 100%; background: rgba(0, 0, 0, 0.6); z-index: 1000; display: none; align-items: center; justify-content: center; }
        .modal-box { background: white; padding: 30px; border-radius: 12px; width: 100%; max-width: 450px; text-align: center; box-shadow: 0 5px 15px rgba(0,0,0,0.3); }
        .modal-box .icon { font-size: 48px; color: #e74c3c; margin-bottom: 15px; }
        .modal-box h4 { font-weight: 600; margin-bottom: 10px; color: #2c3e50; }
        .modal-box p { color: #7f8c8d; margin-bottom: 25px; }
        .modal-actions { display: flex; gap: 15px; justify-content: center; }
        .modal-actions .btn { width: auto; padding: 10px 25px; }
    </style>
</head>
<body class="ttr-opened-sidebar ttr-pinned-sidebar">
<jsp:include page="/components/header/header.jsp"/>

<main class="ttr-wrapper">
    <div class="container-fluid">
        <div class="db-breadcrumb">
            <h4 class="breadcrumb-title">Edit Voucher</h4>
        </div>

        <c:if test="${not empty error}"><div class="error-message">${error}</div></c:if>

        <c:if test="${empty voucher}">
            <div class="widget-box">Voucher not found. <a href="${pageContext.request.contextPath}/managevouchers">Back to list</a></div>
        </c:if>

        <c:if test="${not empty voucher}">
            <form method="post" action="${pageContext.request.contextPath}/updatevoucher">
                <input type="hidden" name="voucherId" value="${voucher.voucherID}"/>
                <div class="main-layout">
                    <div class="form-column">
                        <div class="widget-box">
                            <h5><i class="fa fa-ticket"></i> Voucher Information</h5>
                            <div class="form-grid">
                                <div class="form-group">
                                    <label>Voucher Name</label>
                                    <input type="text" name="name" value="${voucher.name}" required />
                                </div>
                                <div class="form-group">
                                    <label>Voucher Code</label>
                                    <input type="text" name="code" value="${voucher.code}" required />
                                </div>
                                <div class="form-group">
                                    <label>Discount Percentage (%)</label>
                                    <input type="number" name="discountPercentage" step="0.01" min="0" max="100" value="${voucher.discountPercentage}" />
                                </div>
                                <div class="form-group">
                                    <label>Max Discount Amount (VND)</label>
                                    <input type="number" name="maxReducing" step="0.01" min="0" value="${voucher.maxReducing}" />
                                </div>
                                <div class="form-group">
                                    <label>Quantity</label>
                                    <input type="number" name="quantity" min="0" value="${voucher.quantity}" />
                                </div>
                                <c:set var="expiryStr"><fmt:formatDate value="${voucher.expiryDate}" pattern="yyyy-MM-dd"/></c:set>
                                <div class="form-group">
                                    <label>Expiry Date</label>
                                    <input type="date" name="expiryDate" value="${expiryStr}" />
                                </div>
                                <div class="form-group">
                                    <label>Minimum Order Value (VND)</label>
                                    <input type="number" name="minOrderValue" step="0.01" min="0" value="${voucher.minOrderValue}" />
                                </div>
                                <div class="form-group">
                                    <label>Max Usage Per User</label>
                                    <input type="number" name="maxUsagePerUser" min="0" value="${voucher.maxUsagePerUser}" />
                                </div>
                                <div class="form-group full-width">
                                    <label>Description</label>
                                    <textarea name="description" rows="4">${voucher.description}</textarea>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="action-column">
                        <div class="widget-box">
                            <h5><i class="fa fa-cog"></i> Actions</h5>
                            <div class="form-group">
                                <label>Status</label>
                                <label class="toggle-switch">
                                    <input type="checkbox" name="active" value="true" ${voucher.active ? 'checked' : ''}>
                                    <span class="slider"></span>
                                </label>
                            </div>
                            <button type="submit" class="btn btn-primary"><i class="fa fa-save"></i> Save Changes</button>
                            <a href="${pageContext.request.contextPath}/managevouchers" class="btn btn-secondary"><i class="fa fa-times"></i> Cancel</a>
                            <button type="button" id="delete-voucher-btn" class="btn btn-danger-outline" style="margin-top: 20px;"><i class="fa fa-trash-alt"></i> Delete Voucher</button>
                        </div>
                    </div>
                </div>
            </form>

            <form id="delete-form" method="post" action="${pageContext.request.contextPath}/deletevoucher" style="display: none;">
                <input type="hidden" name="voucherId" value="${voucher.voucherID}"/>
            </form>
        </c:if>
    </div>
</main>

<div id="delete-modal" class="modal-overlay">
    <div class="modal-box">
        <div class="icon"><i class="fa fa-exclamation-triangle"></i></div>
        <h4>Confirm Deletion</h4>
        <p>Are you sure you want to permanently delete this voucher? This action cannot be undone.</p>
        <div class="modal-actions">
            <button id="cancel-delete-btn" class="btn btn-secondary">Cancel</button>
            <button id="confirm-delete-btn" class="btn btn-danger">Confirm Delete</button>
        </div>
    </div>
</div>


<script>
    document.addEventListener('DOMContentLoaded', function() {
        const deleteModal = document.getElementById('delete-modal');
        const openModalBtn = document.getElementById('delete-voucher-btn');
        const closeModalBtn = document.getElementById('cancel-delete-btn');
        const confirmDeleteBtn = document.getElementById('confirm-delete-btn');
        const deleteForm = document.getElementById('delete-form');

        // Function to show the modal
        const showModal = () => {
            deleteModal.style.display = 'flex';
        };

        // Function to hide the modal
        const hideModal = () => {
            deleteModal.style.display = 'none';
        };

        // Event listeners
        openModalBtn.addEventListener('click', showModal);
        closeModalBtn.addEventListener('click', hideModal);

        // Hide modal if user clicks on the overlay
        deleteModal.addEventListener('click', function(event) {
            if (event.target === deleteModal) {
                hideModal();
            }
        });

        // Handle the final delete confirmation
        confirmDeleteBtn.addEventListener('click', function() {
            deleteForm.submit();
        });
    });
</script>
<jsp:include page="/components/footer/footer.jsp"/>
</body>
</html>