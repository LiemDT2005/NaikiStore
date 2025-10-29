<%-- 
    Document   : popup
    Created on : 22 Oct 2025, 07:48:53
    Author     : Do Ho Gia Huy - CE191293
--%>

<%@ page contentType="text/html" pageEncoding="UTF-8" %>

<style>
    * {
        margin: 0;
        padding: 0;
        box-sizing: border-box;
    }

    .popup-overlay {
        position: fixed;
        top: 0;
        left: 0;
        width: 100%;
        height: 100%;
        background: rgba(0, 0, 0, 0.5);
        display: flex;
        justify-content: center;
        align-items: center;
        z-index: 9999;
        padding: 20px;
        animation: fadeIn 0.2s ease-out;
    }

    @keyframes fadeIn {
        from { opacity: 0; }
        to { opacity: 1; }
    }

    .popup-container {
        background: white;
        border-radius: 32px;
        box-shadow: 0 20px 60px rgba(0, 0, 0, 0.15);
        max-width: 520px;
        width: 100%;
        padding: 48px 40px 40px;
        position: relative;
        animation: slideUp 0.3s ease-out;
    }

    @keyframes slideUp {
        from { transform: translateY(30px); opacity: 0; }
        to { transform: translateY(0); opacity: 1; }
    }

    .close-btn {
        position: absolute;
        top: 24px;
        right: 24px;
        width: 32px;
        height: 32px;
        background: none;
        border: none;
        cursor: pointer;
        display: flex;
        align-items: center;
        justify-content: center;
        border-radius: 8px;
        transition: background 0.2s;
    }

    .close-btn:hover { background: #f3f4f6; }

    .close-btn::before,
    .close-btn::after {
        content: '';
        position: absolute;
        width: 18px;
        height: 2px;
        background: #6b7280;
        border-radius: 2px;
    }

    .close-btn::before { transform: rotate(45deg); }
    .close-btn::after { transform: rotate(-45deg); }

    .icon-container {
        width: 80px;
        height: 80px;
        margin: 0 auto 28px;
        background: linear-gradient(135deg, #fee2e2 0%, #fecaca 100%);
        border-radius: 50%;
        display: flex;
        align-items: center;
        justify-content: center;
        position: relative;
    }

    .icon-inner {
        width: 48px;
        height: 48px;
        background: linear-gradient(135deg, #ef4444 0%, #dc2626 100%);
        border-radius: 12px;
        display: flex;
        align-items: center;
        justify-content: center;
        transform: rotate(45deg);
    }

    .icon-inner::before {
        content: '!';
        color: white;
        font-size: 28px;
        font-weight: bold;
        transform: rotate(-45deg);
    }

    .popup-title {
        font-size: 24px;
        color: #111827;
        font-weight: 700;
        text-align: center;
        margin-bottom: 12px;
    }

    .popup-message {
        font-size: 15px;
        color: #6b7280;
        line-height: 1.6;
        text-align: center;
        margin-bottom: 32px;
    }

    .popup-buttons {
        display: flex;
        gap: 12px;
    }

    /* 🔹 Scoped button styles chỉ cho popup */
    .btn-popup {
        flex: 1;
        padding: 16px 32px;
        border: none;
        border-radius: 16px;
        font-size: 16px;
        font-weight: 600;
        cursor: pointer;
        transition: all 0.2s ease;
        letter-spacing: 0.2px;
    }

    .btn-popup-delete {
        background: linear-gradient(135deg, #ef4444 0%, #dc2626 100%);
        color: white;
        box-shadow: 0 4px 12px rgba(239, 68, 68, 0.3);
    }

    .btn-popup-delete:hover {
        transform: translateY(-2px);
        box-shadow: 0 6px 20px rgba(239, 68, 68, 0.4);
    }

    .btn-popup-delete:active { transform: translateY(0); }

    .btn-popup-cancel {
        background: white;
        color: #374151;
        border: 2px solid #e5e7eb;
    }

    .btn-popup-cancel:hover {
        background: #f9fafb;
        border-color: #d1d5db;
    }

    .btn-popup-cancel:active { background: #f3f4f6; }

    @media (max-width: 480px) {
        .popup-container { padding: 40px 24px 32px; }
        .popup-title { font-size: 22px; }
        .popup-message { font-size: 14px; }
    }
</style>

<div class="popup-overlay" style="display:none;">
    <div class="popup-container">
        <button class="close-btn" onclick="handleNo()"></button>

        <div class="icon-container">
            <div class="icon-inner"></div>
        </div>

        <h2 class="popup-title">Notification</h2>

        <div class="popup-message">Are you sure you want to perform this action?</div>

        <div class="popup-buttons">
            <button class="btn-popup btn-popup-delete" onclick="handleYes()">Yes</button>
            <button class="btn-popup btn-popup-cancel" onclick="handleNo()">No</button>
        </div>
    </div>
</div>

<script>
    let popupCallback = null;

    function showPopup(title, message, callback) {
        const overlay = document.querySelector('.popup-overlay');
        overlay.style.display = 'flex';
        document.body.style.overflow = 'hidden';

        document.querySelector('.popup-title').innerText = title;
        document.querySelector('.popup-message').innerText = message;

        popupCallback = callback;
    }

    function handleYes() {
        document.querySelector('.popup-overlay').style.display = 'none';
        document.body.style.overflow = '';
        if (popupCallback) popupCallback(true);
        popupCallback = null;
    }

    function handleNo() {
        document.querySelector('.popup-overlay').style.display = 'none';
        document.body.style.overflow = '';
        if (popupCallback) popupCallback(false);
        popupCallback = null;
    }

    // ESC để đóng
    document.addEventListener('keydown', function(e) {
        if (e.key === 'Escape') handleNo();
    });

    // Click overlay để đóng
    document.querySelector('.popup-overlay').addEventListener('click', function(e) {
        if (e.target === this) handleNo();
    });
</script>

