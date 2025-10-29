<%-- 
    Document   : login
    Created on : 11 Oct 2025
    Author     : Do Ho Gia Huy - CE191293
--%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ page contentType="text/html" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>

    <head>
        <meta charset="UTF-8">
        <title>Naiki Store</title>
        <link rel="icon" href="${pageContext.request.contextPath}/assets/img/Favicon.png" type="image/x-icon">

        <!-- Bootstrap + Icons -->
        <link rel="stylesheet" href="${pageContext.request.contextPath}/styles/bootstrap.min.css">
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">

        <!-- Toastr -->
        <link href="//cdnjs.cloudflare.com/ajax/libs/toastr.js/latest/css/toastr.min.css" rel="stylesheet" />

        <style>
            body {
                background-color: #f8f9fa;
            }

            /* Hiệu ứng fade khi load trang */
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

            /* 🎨 Hiệu ứng focus cho input */
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
                transition: color 0.3s ease;
            }

            .form-control:focus + label,
            .form-control:not(:placeholder-shown) + label {
                color: #dc3545;
            }

            /* Hiệu ứng nổi nhẹ cho khung login */
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
                             class="img-fluid h-100 w-100" style="object-fit: cover;" alt="Login Image">
                    </div>

                    <!-- Right Form Panel -->
                    <div class="col-lg-6 col-md-6 bg-white p-5">
                        <h1 class="fw-bold mb-4">Sign in</h1>

                        <form action="${pageContext.request.contextPath}/login" method="post">
                            <input type="hidden" name="action">

                            <div class="mb-4 position-relative">
                                <label for="username" class="form-label">Email</label>
                                <input type="email" class="form-control" value="${sessionScope.enteredEmail}" id="email"
                                       name="email" placeholder=" " required>
                            </div>

                            <div class="mb-4">
                                <label for="password" class="form-label">Password</label>
                                <div class="input-group">
                                    <input type="password" class="form-control" id="password" name="password"
                                           placeholder=" " required>
                                    <button type="button" class="toggle-password" onclick="togglePassword('password', this)">
                                        <i class="bi bi-eye-slash"></i>
                                    </button>
                                </div>
                            </div>

                            <div class="mb-3 form-check">
                                <input type="checkbox" class="form-check-input" id="rememberMe" name="rememberMe">
                                <label class="form-check-label" for="rememberMe">Remember me</label>
                            </div>

                            <button type="submit" class="btn btn-danger w-100">Sign In</button>
                        </form>

                        <div class="mt-3">
                            <div>
                                Don't have an account?
                                <a href="${pageContext.request.contextPath}/register">Sign up</a>
                            </div>
                            <div>
                                <a href="${pageContext.request.contextPath}/forgotpassword">Forgot password?</a>
                            </div>
                        </div>

                        <div class="my-3 text-center">
                            <span class="d-inline-block w-25 border-bottom"></span>
                            <span class="mx-2">Or connect using</span>
                            <span class="d-inline-block w-25 border-bottom"></span>
                        </div>

                        <div class="d-flex justify-content-center">
                            <a href=https://accounts.google.com/o/oauth2/auth?scope=email%20profile&redirect_uri=http://localhost:8080/NaikiStore/loginwithgoogle&response_type=code&client_id=837056843506-bn4lf315v84bipb17c3anmtb41kj7564.apps.googleusercontent.com&approval_prompt=force>
                                <img src="${pageContext.request.contextPath}/assets/img/login/google_icon.png"
                                     class="me-3" style="width: 40px;" alt="Google Login">
                            </a>

                            <a href="https://www.facebook.com/v19.0/dialog/oauth?client_id=4128242707421221&redirect_uri=http://localhost:8080/NaikiStore/loginwithfacebook&scope=email,public_profile&response_type=code&state=abc123">
                                <img src="${pageContext.request.contextPath}/assets/img/login/facebook_icon.png"
                                     style="width: 40px;" alt="Facebook Login">
                            </a>
                        </div>
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