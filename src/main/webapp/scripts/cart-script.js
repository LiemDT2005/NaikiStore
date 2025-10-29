/* 
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/JavaScript.js to edit this template
 */


document.addEventListener("DOMContentLoaded", function () {
    const formatter = new Intl.NumberFormat('vi-VN');

    document.querySelectorAll(".cart-item").forEach(item => {
        const cartId = item.dataset.cartId;
        const btns = item.querySelectorAll(".btn-change");
        const qtyInput = item.querySelector(".item-qty");
        const totalEl = item.querySelector(".item-total");

        btns.forEach(btn => {
            btn.addEventListener("click", () => {
                const action = btn.dataset.action;
                let qty = parseInt(qtyInput.value);
                if (action === "increase") qty++;
                if (action === "decrease" && qty > 1) qty--;

                fetch(contextPath + "/cart", { // dùng biến contextPath toàn cục
                    method: "POST",
                    headers: {"Content-Type": "application/x-www-form-urlencoded"},
                    body: new URLSearchParams({
                        cart: "edit",
                        action: "updateQuantity",
                        cartId: cartId,
                        quantity: qty
                    })
                })
                .then(res => res.json())
                .then(data => {
                    qtyInput.value = data.newQuantity;
                    totalEl.textContent = formatter.format(data.itemTotal) + "đ";
                    document.getElementById("subtotal").textContent = formatter.format(data.total) + "đ";
                    document.getElementById("grandtotal").textContent = formatter.format(data.total) + "đ";
                })
                .catch(err => console.error("Error updating cart:", err));
            });
        });
    });
});
