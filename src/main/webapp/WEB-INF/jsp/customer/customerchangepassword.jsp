<%-- 
    Document   : customerchangepassword
    Created on : 21 Oct 2025, 00:36:11
    Author     : Do Ho Gia Huy - CE191293
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@include file="/components/header/header.jsp" %>

<style>
    body {
        background-color: #f8f9fa;
        font-family: "Poppins", sans-serif;
    }

    /* Hiệu ứng fade */
    .fade-in {
        animation: fadeInUp 0.8s ease-in-out;
    }

    @keyframes fadeInUp {
        from {
            opacity: 0;
            transform: translateY(40px);
        }
        to {
            opacity: 1;
            transform: translateY(0);
        }
    }

    /* Khung form */
    .form-container {
        background: #fff;
        border-radius: 20px;
        box-shadow: 0 8px 30px rgba(0, 0, 0, 0.1);
        padding: 50px;
        margin-top: 30px;
        width: 100%;
        max-width: 700px;
        transition: all 0.3s ease;
    }

    .form-container:hover {
        transform: translateY(-6px);
        box-shadow: 0 12px 35px rgba(0, 0, 0, 0.12);
    }

    h2 {
        color: #dc3545;
        font-weight: 700;
        font-size: 28px;
        margin-bottom: 30px;
    }

    .form-label {
        font-weight: 600;
        color: #555;
        font-size: 15px;
    }

    .input-group {
        position: relative;
    }

    .form-control {
        border: 2px solid #ddd;
        border-radius: 10px;
        padding: 12px 16px;
        font-size: 15px;
        transition: all 0.3s ease;
    }

    .form-control:focus {
        border-color: #dc3545;
        box-shadow: 0 0 8px rgba(220, 53, 69, 0.3);
        transform: scale(1.02);
    }

    .toggle-password {
        position: absolute;
        right: 15px;
        top: 50%;
        transform: translateY(-50%);
        border: none;
        background: none;
        cursor: pointer;
        color: #888;
    }

    .toggle-password:hover {
        color: #dc3545;
    }

    .btn-primary {
        background-color: #dc3545;
        border: none;
        font-weight: 600;
        padding: 12px 20px;
        border-radius: 10px;
        transition: all 0.3s ease;
    }

    .btn-primary:hover {
        background-color: #bb2d3b;
        transform: scale(1.05);
    }

    @media (max-width: 768px) {
        .form-container {
            padding: 35px;
            max-width: 90%;
        }
    }
</style>

<div id="changePassForm" class="container d-flex justify-content-center align-items-center fade-in" style="min-height: 60vh;">
    <div class="form-container text-center">
        <h2>Change Password</h2>

        <form action="${pageContext.request.contextPath}/profilecustomer" method="post">
            <input type="hidden" name="action" value="changepassword">
            <!-- Current Password -->
            <div class="mb-4 text-start">
                <label for="currentPassword" class="form-label">Current Password</label>
                <div class="input-group">
                    <input type="password"
                           class="form-control"
                           id="currentPassword"
                           name="currentPassword"
                           placeholder=" "
                           title="6-20 characters, include uppercase, lowercase, number, special character (@#$%^&+=!)"
                           required>
                    <button type="button" class="toggle-password" onclick="togglePassword('currentPassword', this)">
                        <i class="bi bi-eye-slash"></i>
                    </button>
                </div>
            </div>

            <!-- New Password -->
            <div class="mb-4 text-start">
                <label for="newPassword" class="form-label">New Password</label>
                <div class="input-group">
                    <input type="password"
                           class="form-control"
                           id="newPassword"
                           name="newPassword"
                           placeholder=" "
                           title="6-20 characters, include uppercase, lowercase, number, special character (@#$%^&+=!)"
                           required>
                    <button type="button" class="toggle-password" onclick="togglePassword('newPassword', this)">
                        <i class="bi bi-eye-slash"></i>
                    </button>
                </div>
            </div>

            <!-- Confirm New Password -->
            <div class="mb-4 text-start">
                <label for="confirmPassword" class="form-label">Confirm New Password</label>
                <div class="input-group">
                    <input type="password"
                           class="form-control"
                           id="confirmPassword"
                           name="confirmPassword"
                           placeholder=" "
                           title="Must match the password"
                           required>
                    <button type="button" class="toggle-password" onclick="togglePassword('confirmPassword', this)">
                        <i class="bi bi-eye-slash"></i>
                    </button>
                </div>
            </div>

            <div class="text-center mt-4">
                <button type="submit" class="btn btn-primary w-100 py-3 fw-semibold">Change Password</button>
            </div>
        </form>
    </div>
</div>
            
<!-- Script toggle password -->
<script>
    // PHẦN HIỆN POPUP TRƯỚC KHI SUBMIT
    document.getElementById('changePassForm').addEventListener('submit', function(e){
    e.preventDefault(); // chặn submit form ngay lập tức

    // Gọi popup
    showPopup('Confirm', 'Are you sure you want to change your password?', function(confirmed){
        if(confirmed){
            e.target.submit(); // submit nếu Yes
        }
        // Nếu No thì không làm gì
    });
});
//
    function togglePassword(inputId, btn) {
        const input = document.getElementById(inputId);
        const icon = btn.querySelector("i");

        if (input.type === "password") {
            input.type = "text";
            icon.classList.remove("bi-eye-slash");
            icon.classList.add("bi-eye");
        } else {
            input.type = "password";
            icon.classList.remove("bi-eye");
            icon.classList.add("bi-eye-slash");
        }
    }
</script>
<%@include file="/components/message/toastMessage.jsp" %>
<%@ include file="/components/message/popup.jsp" %>
<%@include file="/components/footer/footer.jsp" %>

