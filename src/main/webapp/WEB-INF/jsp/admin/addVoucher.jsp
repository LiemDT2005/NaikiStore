<%@ page contentType="text/html" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Add New Voucher</title>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/assets/css/bootstrap.min.css">
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/assets/css/dashboard.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css">
    <style>
        body {
            background-color: #f9fafb;
        }

        .widget-box {
            background: #ffffff;
            border-radius: 12px;
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.05);
            padding: 24px;
            margin-bottom: 24px;
        }

        .widget-box h5 {
            font-weight: 600;
            margin-bottom: 20px;
            color: #343a40;
            border-bottom: 1px solid #e9ecef;
            padding-bottom: 12px;
        }

        .main-layout {
            display: grid;
            grid-template-columns: 2fr 1fr;
            gap: 24px;
        }

        .form-grid {
            display: grid;
            grid-template-columns: repeat(2, 1fr);
            gap: 20px;
        }

        .form-group.full-width {
            grid-column: 1 / -1;
        }

        .form-group label {
            display: block;
            color: #495057;
            margin-bottom: 8px;
            font-size: 14px;
            font-weight: 500;
        }

        .form-group input[type="text"],
        .form-group input[type="number"],
        .form-group input[type="date"],
        .form-group textarea {
            width: 100%;
            padding: 10px 12px;
            border: 1px solid #ced4da;
            border-radius: 8px;
            transition: border-color .15s ease-in-out, box-shadow .15s ease-in-out;
            font-size: 14px;
        }

        .form-group input:focus, .form-group textarea:focus {
            border-color: #435EBE;
            box-shadow: 0 0 0 0.2rem rgba(67, 94, 190, 0.25);
            outline: none;
        }

        .btn {
            border-radius: 8px;
            font-weight: 500;
            padding: 10px 18px;
            border: none;
            cursor: pointer;
            text-decoration: none;
            display: inline-flex;
            align-items: center;
            justify-content: center;
            gap: 8px;
            width: 100%;
            margin-bottom: 12px;
        }
        .btn-primary {
            background-color: #435EBE;
            color: #fff;
        }
        .btn-secondary {
            background-color: #e9ecef;
            color: #495057;
        }

        .error-message {
            background-color: #f8d7da;
            color: #721c24;
            border: 1px solid #f5c6cb;
            padding: 12px;
            border-radius: 8px;
            margin-bottom: 20px;
        }

        /* Toggle Switch */
        .toggle-switch { position: relative; display: inline-block; width: 50px; height: 28px; }
        .toggle-switch input { opacity: 0; width: 0; height: 0; }
        .slider { position: absolute; cursor: pointer; top: 0; left: 0; right: 0; bottom: 0; background-color: #ccc; transition: .4s; border-radius: 28px; }
        .slider:before { position: absolute; content: ""; height: 20px; width: 20px; left: 4px; bottom: 4px; background-color: white; transition: .4s; border-radius: 50%; }
        input:checked + .slider { background-color: #1abc9c; }
        input:checked + .slider:before { transform: translateX(22px); }

        @media(max-width: 992px) {
            .main-layout { grid-template-columns: 1fr; }
        }
        @media(max-width: 768px) {
            .form-grid { grid-template-columns: 1fr; }
        }
    </style>
</head>
<body class="ttr-opened-sidebar ttr-pinned-sidebar">
<jsp:include page="/components/header/header.jsp"/>

<main class="ttr-wrapper">
    <div class="container-fluid">
        <div class="db-breadcrumb">
            <h4 class="breadcrumb-title">Add New Voucher</h4>
        </div>

        <c:if test="${not empty error}"><div class="error-message">${error}</div></c:if>

        <form method="post" action="${pageContext.request.contextPath}/addvoucher">
            <div class="main-layout">
                <div class="form-column">
                    <div class="widget-box">
                        <h5><i class="fa fa-info-circle"></i> Voucher Details</h5>
                        <div class="form-group">
                            <label for="name">Voucher Name</label>
                            <input type="text" id="name" name="name" required placeholder="e.g. New Customer Discount">
                        </div>
                        <div class="form-group">
                            <label for="code">Voucher Code</label>
                            <input type="text" id="code" name="code" required placeholder="e.g. HELLO2025">
                        </div>
                        <div class="form-group">
                            <label for="description">Description</label>
                            <textarea id="description" name="description" rows="4" placeholder="Briefly describe what this voucher is for."></textarea>
                        </div>
                    </div>

                    <div class="widget-box">
                        <h5><i class="fa fa-percent"></i> Discount Rules</h5>
                        <div class="form-grid">
                            <div class="form-group">
                                <label for="discountPercentage">Discount Percentage (%)</label>
                                <input type="number" id="discountPercentage" name="discountPercentage" step="0.01" min="0" max="100" placeholder="e.g. 10.5">
                            </div>
                            <div class="form-group">
                                <label for="maxReducing">Max Discount Amount (đ)</label>
                                <input type="number" id="maxReducing" name="maxReducing" step="1000" min="0" placeholder="e.g. 50000">
                            </div>
                            <div class="form-group full-width">
                                <label for="minOrderValue">Minimum Order Value (đ)</label>
                                <input type="number" id="minOrderValue" name="minOrderValue" step="1000" min="0" placeholder="e.g. 200000">
                            </div>
                        </div>
                    </div>
                    <div class="widget-box">
                        <h5><i class="fa fa-tasks"></i> Availability & Limits</h5>
                        <div class="form-grid">
                            <div class="form-group">
                                <label for="quantity">Quantity</label>
                                <input type="number" id="quantity" name="quantity" min="1" placeholder="e.g. 100">
                            </div>
                            <div class="form-group">
                                <label for="expiryDate">Expiry Date</label>
                                <input type="date" id="expiryDate" name="expiryDate">
                            </div>
                            <div class="form-group full-width">
                                <label for="maxUsagePerUser">Max Usage Per User</label>
                                <input type="number" id="maxUsagePerUser" name="maxUsagePerUser" min="1" placeholder="e.g. 1">
                            </div>
                        </div>
                    </div>
                </div>

                <div class="action-column">
                    <div class="widget-box">
                        <h5><i class="fa fa-cog"></i> Actions</h5>
                        <div class="form-group">
                            <label for="isActive">Status</label>
                            <label class="toggle-switch">
                                <input type="checkbox" id="isActive" name="isActive" value="true" checked>
                                <span class="slider"></span>
                            </label>
                        </div>
                        <button type="submit" class="btn btn-primary"><i class="fa fa-save"></i> Save Voucher</button>
                        <a href="${pageContext.request.contextPath}/managevouchers" class="btn btn-secondary"><i class="fa fa-times"></i> Cancel</a>
                    </div>
                </div>
            </div>
        </form>
    </div>
</main>
<jsp:include page="/components/footer/footer.jsp"/>
</body>
</html>