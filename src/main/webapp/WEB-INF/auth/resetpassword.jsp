<%-- 
    Document   : resetpassword
    Author     : Do Ho Gia Huy - CE191293
--%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html" pageEncoding="UTF-8" %>
<%
    Boolean verified = (Boolean) session.getAttribute("otpVerified");
    String email = (String) session.getAttribute("email");
    if (verified == null || !verified || email == null) {
        response.sendRedirect(request.getContextPath() + "/views/error.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html>

    <head>
        <meta charset="UTF-8">
        <title>Naiki Store - Reset Password</title>
        <link rel="icon" href="${pageContext.request.contextPath}/assets/img/Favicon.png" type="image/x-icon">

        <!-- Bootstrap + Icons -->
        <link rel="stylesheet" href="${pageContext.request.contextPath}/styles/bootstrap.min.css">
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css">
        <link href="//cdnjs.cloudflare.com/ajax/libs/toastr.js/latest/css/toastr.min.css" rel="stylesheet" />

        <style>
            body {
                background-color: #f8f9fa;
            }

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

            .form-control {
                border: 2px solid #ddd;
                border-radius: 8px;
                padding: 10px 14px;
                transition: all 0.3s ease;
            }

            .form-control:focus {
                border-color: #dc3545;
                box-shadow: 0 0 6px rgba(220, 53, 69, 0.3);
                transform: scale(1.02);
            }

            label.form-label {
                font-weight: 500;
                color: #555;
            }

            .shadow {
                transition: transform 0.3s ease, box-shadow 0.3s ease;
            }

            .shadow:hover {
                transform: translateY(-5px);
                box-shadow: 0 6px 20px rgba(0, 0, 0, 0.1);
            }

            input[type="password"]::-ms-reveal,
            input[type="password"]::-ms-clear {
                display: none;
            }

            input[type="password"]::-webkit-credentials-auto-fill-button,
            input[type="password"]::-webkit-textfield-decoration-container,
            input[type="password"]::-webkit-clear-button,
            input[type="password"]::-webkit-inner-spin-button,
            input[type="password"]::-webkit-contacts-auto-fill-button {
                display: none !important;
                visibility: hidden;
            }

            /* Style cho toggle password button */
            .input-group {
                position: relative;
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
                z-index: 10;
            }

            .toggle-password:hover {
                color: #dc3545;
            }

            .input-group .form-control {
                padding-right: 45px;
            }
        </style>
    </head>

    <body>
        <div class="container my-5 d-flex justify-content-center align-items-center min-vh-100 fade-in">
            <div class="w-100" style="max-width:1200px;">
                <div class="row shadow rounded overflow-hidden">

                    <!-- Left Image Panel -->
                    <div class="col-lg-6 col-md-6 p-0">
                        <img src="${pageContext.request.contextPath}/assets/img/login/login.png"
                             class="img-fluid h-100 w-100" style="object-fit: cover;" alt="Reset Password Image">
                    </div>

                    <!-- Right Form Panel -->
                    <div class="col-lg-6 col-md-6 bg-white p-5">
                        <h1 class="fw-bold mb-4">Reset Password</h1>

                        <!-- Form -->
                        <form id="resetForm" action="${pageContext.request.contextPath}/resetpassword" method="post">
                            <div class="mb-4 position-relative">
                                <label for="newPassword" class="form-label">New Password</label>
                                <div class="input-group">
                                    <input type="password" class="form-control" id="newPassword" name="newPassword"
                                           title="6-20 characters, include uppercase, lowercase, number, special character (@#$%^&+=!)"
                                           placeholder=" " required>
                                    <button type="button" class="toggle-password" onclick="togglePassword('newPassword', this)">
                                        <i class="bi bi-eye-slash"></i>
                                    </button>
                                </div>
                            </div>

                            <div class="mb-4 position-relative">
                                <label for="confirmPassword" class="form-label">Confirm Password</label>
                                <div class="input-group">
                                    <input type="password" class="form-control" id="confirmPassword" name="confirmPassword"
                                           title="Must match the password"
                                           placeholder=" " required>
                                    <button type="button" class="toggle-password" onclick="togglePassword('confirmPassword', this)">
                                        <i class="bi bi-eye-slash"></i>
                                    </button>
                                </div>
                            </div>

                            <button type="submit" id="resetBtn" class="btn btn-danger w-100">
                                Update Password
                            </button>
                        </form>
                    </div>
                </div>
            </div>
        </div>

        <!-- Script toggle password -->
        <script>
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
    </body>
</html>