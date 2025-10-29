/* 
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/JavaScript.js to edit this template
 */
// Check fullname
function validateFullname() {
    const fullname = document.getElementById("fullname");
    const error = fullname.nextElementSibling;
    const value = fullname.value.trim();

    if (!/^[A-Za-zÀ-ỹ\s]{2,50}$/.test(value)) {
        error.innerText = "Full name must be 2-50 (letters) and cannot be empty.";
        fullname.classList.add("is-invalid");
        return false;
    } else {
        error.innerText = "";
        fullname.classList.remove("is-invalid");
        return true;
    }
}

// Check phone
function validatePhone() {
    const phone = document.getElementById("phone");
    const error = phone.nextElementSibling;
    const value = phone.value.trim();

    if (!/^(((03)[2-9])|((05)[689])|((07)[06-9])|((08)[^07])|((09)[^5]))[0-9]{7}$/.test(value)) {
        error.innerText = "Input must follow Vietnamese phone number.";
        phone.classList.add("is-invalid");
        return false;
    } else {
        error.innerText = "";
        phone.classList.remove("is-invalid");
        return true;
    }
}

// Check address
function validateAddress() {
    const address = document.getElementById("address");
    const error = address.nextElementSibling;
    const value = address.value.trim();

    const regex = /^(?=[a-zA-ZÀ-ỹ0-9])(?:(?![,/.\-]{2})[a-zA-ZÀ-ỹ0-9,./-]+\s[a-zA-ZÀ-ỹ0-9\s,./-]+)$/;

    if (!regex.test(value)) {
        error.innerText = "Address must be at least 2 word, cannot start with special characters, and no double special symbols.";
        address.classList.add("is-invalid");
        return false;
    } else {
        error.innerText = "";
        address.classList.remove("is-invalid");
        return true;
    }
}

// Check toàn bộ khi submit
function validateForm() {
    const validName = validateFullname();
    const validPhone = validatePhone();
    const validAddress = validateAddress();

    return validName && validPhone && validAddress;
}

// Thêm sự kiện cho từng ô
document.getElementById("fullname").addEventListener("input", validateFullname);
document.getElementById("fullname").addEventListener("blur", validateFullname);

document.getElementById("phone").addEventListener("input", validatePhone);
document.getElementById("phone").addEventListener("blur", validatePhone);

document.getElementById("address").addEventListener("input", validateAddress);
document.getElementById("address").addEventListener("blur", validateAddress);
