<%@ page language="java"
    contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" %>

<%@ page import="com.tap.model.Cart" %>
<%@ page import="com.tap.model.CartItem" %>
<%@ page import="com.tap.model.User" %>
<%@ page import="java.util.Collection" %>

<%
    // Get the session cart
    Cart cart = (Cart) session.getAttribute("cart");

    if (cart == null || cart.isEmpty()) {
        response.sendRedirect(request.getContextPath() + "/cart");
        return;
    }

    // Get logged-in user
    User checkoutUser =
        (User) session.getAttribute("loggedInUser");

    if (checkoutUser == null) {
        response.sendRedirect(
            request.getContextPath() + "/login.jsp"
        );
        return;
    }

    // Use a unique variable name because navbar.jsp is
    // statically included below.
    String checkoutContextPath = request.getContextPath();

    String defaultName = checkoutUser.getUsername() == null
        ? ""
        : checkoutUser.getUsername();

    String defaultPhone = checkoutUser.getPhone() == null
        ? ""
        : checkoutUser.getPhone();

    Collection<CartItem> cartItems = cart.getItems();
    double totalAmount = cart.getTotalAmount();
%>

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">

<title>Checkout | FoodieHub</title>

<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=DM+Sans:wght@400;500;600;700;800&family=Playfair+Display:wght@600;700;800&display=swap"
      rel="stylesheet">

<style>
* {
    margin: 0;
    padding: 0;
    box-sizing: border-box;
}

:root {
    --primary: #ff4b2b;
    --primary-dark: #e93d20;
    --background: #fffaf5;
    --text: #222;
    --muted: #777;
    --border: #eee4dc;
    --white: #fff;
    --green: #17864b;
}

html {
    scroll-behavior: smooth;
}

body {
    font-family: 'DM Sans', sans-serif;
    color: var(--text);
    background:
        radial-gradient(circle at 10% 10%,
            rgba(255,75,43,.10), transparent 28%),
        radial-gradient(circle at 90% 80%,
            rgba(255,193,7,.12), transparent 28%),
        var(--background);
    min-height: 100vh;
}

.checkout-hero {
    text-align: center;
    padding: 55px 20px 35px;
    background: linear-gradient(135deg, #fff0e8, #fffaf5);
}

.hero-label {
    display: inline-block;
    padding: 8px 16px;
    border-radius: 30px;
    background: #ffe0d5;
    color: var(--primary-dark);
    font-size: 12px;
    font-weight: 800;
    letter-spacing: 1px;
    margin-bottom: 18px;
}

.checkout-hero h1 {
    font-family: 'Playfair Display', serif;
    font-size: clamp(32px, 5vw, 48px);
    margin-bottom: 12px;
}

.checkout-hero h1 span {
    color: var(--primary);
}

.checkout-hero p {
    color: var(--muted);
    line-height: 1.7;
}

.checkout-container {
    width: min(1180px, 94%);
    margin: 35px auto 70px;
    display: grid;
    grid-template-columns: minmax(0, 1.55fr) minmax(300px, .85fr);
    gap: 28px;
    align-items: start;
}

.checkout-left,
.checkout-right {
    display: flex;
    flex-direction: column;
    gap: 22px;
}

.panel {
    background: rgba(255,255,255,.96);
    border: 1px solid var(--border);
    border-radius: 20px;
    padding: 27px;
    box-shadow: 0 12px 35px rgba(69, 37, 20, .055);
}

.panel-heading {
    display: flex;
    align-items: center;
    gap: 13px;
    margin-bottom: 23px;
}

.heading-icon {
    width: 45px;
    height: 45px;
    border-radius: 14px;
    background: #fff0e9;
    display: grid;
    place-items: center;
    font-size: 22px;
}

.panel-heading h2 {
    font-size: 19px;
    margin-bottom: 4px;
}

.panel-heading p {
    color: var(--muted);
    font-size: 13px;
}

.form-grid {
    display: grid;
    grid-template-columns: repeat(2, minmax(0, 1fr));
    gap: 18px;
}

.form-group {
    display: flex;
    flex-direction: column;
    gap: 8px;
}

.form-group.full {
    grid-column: 1 / -1;
}

.form-group label {
    font-size: 13px;
    font-weight: 700;
}

.form-group input,
.form-group select,
.form-group textarea {
    width: 100%;
    border: 1px solid #e6ddd6;
    border-radius: 11px;
    padding: 13px 14px;
    font: inherit;
    font-size: 14px;
    color: var(--text);
    background: #fff;
    outline: none;
    transition: border .2s, box-shadow .2s;
}

.form-group textarea {
    min-height: 88px;
    resize: vertical;
}

.form-group input:focus,
.form-group select:focus,
.form-group textarea:focus {
    border-color: var(--primary);
    box-shadow: 0 0 0 3px rgba(255,75,43,.10);
}

.address-types {
    display: flex;
    flex-wrap: wrap;
    gap: 12px;
    margin-top: 20px;
}

.address-type {
    cursor: pointer;
}

.address-type input {
    position: absolute;
    opacity: 0;
    pointer-events: none;
}

.address-type span {
    display: inline-flex;
    align-items: center;
    gap: 8px;
    border: 1px solid var(--border);
    border-radius: 12px;
    padding: 12px 17px;
    font-size: 13px;
    font-weight: 700;
    transition: .2s;
}

.address-type input:checked + span {
    border-color: var(--primary);
    background: #fff0e9;
    color: var(--primary-dark);
}

.address-preview {
    margin-top: 20px;
    padding: 17px;
    background: #fff8f3;
    border: 1px dashed #f0b9a7;
    border-radius: 13px;
}

.preview-title {
    color: var(--primary-dark);
    font-size: 12px;
    font-weight: 800;
    text-transform: uppercase;
    letter-spacing: .7px;
    margin-bottom: 8px;
}

#addressPreview {
    font-size: 13px;
    line-height: 1.7;
    color: #666;
    overflow-wrap: anywhere;
}

.payment-option {
    display: flex;
    align-items: center;
    gap: 14px;
    border: 1px solid var(--border);
    border-radius: 14px;
    padding: 17px;
    margin-top: 12px;
    cursor: pointer;
    transition: .2s;
}

.payment-option:has(input:checked) {
    border-color: var(--primary);
    background: #fff8f4;
}

.payment-option input {
    accent-color: var(--primary);
    width: 17px;
    height: 17px;
}

.payment-icon {
    font-size: 23px;
}

.payment-text {
    flex: 1;
}

.payment-text strong {
    display: block;
    font-size: 14px;
    margin-bottom: 4px;
}

.payment-text small {
    color: var(--muted);
    font-size: 12px;
}

.recommended {
    background: #e3f8eb;
    color: #167746;
    border-radius: 6px;
    padding: 5px 8px;
    font-size: 10px;
    font-weight: 800;
}

.summary-panel {
    position: sticky;
    top: 20px;
}

.summary-heading {
    font-family: 'Playfair Display', serif;
    font-size: 23px;
    margin-bottom: 7px;
}

.summary-subtitle {
    color: var(--muted);
    font-size: 13px;
    margin-bottom: 22px;
}

.summary-items {
    display: flex;
    flex-direction: column;
    gap: 17px;
}

.summary-item {
    display: flex;
    align-items: center;
    gap: 13px;
}

.item-image {
    width: 65px;
    height: 65px;
    flex-shrink: 0;
    border-radius: 12px;
    object-fit: cover;
    background: #fff0e9;
}

.item-details {
    flex: 1;
    min-width: 0;
}

.item-details h3 {
    font-size: 13px;
    line-height: 1.5;
    overflow-wrap: anywhere;
}

.item-details p {
    font-size: 12px;
    color: var(--muted);
    margin-top: 5px;
}

.item-price {
    white-space: nowrap;
    font-size: 13px;
    font-weight: 800;
}

.summary-divider {
    height: 1px;
    background: var(--border);
    margin: 23px 0;
}

.price-row {
    display: flex;
    justify-content: space-between;
    gap: 12px;
    margin: 14px 0;
    font-size: 13px;
}

.price-row span:first-child {
    color: var(--muted);
}

.price-row strong {
    font-weight: 700;
}

.free-delivery {
    color: var(--green);
}

.total-row {
    display: flex;
    align-items: center;
    justify-content: space-between;
    gap: 12px;
}

.total-label {
    font-size: 16px;
    font-weight: 800;
}

.total-amount {
    font-size: 25px;
    font-weight: 800;
    color: var(--primary);
}

.tax-note {
    color: var(--muted);
    font-size: 11px;
    margin-top: 9px;
}

.place-order-btn {
    width: 100%;
    border: none;
    border-radius: 13px;
    background: linear-gradient(135deg, #ff6544, #ff3e21);
    color: white;
    padding: 17px;
    margin-top: 25px;
    font: inherit;
    font-size: 15px;
    font-weight: 800;
    cursor: pointer;
    box-shadow: 0 9px 20px rgba(255,75,43,.2);
    transition: transform .2s, box-shadow .2s;
}

.place-order-btn:hover {
    transform: translateY(-2px);
    box-shadow: 0 13px 26px rgba(255,75,43,.27);
}

.place-order-btn:disabled {
    opacity: .7;
    cursor: wait;
    transform: none;
}

.back-to-cart {
    display: block;
    text-align: center;
    margin-top: 17px;
    color: #555;
    font-size: 13px;
    text-decoration: none;
    font-weight: 700;
}

.back-to-cart:hover {
    color: var(--primary);
}

.secure-note {
    text-align: center;
    color: var(--muted);
    font-size: 12px;
    line-height: 1.7;
    margin-top: 18px;
}

.security-strip {
    display: flex;
    justify-content: center;
    flex-wrap: wrap;
    gap: 15px;
    margin-top: 15px;
    color: #666;
    font-size: 11px;
}

.security-strip span {
    display: inline-flex;
    align-items: center;
    gap: 5px;
}

@media (max-width: 850px) {
    .checkout-container {
        grid-template-columns: 1fr;
    }

    .summary-panel {
        position: static;
    }
}

@media (max-width: 540px) {
    .checkout-hero {
        padding-top: 38px;
    }

    .panel {
        padding: 19px;
        border-radius: 16px;
    }

    .form-grid {
        grid-template-columns: 1fr;
    }

    .form-group.full {
        grid-column: auto;
    }

    .address-type span {
        padding: 10px 12px;
    }

    .checkout-container {
        width: 94%;
        margin-top: 20px;
    }
}
</style>
</head>

<body>

<%@ include file="components/navbar.jsp" %>

<section class="checkout-hero">
    <div class="hero-label">🍽️ ALMOST THERE</div>

    <h1>Complete Your <span>Order</span></h1>

    <p>
        Enter your delivery details and choose your preferred
        payment method.
    </p>
</section>

<form id="checkoutForm"
      action="<%= checkoutContextPath %>/place-order"
      method="post">

    <main class="checkout-container">

        <div class="checkout-left">

            <!-- CONTACT INFORMATION -->
            <section class="panel">

                <div class="panel-heading">
                    <div class="heading-icon">👤</div>

                    <div>
                        <h2>Contact Information</h2>
                        <p>Where can we reach you?</p>
                    </div>
                </div>

                <div class="form-grid">

                    <div class="form-group full">
                        <label for="fullName">Full Name *</label>

                        <input
                            type="text"
                            id="fullName"
                            name="fullName"
                            value="<%= defaultName.replace("&", "&amp;").replace("\"", "&quot;").replace("<", "&lt;").replace(">", "&gt;") %>"
                            placeholder="Enter your full name"
                            autocomplete="name"
                            required>
                    </div>

                    <div class="form-group full">
                        <label for="phone">Mobile Number *</label>

                        <input
                            type="tel"
                            id="phone"
                            name="phone"
                            value="<%= defaultPhone.replace("&", "&amp;").replace("\"", "&quot;").replace("<", "&lt;").replace(">", "&gt;") %>"
                            placeholder="10-digit mobile number"
                            maxlength="10"
                            inputmode="numeric"
                            autocomplete="tel"
                            required>
                    </div>

                </div>
            </section>

            <!-- DELIVERY ADDRESS -->
            <section class="panel">

                <div class="panel-heading">
                    <div class="heading-icon">📍</div>

                    <div>
                        <h2>Delivery Address</h2>
                        <p>Where should we deliver your food?</p>
                    </div>
                </div>

                <div class="form-grid">

                    <div class="form-group full">
                        <label for="addressLine1">
                            House / Building / Street *
                        </label>

                        <input
                            type="text"
                            id="addressLine1"
                            name="addressLine1"
                            placeholder="House number, building, street"
                            autocomplete="address-line1"
                            required>
                    </div>

                    <div class="form-group full">
                        <label for="addressLine2">
                            Area / Locality
                        </label>

                        <input
                            type="text"
                            id="addressLine2"
                            name="addressLine2"
                            placeholder="Area or locality (optional)"
                            autocomplete="address-line2">
                    </div>

                    <div class="form-group full">
                        <label for="landmark">Landmark</label>

                        <input
                            type="text"
                            id="landmark"
                            name="landmark"
                            placeholder="Nearby landmark (optional)">
                    </div>

                    <div class="form-group">
                        <label for="city">City *</label>

                        <input
                            type="text"
                            id="city"
                            name="city"
                            placeholder="e.g. Bengaluru"
                            autocomplete="address-level2"
                            required>
                    </div>

                    <div class="form-group">
                        <label for="state">State *</label>

                        <input
                            type="text"
                            id="state"
                            name="state"
                            placeholder="e.g. Karnataka"
                            autocomplete="address-level1"
                            required>
                    </div>

                    <div class="form-group">
                        <label for="pinCode">PIN Code *</label>

                        <input
                            type="text"
                            id="pinCode"
                            name="pinCode"
                            placeholder="6-digit PIN code"
                            maxlength="6"
                            inputmode="numeric"
                            autocomplete="postal-code"
                            required>
                    </div>

                    <div class="form-group">
                        <label for="country">Country *</label>

                        <input
                            type="text"
                            id="country"
                            name="country"
                            value="India"
                            autocomplete="country-name"
                            required>
                    </div>

                </div>

                <div class="address-types">

                    <label class="address-type">
                        <input
                            type="radio"
                            name="addressType"
                            value="Home"
                            checked>

                        <span>🏠 Home</span>
                    </label>

                    <label class="address-type">
                        <input
                            type="radio"
                            name="addressType"
                            value="Work">

                        <span>💼 Work</span>
                    </label>

                    <label class="address-type">
                        <input
                            type="radio"
                            name="addressType"
                            value="Other">

                        <span>📌 Other</span>
                    </label>

                </div>

                <div class="address-preview">
                    <div class="preview-title">
                        📍 Delivery Address Preview
                    </div>

                    <div id="addressPreview">
                        Your delivery address will appear here.
                    </div>
                </div>

            </section>

            <!-- PAYMENT METHOD -->
            <section class="panel">

                <div class="panel-heading">
                    <div class="heading-icon">💳</div>

                    <div>
                        <h2>Payment Method</h2>
                        <p>Choose how you want to pay.</p>
                    </div>
                </div>

                <label class="payment-option">
                    <input
                        type="radio"
                        name="payment"
                        value="COD"
                        checked>

                    <span class="payment-icon">💵</span>

                    <span class="payment-text">
                        <strong>Cash on Delivery</strong>
                        <small>Pay when your order arrives.</small>
                    </span>

                    <span class="recommended">POPULAR</span>
                </label>

                <label class="payment-option">
                    <input
                        type="radio"
                        name="payment"
                        value="Online Payment">

                    <span class="payment-icon">💳</span>

                    <span class="payment-text">
                        <strong>Online Payment</strong>
                        <small>Online payment requires a configured payment gateway.</small>
                    </span>
                </label>

            </section>

        </div>

        <!-- ORDER SUMMARY -->
        <aside class="checkout-right">

            <section class="panel summary-panel">

                <h2 class="summary-heading">Your Order</h2>

                <p class="summary-subtitle">
                    Review your items before placing your order.
                </p>

                <div class="summary-items">

                    <%
                        if (cartItems != null) {
                            for (CartItem item : cartItems) {
                    %>

                    <div class="summary-item">

                        <img
                            class="item-image"
                            src="<%= item.getImagePath() == null
                                ? ""
                                : item.getImagePath().replace("\"", "&quot;") %>"
                            alt="Food item"
                            onerror="this.style.display='none'">

                        <div class="item-details">
                            <h3>
                                <%= item.getItemName() == null
                                    ? "Food item"
                                    : item.getItemName()
                                        .replace("&", "&amp;")
                                        .replace("<", "&lt;")
                                        .replace(">", "&gt;") %>
                            </h3>

                            <p>
                                ₹<%= String.format(
                                    java.util.Locale.US,
                                    "%.2f",
                                    item.getPrice()
                                ) %>
                                × <%= item.getQuantity() %>
                            </p>
                        </div>

                        <div class="item-price">
                            ₹<%= String.format(
                                java.util.Locale.US,
                                "%.2f",
                                item.getPrice() * item.getQuantity()
                            ) %>
                        </div>

                    </div>

                    <%
                            }
                        }
                    %>

                </div>

                <div class="summary-divider"></div>

                <div class="price-row">
                    <span>Item total</span>

                    <strong>
                        ₹<%= String.format(
                            java.util.Locale.US,
                            "%.2f",
                            totalAmount
                        ) %>
                    </strong>
                </div>

                <div class="price-row">
                    <span>Delivery fee</span>
                    <strong class="free-delivery">FREE</strong>
                </div>

                <div class="price-row">
                    <span>Platform fee</span>
                    <strong>₹0.00</strong>
                </div>

                <div class="summary-divider"></div>

                <div class="total-row">
                    <span class="total-label">Total to Pay</span>

                    <span class="total-amount">
                        ₹<%= String.format(
                            java.util.Locale.US,
                            "%.2f",
                            totalAmount
                        ) %>
                    </span>
                </div>

                <p class="tax-note">
                    Final amount is calculated from your current cart.
                </p>

                <button
                    type="submit"
                    id="placeOrderButton"
                    class="place-order-btn">
                    Place Order &nbsp; →
                </button>

                <a
                    class="back-to-cart"
                    href="<%= checkoutContextPath %>/cart">
                    ← Back to Cart
                </a>

                <p class="secure-note">
                    🔒 Your checkout details are submitted securely
                    to the FoodieHub application.
                </p>

                <div class="security-strip">
                    <span>✓ Verified Order</span>
                    <span>✓ Fresh Food</span>
                    <span>✓ Easy Ordering</span>
                </div>

            </section>

        </aside>

    </main>

</form>

<script>
(function () {
    "use strict";

    const form = document.getElementById("checkoutForm");
    const button = document.getElementById("placeOrderButton");

    const nameInput = document.getElementById("fullName");
    const phoneInput = document.getElementById("phone");
    const addressInput = document.getElementById("addressLine1");
    const areaInput = document.getElementById("addressLine2");
    const landmarkInput = document.getElementById("landmark");
    const cityInput = document.getElementById("city");
    const stateInput = document.getElementById("state");
    const pinInput = document.getElementById("pinCode");
    const countryInput = document.getElementById("country");
    const preview = document.getElementById("addressPreview");

    function escapeHTML(value) {
        return value.replace(/[&<>"']/g, function (character) {
            const entities = {
                "&": "&amp;",
                "<": "&lt;",
                ">": "&gt;",
                '"': "&quot;",
                "'": "&#39;"
            };

            return entities[character];
        });
    }

    function updateAddressPreview() {
        const parts = [
            addressInput.value.trim(),
            areaInput.value.trim(),
            landmarkInput.value.trim(),
            cityInput.value.trim(),
            stateInput.value.trim(),
            pinInput.value.trim(),
            countryInput.value.trim()
        ].filter(Boolean);

        const selectedType = document.querySelector(
            'input[name="addressType"]:checked'
        );

        const addressType = selectedType
            ? selectedType.value
            : "Home";

        if (parts.length === 0) {
            preview.textContent =
                "Your delivery address will appear here.";
            return;
        }

        preview.innerHTML =
            "<strong>" + escapeHTML(addressType) + "</strong><br>" +
            parts.map(escapeHTML).join(", ");
    }

    [
        addressInput,
        areaInput,
        landmarkInput,
        cityInput,
        stateInput,
        pinInput,
        countryInput
    ].forEach(function (input) {
        input.addEventListener("input", updateAddressPreview);
    });

    document.querySelectorAll('input[name="addressType"]')
        .forEach(function (input) {
            input.addEventListener("change", updateAddressPreview);
        });

    phoneInput.addEventListener("input", function () {
        this.value = this.value.replace(/\D/g, "").slice(0, 10);
    });

    pinInput.addEventListener("input", function () {
        this.value = this.value.replace(/\D/g, "").slice(0, 6);
    });

    form.addEventListener("submit", function (event) {
        const fullName = nameInput.value.trim();
        const phone = phoneInput.value.trim();
        const address = addressInput.value.trim();
        const city = cityInput.value.trim();
        const state = stateInput.value.trim();
        const pin = pinInput.value.trim();
        const country = countryInput.value.trim();

        if (fullName.length < 2) {
            event.preventDefault();
            alert("Please enter your full name.");
            nameInput.focus();
            return;
        }

        if (!/^[6-9]\d{9}$/.test(phone)) {
            event.preventDefault();
            alert("Please enter a valid 10-digit Indian mobile number.");
            phoneInput.focus();
            return;
        }

        if (!address || !city || !state || !country) {
            event.preventDefault();
            alert("Please complete your delivery address.");
            return;
        }

        if (!/^\d{6}$/.test(pin)) {
            event.preventDefault();
            alert("Please enter a valid 6-digit PIN code.");
            pinInput.focus();
            return;
        }

        if (!document.querySelector('input[name="payment"]:checked')) {
            event.preventDefault();
            alert("Please select a payment method.");
            return;
        }

        button.disabled = true;
        button.textContent = "Placing Order...";
    });

    updateAddressPreview();
})();
</script>

</body>
</html>