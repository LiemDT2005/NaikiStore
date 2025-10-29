<%-- 
    Document   : forgotpassword
    Author     : Do Ho Gia Huy - CE191293
--%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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

        .input-group button {
            border-radius: 0 8px 8px 0;
        }

        .input-group input {
            border-radius: 8px 0 0 8px;
        }

        .disabled-btn {
            background-color: #ccc !important;
            border: none;
            pointer-events: none;
        }

        /* Style cho toggle password button cho OTP */
        .input-group-otp {
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

        .input-group-otp .form-control {
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
                    <h1 class="fw-bold mb-4">Forgot Password</h1>

                    <!-- Form -->
                    <form id="otpForm" action="${pageContext.request.contextPath}/forgotpassword" method="post">
                        <input type="hidden" id="actionField" name="action" value="verifyOtp">

                        <div class="mb-4 position-relative">
                            <label for="email" class="form-label">Email</label>
                            <div class="input-group">
                                <input type="email" class="form-control" id="email" name="email"
                                       value="${sessionScope.email != null ? sessionScope.email : ''}"
                                       placeholder=" " required
                                       ${sessionScope.otp != null ? 'readonly' : ''}>
                                <button type="button" id="sendBtn"
                                        class="btn btn-danger ${sessionScope.otp != null ? 'disabled-btn' : ''}">
                                    ${sessionScope.otp != null ? 'Sent' : 'Send'}
                                </button>
                            </div>
                        </div>

                        <div class="mb-4 position-relative">
                            <label for="otp" class="form-label">OTP Code</label>
                            <div class="input-group-otp">
                                <input type="password" class="form-control" id="otp" name="otp"
                                       placeholder=" "
                                       ${sessionScope.otp != null ? '' : 'disabled'} required>
                                <button type="button" class="toggle-password" onclick="togglePassword('otp', this)"
                                        ${sessionScope.otp != null ? '' : 'disabled'}>
                                    <i class="bi bi-eye-slash"></i>
                                </button>
                            </div>
                        </div>

                        <button type="submit" id="continueBtn" class="btn btn-danger w-100"
                                ${sessionScope.otp != null ? '' : 'disabled'}>
                            Continue
                        </button>
                    </form>
                </div>
            </div>
        </div>
    </div>

<%@include file="/components/message/toastMessage.jsp" %>

    <script>
        // Toggle password function
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

        $(document).ready(function () {
            const sendBtn = $('#sendBtn');
            const form = $('#otpForm');
            const actionField = $('#actionField');
            const emailInput = $('#email');
            const otpInput = $('#otp');
            const continueBtn = $('#continueBtn');

            // 📨 Gửi OTP (submit với action=sendOtp)
            sendBtn.click(function () {
                if (sendBtn.hasClass('disabled-btn')) return;

                const email = emailInput.val().trim();
                if (!email) {
                    toastr.error('Please enter your email first.', 'Error', { timeOut: 3000, progressBar: true, closeButton: true });
                    return;
                }

                actionField.val('sendOtp');
                form.submit(); // Gửi form tới servlet để xử lý sendOtp
            });

            //Bật nút Continue khi có dữ liệu
            $('#email, #otp').on('input', function () {
                const emailFilled = emailInput.val().trim() !== '';
                const otpFilled = otpInput.val().trim() !== '';
                continueBtn.prop('disabled', !(emailFilled && otpFilled));
            });
        });
    </script>
</body>
</html>