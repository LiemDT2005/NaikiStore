<%-- 
    Document   : dashboard
    Created on : Oct 11, 2025, 9:09:01 AM
    Author     : PhucTDMCE190744
--%>

<!-- Sidebar -->
<div class="sidebar" id="sidebar">
    <h4 class="text-white mb-4">Naiki Admin</h4>
    <a href="${pageContext.request.contextPath}/manager/product/view"><i class="bi bi-box"></i> Products Management</a>
    <a href="/adminOrder"><i class="bi bi-card-checklist"></i> Inventory Management</a>
    <a href="/listcustomers"><i class="bi bi-people"></i> Order Management</a>
    <a href="/vouchers"><i class="bi bi-ticket"></i> Customer Management</a>
    <a href="/ChatHistory"><i class="bi bi-journal-text"></i> Voucher Management</a>
    <a href="${pageContext.request.contextPath}/manager/category/view"><i class="bi bi-arrow-counterclockwise"></i> Category Management</a>
</div>

<!-- Main Content -->
<div class="main-content dashboard-header mb-5" id="mainContent">
    <div class="d-flex justify-content-between align-items-center">
        <div class="dashboard-left-layout d-flex justify-content-between align-items-center">
            <button class="btn btn-dark ms-4 me-4" id="toggleSidebar">
                <i class="bi bi-list"></i>
            </button>
            <a href="${pageContext.request.contextPath}/manager/dashboard" class="d-flex align-items-center">
                <img src="${pageContext.request.contextPath}/assets/img/HeaderLogo.png" alt="Logo"
                     style="height: 120px;">
            </a>
        </div>

        <div class="dashboard-right-layout">
            <h5 class="me-4">Hi, Admin</h5>
        </div>
    </div>
</div>


<!-- Scripts -->
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>

<script>
    document.getElementById("toggleSidebar").addEventListener("click", function () {
        const sidebar = document.getElementById("sidebar");
        const mainContent = document.getElementById("mainContent");
        const contentArea = document.getElementById("content-area");
        sidebar.classList.toggle("collapsed");
        mainContent.classList.toggle("full-width");
        contentArea.classList.toggle("full-width");
    });
</script>
