<%-- 
    Document   : customerprofile
    Created on : 20 Oct 2025, 05:31:24
    Author     : Do Ho Gia Huy - CE191293
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@include file="/components/header/header.jsp" %>

<style>
    body {
        background-color: #f8f9fa;
        font-family: "Poppins", sans-serif;
    }

    /* Hiệu ứng fade giống login */
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

    /* Form container (áp dụng chung cho cả profile & change password) */
    .form-container {
        background: #fff;
        border-radius: 20px;
        box-shadow: 0 8px 30px rgba(0, 0, 0, 0.1);
        padding: 50px;
        width: 100%;
        max-width: 700px;
        transition: all 0.3s ease;
    }

    .form-container:hover {
        transform: translateY(-6px);
        box-shadow: 0 12px 35px rgba(0, 0, 0, 0.12);
    }

    .form-label {
        font-weight: 600;
        color: #555;
        font-size: 15px;
    }

    .form-control, .form-select {
        border: 2px solid #ddd;
        border-radius: 10px;
        padding: 12px 16px;
        font-size: 15px;
        transition: all 0.3s ease;
    }

    .form-control:focus, .form-select:focus {
        border-color: #dc3545;
        box-shadow: 0 0 8px rgba(220, 53, 69, 0.3);
        transform: scale(1.02);
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

    .btn-outline-primary {
        color: #dc3545;
        border: 2px solid #dc3545;
        font-weight: 600;
        padding: 12px 20px;
        border-radius: 10px;
        transition: all 0.3s ease;
    }

    .btn-outline-primary:hover {
        background-color: #dc3545;
        color: #fff;
        transform: scale(1.05);
    }

    .btn-secondary {
        font-weight: 600;
        border-radius: 10px;
        padding: 12px 20px;
    }

    /* Avatar hover & overlay */
    #avatarImage {
        transition: all 0.3s ease;
    }

    #avatarImage:hover {
        transform: scale(1.07);
        box-shadow: 0 0 15px rgba(220, 53, 69, 0.4);
    }

    #avatarOverlay {
        opacity: 0;
        transition: opacity 0.25s ease;
    }

    .avatar-editing:hover #avatarOverlay {
        opacity: 1;
    }

    .profile-title {
        font-weight: 700;
        color: #dc3545;
        font-size: 26px;
        margin-bottom: 25px;
    }

    /* Responsive */
    @media (max-width: 768px) {
        .form-container {
            padding: 30px;
            max-width: 90%;
        }
    }
</style>

<div class="d-flex justify-content-center align-items-center my-5">
    <div class="form-container fade-in text-center">
        <h3 class="profile-title mb-4">My Profile</h3>

        <form id="changeProfileForm" action="${pageContext.request.contextPath}/profilecustomer" method="post" enctype="multipart/form-data">
            <input type="hidden" name="action" value="profile">
            <!-- Avatar -->
            <div class="mb-4 position-relative d-inline-block avatar-editing">
                <label for="avatarInput" class="position-relative">
                    <c:choose>
                        <c:when test="${fn:startsWith(user.avatar, 'http')}">
                            <img id="avatarImage" src="${user.avatar}" class="rounded-circle border border-2"
                                 style="width: 120px; height: 120px; object-fit: cover; cursor: pointer;">
                        </c:when>
                        <c:otherwise>
                            <img id="avatarImage" src="${pageContext.request.contextPath}/assets/img/${user.avatar}" class="rounded-circle border border-2"
                                 style="width: 120px; height: 120px; object-fit: cover; cursor: pointer;">
                        </c:otherwise>
                    </c:choose>
                    <div id="avatarOverlay" class="position-absolute top-50 start-50 translate-middle bg-dark bg-opacity-50 rounded-circle d-flex align-items-center justify-content-center"
                         style="width: 120px; height: 120px;">
                        <i class="bi bi-camera text-white fs-4"></i>
                    </div>
                </label>
                <input type="file" id="avatarInput" name="avatar" class="d-none" accept="image/*">
            </div>

            <!-- Full Name -->
            <div class="mb-3 text-start">
                <label class="form-label">Full Name</label>
                <input type="text" name="fullName" value="${user.customerName}" 
                       title="Letters and spaces only (supports Vietnamese)."
                       class="form-control" disabled required>
            </div>

            <!-- Email -->
            <div class="mb-3 text-start">
                <label class="form-label">Email</label>
                <input type="email" name="email" value="${user.email}" class="form-control" disabled>
                <small class="text-muted">The email has been set and cannot be changed.</small>
            </div>

            <!-- Phone -->
            <div class="mb-3 text-start">
                <label class="form-label">Phone</label>
                <input type="tel" name="phone" value="${user.phone}" class="form-control" 
                       title="Phone number must start with 0 and be 10 digits, valid Vietnamese mobile"
                       disabled required>
            </div>

            <!-- Address -->
            <div class="mb-3 text-start">
                <label class="form-label">Address</label>
                <input type="text" name="address" value="${user.address}" class="form-control"
                       title="Must contain at least one letter; letters, numbers, spaces, comma, dash, slash allowed"
                       disabled required>
            </div>

            <!-- Gender -->
            <div class="mb-3 text-start">
                <label class="form-label">Gender</label>
                <select name="gender" class="form-select" disabled>
                    <option value="MALE" ${user.gender eq 'MALE' ? 'selected' : ''}>Male</option>
                    <option value="FEMALE" ${user.gender eq 'FEMALE' ? 'selected' : ''}>Female</option>
                    <option value="OTHER" ${user.gender eq 'OTHER' ? 'selected' : ''}>Other</option>
                </select>
            </div>

            <!-- Buttons -->
            <div class="d-flex justify-content-center gap-2">
                <button type="button" id="editBtn" class="btn btn-outline-primary px-4">Edit</button>
                <button type="button" id="cancelBtn" class="btn btn-secondary d-none px-4">Cancel</button>
                <button type="submit" id="saveBtn" class="btn btn-primary d-none px-4">Save</button>
            </div>
        </form>
    </div>
</div>

<!-- Avatar Modal -->
<div class="modal fade" id="avatarModal" tabindex="-1" aria-labelledby="avatarModalLabel" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered">
        <div class="modal-content bg-transparent border-0">
            <div class="modal-body p-0 text-center">
                <img id="modalAvatarImage" src="" class="img-fluid rounded shadow" style="max-height: 80vh;" />
            </div>
        </div>
    </div>
</div>

<!-- Script -->
<script>
    const editBtn = document.getElementById("editBtn");
    const saveBtn = document.getElementById("saveBtn");
    const cancelBtn = document.getElementById("cancelBtn");
    const formControls = document.querySelectorAll("form input, form select");
    const avatarInput = document.getElementById("avatarInput");
    const avatarOverlay = document.getElementById("avatarOverlay");
    const avatarLabel = document.querySelector("label[for='avatarInput']");
    const avatarImage = document.getElementById("avatarImage");
    const modalAvatarImage = document.getElementById("modalAvatarImage");

    // 🔹 Lưu giá trị ban đầu an toàn hơn
    const originalValues = {};
    formControls.forEach(ctrl => {
        if (ctrl.name && ctrl.type !== "file") {
            originalValues[ctrl.name] = ctrl.value;
        }
    });
    const originalAvatar = avatarImage.src;

    const lockedFields = ["email"];
    let isEditing = false;

    document.querySelector('form').addEventListener('submit', function(e) {
        // Enable TẤT CẢ các field trước khi submit (trừ email)
        formControls.forEach(ctrl => {
            if (ctrl.name !== 'email') {
                ctrl.disabled = false;
            }
        });
    });
    
    avatarInput.disabled = true;

    // 🔹 Khi bấm Edit
    editBtn.addEventListener("click", () => {
        isEditing = true;
        formControls.forEach(ctrl => {
            if (!lockedFields.includes(ctrl.name)) {
                ctrl.disabled = false;
            }
        });
        avatarInput.disabled = false;
        editBtn.classList.add("d-none");
        saveBtn.classList.remove("d-none");
        cancelBtn.classList.remove("d-none");

        avatarLabel.addEventListener("mouseenter", showOverlay);
        avatarLabel.addEventListener("mouseleave", hideOverlay);
    });

    // 🔹 Khi bấm Cancel
    cancelBtn.addEventListener("click", () => {
        isEditing = false;
        formControls.forEach(ctrl => {
            if (ctrl.name && ctrl.type !== "file") {
                ctrl.value = originalValues[ctrl.name];
            }
            if (!lockedFields.includes(ctrl.name)) {
                ctrl.disabled = true;
            }
        });
        avatarInput.disabled = true;
        avatarInput.value = ""; // Clear file input
        avatarImage.src = originalAvatar;
        avatarOverlay.style.opacity = "0";
        editBtn.classList.remove("d-none");
        saveBtn.classList.add("d-none");
        cancelBtn.classList.add("d-none");

        avatarLabel.removeEventListener("mouseenter", showOverlay);
        avatarLabel.removeEventListener("mouseleave", hideOverlay);
    });

    // Hiệu ứng hover camera
    function showOverlay() {
        if (isEditing)
            avatarOverlay.style.opacity = "1";
    }

    function hideOverlay() {
        if (isEditing)
            avatarOverlay.style.opacity = "0";
    }

    // 🔹 Click avatar — xem ảnh lớn nếu không trong chế độ edit
    avatarLabel.addEventListener("click", () => {
        if (!isEditing) {
            modalAvatarImage.src = avatarImage.src;
            const modal = new bootstrap.Modal(document.getElementById("avatarModal"));
            modal.show();
        }
    });

    // 🔹 Thay ảnh avatar khi đang edit
    avatarInput.addEventListener("change", (e) => {
        const file = e.target.files[0];
        if (file) {
            // Validate file size (5MB)
            if (file.size > 5 * 1024 * 1024) {
                toastr.error('File size must be less than 5MB!', 'Error', {timeOut: 3000, progressBar: true, closeButton: true});
                avatarInput.value = "";
                return;
            }
            
            // Validate file type
            const validTypes = ['image/jpeg', 'image/jpg', 'image/png', 'image/gif'];
            if (!validTypes.includes(file.type)) {
                toastr.error('Only image files (JPG, PNG, GIF) are allowed!', 'Error', {timeOut: 3000, progressBar: true, closeButton: true});
                avatarInput.value = "";
                return;
            }

            const reader = new FileReader();
            reader.onload = (e) => {
                avatarImage.src = e.target.result;
            };
            reader.readAsDataURL(file);
        }
    });
    // PHẦN HIỆN POPUP TRƯỚC KHI SUBMIT
    document.getElementById('changeProfileForm').addEventListener('submit', function(e){
    e.preventDefault(); // chặn submit form ngay lập tức

    // Gọi popup
    showPopup('Confirm', 'Are you sure you want to change your profile?', function(confirmed){
        if(confirmed){
            e.target.submit(); // submit nếu Yes
        }
        // Nếu No thì không làm gì
    });
});
</script>
<%@include file="/components/message/toastMessage.jsp" %>
<%@ include file="/components/message/popup.jsp" %>
<%@include file="/components/footer/footer.jsp" %>