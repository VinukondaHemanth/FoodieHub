
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"
    import="com.tap.model.Order"
    import="com.tap.model.Cart"
    import="com.tap.model.CartItem" %>

<%
    String cp = request.getContextPath();

    Order placedOrder =
        (Order) session.getAttribute("placedOrder");

    Cart successCart =
        (Cart) session.getAttribute("successCart");

    String restaurantName =
        (String) session.getAttribute("successRestaurantName");

    if (placedOrder == null) {
        response.sendRedirect(cp + "/restaurant");
        return;
    }

    if (restaurantName == null || restaurantName.trim().isEmpty()) {
        restaurantName = "FoodieHub Restaurant";
    }

    String status = placedOrder.getStatus();
    String payment = placedOrder.getPaymentMode();

    if (status == null || status.trim().isEmpty()) {
        status = "Placed";
    }

    if (payment == null || payment.trim().isEmpty()) {
        payment = "COD";
    }
%>

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">

<title>Order Confirmed | FoodieHub</title>

<style>
* {
    margin: 0;
    padding: 0;
    box-sizing: border-box;
}

body {
    font-family: Arial, Helvetica, sans-serif;
    background: #f5f7f5;
    color: #222;
}

.success-container {
    width: 94%;
    max-width: 760px;
    margin: 24px auto;
    background: #f7fbf7;
    border-radius: 12px;
    padding: 18px;
    position: relative;
    z-index: 1;
    animation: successAppear 0.65s ease-out;
}

@keyframes successAppear {
    from {
        opacity: 0;
        transform: translateY(25px) scale(0.97);
    }
    to {
        opacity: 1;
        transform: translateY(0) scale(1);
    }
}

.success-header {
    text-align: center;
    padding: 12px 0 28px;
    border-bottom: 1px solid #cfe6d4;
}

.header-labels {
    display: flex;
    justify-content: space-between;
    color: #159447;
    font-size: 11px;
    font-weight: bold;
    margin-bottom: 20px;
}

.header-labels span {
    display: flex;
    flex-direction: column;
    gap: 5px;
}

.header-labels .sparkle {
    font-size: 22px;
}

.success-icon {
    width: 84px;
    height: 84px;
    margin: 0 auto 8px;
    background: #dcfce7;
    color: #159447;
    border-radius: 50%;
    display: flex;
    align-items: center;
    justify-content: center;
    font-size: 34px;
    animation: successPulse 1.2s ease-in-out 2;
}

@keyframes successPulse {
    0%, 100% {
        transform: scale(1);
        box-shadow: 0 0 0 0 rgba(21, 148, 71, 0.25);
    }
    50% {
        transform: scale(1.08);
        box-shadow: 0 0 0 12px rgba(21, 148, 71, 0);
    }
}

.success-header h1 {
    font-size: 22px;
    color: #16763b;
    margin-bottom: 9px;
}

.success-header p {
    color: #697586;
    font-size: 13px;
    line-height: 1.6;
}

.success-message {
    color: #168348;
    font-size: 12px;
    margin-top: 8px;
}

.order-summary {
    margin-top: 18px;
    padding: 16px 12px;
    background: #fff;
    border-radius: 11px;
}

.summary-heading {
    display: flex;
    justify-content: space-between;
    align-items: center;
    margin-bottom: 12px;
}

.summary-heading h2 {
    font-size: 15px;
    font-weight: normal;
}

.summary-heading span {
    color: #667085;
    font-size: 11px;
}

.order-info {
    font-size: 12px;
    color: #555;
    line-height: 1.9;
    margin-bottom: 12px;
}

.order-info strong {
    color: #16763b;
}

.restaurant-name {
    font-size: 13px;
    font-weight: bold;
    margin: 12px 0;
}

.item-row {
    display: flex;
    align-items: center;
    justify-content: space-between;
    gap: 12px;
    padding: 9px 0;
}

.item-left {
    display: flex;
    align-items: center;
    gap: 10px;
    min-width: 0;
}

.item-image {
    width: 49px;
    height: 49px;
    object-fit: cover;
    border-radius: 7px;
    background: #eee;
    flex-shrink: 0;
}

.item-name {
    font-size: 13px;
    font-weight: bold;
    overflow-wrap: anywhere;
}

.item-quantity {
    color: #697586;
    font-size: 11px;
    margin-top: 6px;
}

.item-price {
    font-size: 12px;
    font-weight: bold;
    white-space: nowrap;
}

.no-items {
    font-size: 12px;
    color: #777;
    line-height: 1.6;
    padding: 12px 0;
}

.summary-divider {
    border: 0;
    border-top: 1px solid #e0e5e9;
    margin: 13px 0;
}

.total-row {
    display: flex;
    align-items: center;
    justify-content: space-between;
    gap: 12px;
    font-size: 12px;
    color: #697586;
    padding: 5px 0;
}

.grand-total {
    color: #168348;
    font-size: 14px;
    font-weight: bold;
}

.action-buttons {
    display: flex;
    flex-direction: column;
    gap: 8px;
    margin-top: 16px;
}

.action-button {
    display: block;
    text-decoration: none;
    text-align: center;
    padding: 12px 15px;
    border-radius: 7px;
    font-size: 12px;
    font-weight: bold;
    transition: 0.2s;
}

.primary-button {
    background: #16a34a;
    color: #fff;
    border: 1px solid #16a34a;
}

.secondary-button {
    background: transparent;
    color: #16763b;
    border: 1px solid #16a34a;
}

.action-button:hover {
    opacity: 0.9;
    transform: translateY(-1px);
}

.footer-note {
    text-align: center;
    color: #7b8490;
    font-size: 10px;
    margin-top: 14px;
    line-height: 1.5;
}

/* =====================================
   FOODIEHUB CONFETTI CELEBRATION
   ===================================== */

#foodiehub-confetti {
    position: fixed;
    inset: 0;
    width: 100%;
    height: 100%;
    overflow: hidden;
    pointer-events: none;
    z-index: 99999;
}

.foodie-confetti-piece {
    position: absolute;
    top: -25px;
    left: 0;
    opacity: 0;
    will-change: transform, opacity;
    animation: foodieConfettiFall linear forwards;
}

@keyframes foodieConfettiFall {
    0% {
        transform: translate3d(0, -20px, 0) rotate(0deg);
        opacity: 1;
    }

    75% {
        opacity: 1;
    }

    100% {
        transform: translate3d(var(--drift), 105vh, 0)
                   rotate(var(--spin));
        opacity: 0;
    }
}

@media (max-width: 480px) {
    .success-container {
        width: 96%;
        padding: 12px;
        margin: 12px auto;
    }

    .success-header h1 {
        font-size: 20px;
    }

    .item-image {
        width: 43px;
        height: 43px;
    }
}

/* Respect accessibility settings */
@media (prefers-reduced-motion: reduce) {
    .success-container,
    .success-icon {
        animation: none;
    }

    .foodie-confetti-piece {
        animation-duration: 0.5s !important;
    }
}
</style>
</head>

<body>

<%@ include file="components/navbar.jsp" %>

<!-- Confetti is displayed only on the successful order page -->
<div id="foodiehub-confetti" aria-hidden="true"></div>

<main class="success-container">

    <section class="success-header">

        <div class="header-labels">
            <span>
                <span class="sparkle">&#10022;</span>
                ORDER PLACED
            </span>

            <span style="text-align: right">
                <span class="sparkle">&#10022;</span>
                THANK YOU!
            </span>
        </div>

        <div class="success-icon">&#10003;</div>

        <h1>Order Confirmed!</h1>

        <p>
            Your delicious food is on its way to being prepared.
        </p>

        <div class="success-message">
            &#10003; Order placed successfully
        </div>

    </section>

    <section class="order-summary">

        <div class="summary-heading">
            <h2>Order Summary</h2>
            <span>Order details</span>
        </div>

        <div class="order-info">
            Order ID:
            <strong>#<%= placedOrder.getOrderId() %></strong>
            <br>

            Status:
            <strong><%= status %></strong>
        </div>

        <div class="restaurant-name">
            <%= restaurantName %>
        </div>

        <%
            boolean itemsFound = false;

            if (successCart != null && !successCart.isEmpty()) {

                for (CartItem item : successCart.getItems()) {

                    if (item == null) {
                        continue;
                    }

                    itemsFound = true;

                    String imagePath = item.getImagePath();

                    if (imagePath == null || imagePath.trim().isEmpty()) {
                        imagePath = cp + "/images/food-placeholder.png";
                    } else if (!imagePath.startsWith("http://")
                            && !imagePath.startsWith("https://")
                            && !imagePath.startsWith(cp + "/")) {

                        if (imagePath.startsWith("/")) {
                            imagePath = cp + imagePath;
                        } else {
                            imagePath = cp + "/" + imagePath;
                        }
                    }
        %>

        <div class="item-row">

            <div class="item-left">

                <img class="item-image"
                     src="<%= imagePath %>"
                     alt="Food item"
                     onerror="this.style.display='none'">

                <div>
                    <div class="item-name">
                        <%= item.getItemName() %>
                    </div>

                    <div class="item-quantity">
                        &#8377;<%= String.format(
                            java.util.Locale.US,
                            "%.0f",
                            item.getPrice()
                        ) %>
                        &times; <%= item.getQuantity() %>
                    </div>
                </div>

            </div>

            <div class="item-price">
                &#8377;<%= String.format(
                    java.util.Locale.US,
                    "%.2f",
                    item.getPrice() * item.getQuantity()
                ) %>
            </div>

        </div>

        <%
                }
            }

            if (!itemsFound) {
        %>

        <div class="no-items">
            Your order was recorded, but the item details are not
            available in this session.
        </div>

        <%
            }
        %>

        <hr class="summary-divider">

        <div class="total-row">
            <span>Payment method</span>
            <strong><%= payment %></strong>
        </div>

        <div class="total-row grand-total">
            <span>Total paid / payable</span>

            <span>
                &#8377;<%= String.format(
                    java.util.Locale.US,
                    "%.2f",
                    placedOrder.getTotalAmount()
                ) %>
            </span>
        </div>

    </section>

    <div class="action-buttons">

        <a class="action-button primary-button"
           href="<%= cp %>/orders">
            View My Orders &#8594;
        </a>

        <a class="action-button secondary-button"
           href="<%= cp %>/restaurant">
            Continue Shopping
        </a>

    </div>

    <div class="footer-note">
        Your order summary displays the order details preserved
        by FoodieHub at checkout.
    </div>

</main>

<script>
(function () {
    const container = document.getElementById("foodiehub-confetti");

    if (!container) {
        return;
    }

    // Colorful confetti pieces for the order success celebration.
    const colors = [
        "#ff4d2e",
        "#ffc107",
        "#28a745",
        "#007bff",
        "#e83e8c",
        "#9b59b6",
        "#00bcd4",
        "#ff7f50"
    ];

    const totalPieces = 140;
    const fragment = document.createDocumentFragment();

    for (let i = 0; i < totalPieces; i++) {
        const piece = document.createElement("span");

        piece.className = "foodie-confetti-piece";

        // Random horizontal starting position.
        piece.style.left = Math.random() * 100 + "%";

        // Random confetti color and shape.
        piece.style.backgroundColor =
            colors[Math.floor(Math.random() * colors.length)];

        piece.style.width = (6 + Math.random() * 8) + "px";
        piece.style.height = (9 + Math.random() * 12) + "px";

        // Each piece falls at a slightly different speed.
        piece.style.animationDuration =
            (2.5 + Math.random() * 3) + "s";

        piece.style.animationDelay =
            (Math.random() * 1.5) + "s";

        // Side-to-side movement and spinning.
        piece.style.setProperty(
            "--drift",
            (Math.random() * 240 - 120) + "px"
        );

        piece.style.setProperty(
            "--spin",
            (Math.random() * 1440 - 720) + "deg"
        );

        // Mix rectangular pieces with small rounded pieces.
        if (Math.random() > 0.7) {
            piece.style.borderRadius = "50%";
        }

        fragment.appendChild(piece);
    }

    container.appendChild(fragment);

    // Remove the animation layer after all pieces finish falling.
    window.setTimeout(function () {
        container.remove();
    }, 7000);
})();
</script>

</body>
</html>