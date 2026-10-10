
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"
    import="java.util.List"
    import="java.util.Map"
    import="java.util.ArrayList"
    import="java.util.Locale"
    import="com.tap.model.User"
    import="com.tap.model.Order"
    import="com.tap.model.OrderItem"
    import="com.tap.model.Restaurant"
    import="com.tap.model.Menu" %>

<%
    String ordersContextPath = request.getContextPath();

    User ordersLoggedInUser =
            (User) session.getAttribute("loggedInUser");

    if (ordersLoggedInUser == null) {
        response.sendRedirect(ordersContextPath + "/login.jsp");
        return;
    }

    List<Order> ordersList =
            (List<Order>) request.getAttribute("orders");

    Map<Integer, List<OrderItem>> orderItemsMap =
            (Map<Integer, List<OrderItem>>) request.getAttribute("orderItemsMap");

    Map<Integer, Restaurant> restaurantsMap =
            (Map<Integer, Restaurant>) request.getAttribute("restaurantsMap");

    Map<Integer, Menu> menusMap =
            (Map<Integer, Menu>) request.getAttribute("menusMap");

    String errorMessage =
            (String) request.getAttribute("errorMessage");

    if (ordersList == null) {
        ordersList = new ArrayList<Order>();
    }
%>

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">

<title>My Orders | FoodieHub</title>

<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=DM+Sans:wght@400;500;600;700;800&family=Playfair+Display:wght@600;700;800&display=swap" rel="stylesheet">

<style>
* {
    margin: 0;
    padding: 0;
    box-sizing: border-box;
}

html {
    scroll-behavior: smooth;
}

body {
    font-family: 'DM Sans', sans-serif;
    color: #242424;
    background: #fffaf5;
    min-height: 100vh;
    overflow-x: hidden;
}

a {
    text-decoration: none;
}

/* HERO */

.orders-hero {
    position: relative;
    overflow: hidden;
    padding: 65px 7% 55px;
    background:
        radial-gradient(circle at 90% 10%, rgba(255,154,0,0.20), transparent 30%),
        linear-gradient(135deg, #fff1e9, #fffaf5 60%, #ffe9dd);
}

.hero-content {
    max-width: 1200px;
    margin: auto;
    position: relative;
    z-index: 1;
}

.breadcrumb {
    color: #777;
    font-size: 13px;
    font-weight: 700;
    letter-spacing: 1.5px;
    margin-bottom: 20px;
}

.breadcrumb span,
.orders-hero h1 span,
.footer-logo span {
    color: #ff4b2b;
}

.orders-hero h1 {
    font-family: 'Playfair Display', serif;
    font-size: clamp(38px, 5vw, 58px);
    line-height: 1.15;
    margin-bottom: 15px;
    color: #202020;
}

.orders-hero p {
    font-size: 16px;
    color: #686868;
    line-height: 1.8;
    max-width: 600px;
}

.hero-decoration {
    position: absolute;
    right: 8%;
    top: 25px;
    font-size: 100px;
    opacity: 0.10;
    animation: floatFood 4s ease-in-out infinite;
}

@keyframes floatFood {
    0%, 100% {
        transform: translateY(0) rotate(-5deg);
    }
    50% {
        transform: translateY(-15px) rotate(5deg);
    }
}

/* MAIN CONTENT */

.orders-container {
    width: 86%;
    max-width: 1200px;
    margin: 40px auto 80px;
}

.section-heading {
    display: flex;
    justify-content: space-between;
    align-items: center;
    gap: 20px;
    flex-wrap: wrap;
    margin-bottom: 28px;
}

.section-heading h2 {
    font-family: 'Playfair Display', serif;
    font-size: 28px;
}

.section-heading p {
    margin-top: 8px;
    color: #777;
    font-size: 14px;
}

.primary-btn,
.secondary-btn {
    display: inline-flex;
    justify-content: center;
    align-items: center;
    gap: 8px;
    padding: 13px 21px;
    border-radius: 13px;
    font-weight: 800;
    font-size: 14px;
    transition: 0.3s ease;
    cursor: pointer;
}

.primary-btn {
    background: #ff4b2b;
    color: white;
    border: 1px solid #ff4b2b;
    box-shadow: 0 8px 20px rgba(255,75,43,0.18);
}

.primary-btn:hover {
    background: #e83a1c;
    transform: translateY(-3px);
}

.secondary-btn {
    background: #fff;
    border: 1px solid #ffd7ca;
    color: #ff4b2b;
}

.secondary-btn:hover {
    background: #fff0e9;
    transform: translateY(-2px);
}

/* ERROR MESSAGE */

.error-message {
    padding: 15px 18px;
    margin-bottom: 22px;
    color: #a12626;
    background: #fff0f0;
    border: 1px solid #ffd0d0;
    border-radius: 12px;
    line-height: 1.6;
}

/* ORDER CARD */

.order-card {
    background: white;
    border: 1px solid #f0e8e1;
    border-radius: 22px;
    margin-bottom: 28px;
    overflow: hidden;
    box-shadow: 0 8px 30px rgba(45,30,20,0.05);
    animation: cardAppear 0.6s ease both;
    transition: transform 0.3s ease, box-shadow 0.3s ease;
}

.order-card:hover {
    transform: translateY(-4px);
    box-shadow: 0 16px 38px rgba(45,30,20,0.10);
}

@keyframes cardAppear {
    from {
        opacity: 0;
        transform: translateY(18px);
    }
    to {
        opacity: 1;
        transform: translateY(0);
    }
}

.order-top {
    padding: 24px 27px;
    display: flex;
    justify-content: space-between;
    align-items: flex-start;
    gap: 18px;
    flex-wrap: wrap;
    background: linear-gradient(110deg, #fff8f3, #fff);
    border-bottom: 1px solid #f3eae4;
}

.order-number {
    color: #999;
    font-size: 11px;
    font-weight: 800;
    letter-spacing: 1.5px;
    margin-bottom: 8px;
}

.order-top h3 {
    font-family: 'Playfair Display', serif;
    font-size: 24px;
    margin-bottom: 8px;
}

.order-date {
    color: #777;
    font-size: 13px;
    overflow-wrap: anywhere;
}

.order-status {
    display: inline-block;
    padding: 9px 14px;
    border-radius: 30px;
    background: #fff0dc;
    color: #a35b00;
    font-size: 12px;
    font-weight: 800;
    text-transform: capitalize;
}

.status-delivered {
    background: #e6f8ec;
    color: #168447;
}

.status-cancelled {
    background: #ffebeb;
    color: #cf3434;
}

/* RESTAURANT */

.restaurant-strip {
    padding: 20px 27px;
    display: flex;
    align-items: center;
    gap: 15px;
    border-bottom: 1px solid #f2ece6;
}

.restaurant-icon {
    width: 52px;
    height: 52px;
    border-radius: 15px;
    display: flex;
    align-items: center;
    justify-content: center;
    background: #fff0e8;
    font-size: 27px;
    flex-shrink: 0;
}

.restaurant-details {
    flex: 1;
    min-width: 0;
}

.restaurant-details h4 {
    font-size: 17px;
    margin-bottom: 5px;
}

.restaurant-details p {
    color: #777;
    font-size: 13px;
    overflow-wrap: anywhere;
}

/* ORDER ITEMS */

.items-heading {
    padding: 22px 27px 8px;
    font-size: 13px;
    font-weight: 800;
    color: #777;
    letter-spacing: 1px;
}

.order-items {
    padding: 5px 27px 20px;
}

.order-item {
    display: flex;
    justify-content: space-between;
    align-items: center;
    gap: 15px;
    padding: 14px 0;
    border-bottom: 1px dashed #eee2d9;
}

.order-item:last-child {
    border-bottom: none;
}

.item-info {
    display: flex;
    align-items: center;
    gap: 13px;
    min-width: 0;
}

.item-icon {
    width: 43px;
    height: 43px;
    border-radius: 12px;
    background: #fff5ed;
    display: flex;
    align-items: center;
    justify-content: center;
    font-size: 22px;
    flex-shrink: 0;
}

.item-info h5 {
    font-size: 14px;
    margin-bottom: 5px;
    overflow-wrap: anywhere;
}

.item-info p {
    font-size: 12px;
    color: #888;
    line-height: 1.6;
}

.item-price {
    font-weight: 800;
    white-space: nowrap;
    font-size: 14px;
}

.no-items {
    padding: 15px 0;
    color: #888;
    font-size: 14px;
    line-height: 1.7;
}

/* ORDER BOTTOM */

.order-bottom {
    display: flex;
    justify-content: space-between;
    align-items: center;
    gap: 20px;
    flex-wrap: wrap;
    padding: 20px 27px;
    background: #fffaf6;
    border-top: 1px solid #f2e9e2;
}

.payment-info {
    font-size: 13px;
    color: #777;
    line-height: 1.9;
}

.payment-info strong {
    color: #333;
}

.total-label {
    color: #777;
    font-size: 12px;
    margin-bottom: 5px;
    text-align: right;
}

.total-amount {
    color: #ff4b2b;
    font-size: 25px;
    font-weight: 800;
    text-align: right;
}

/* EMPTY STATE */

.empty-state {
    text-align: center;
    background: white;
    border: 1px solid #f0e8e1;
    border-radius: 25px;
    padding: 65px 25px;
    box-shadow: 0 10px 35px rgba(45,30,20,0.04);
}

.empty-illustration {
    width: 115px;
    height: 115px;
    border-radius: 50%;
    background: linear-gradient(135deg, #fff0e5, #ffe0d1);
    margin: 0 auto 25px;
    display: flex;
    align-items: center;
    justify-content: center;
    font-size: 56px;
    animation: emptyFloat 3s ease-in-out infinite;
}

@keyframes emptyFloat {
    0%, 100% {
        transform: translateY(0);
    }
    50% {
        transform: translateY(-10px);
    }
}

.empty-state h2 {
    font-family: 'Playfair Display', serif;
    font-size: 29px;
    margin-bottom: 13px;
}

.empty-state p {
    color: #777;
    line-height: 1.8;
    max-width: 480px;
    margin: 0 auto 25px;
}

.empty-actions {
    display: flex;
    justify-content: center;
    gap: 12px;
    flex-wrap: wrap;
}

/* FOOTER */

.orders-footer {
    background: #211b19;
    color: #ddd;
    text-align: center;
    padding: 28px 20px;
    font-size: 13px;
}

.footer-logo {
    font-family: 'Playfair Display', serif;
    font-weight: 800;
    font-size: 25px;
    color: white;
    margin-bottom: 8px;
}

/* RESPONSIVE */

@media (max-width: 768px) {
    .orders-hero {
        padding: 45px 6% 40px;
    }

    .hero-decoration {
        right: 3%;
        top: 20px;
        font-size: 65px;
    }

    .orders-container {
        width: 92%;
        margin-top: 28px;
    }

    .section-heading h2 {
        font-size: 24px;
    }

    .order-top,
    .restaurant-strip,
    .order-bottom {
        padding-left: 18px;
        padding-right: 18px;
    }

    .items-heading {
        padding-left: 18px;
        padding-right: 18px;
    }

    .order-items {
        padding-left: 18px;
        padding-right: 18px;
    }

    .order-top h3 {
        font-size: 21px;
    }

    .total-amount {
        font-size: 22px;
    }
}

@media (max-width: 480px) {
    .orders-hero h1 {
        font-size: 35px;
    }

    .order-top {
        flex-direction: column;
    }

    .order-bottom {
        align-items: flex-start;
    }

    .total-label,
    .total-amount {
        text-align: left;
    }

    .item-info {
        gap: 9px;
    }

    .item-icon {
        width: 36px;
        height: 36px;
        font-size: 18px;
    }

    .item-info h5 {
        font-size: 13px;
    }

    .order-item {
        gap: 8px;
    }
}

@media (prefers-reduced-motion: reduce) {
    *,
    *::before,
    *::after {
        animation: none !important;
        transition: none !important;
        scroll-behavior: auto !important;
    }
}
</style>
</head>

<body>

<%@ include file="components/navbar.jsp" %>

<section class="orders-hero">
    <div class="hero-decoration">🍽️</div>

    <div class="hero-content">
        <div class="breadcrumb">
            FOODIEHUB / <span>YOUR ACCOUNT</span>
        </div>

        <h1>My <span>Orders.</span></h1>

        <p>
            Every craving has a story.
            Revisit your orders and relive your favourite food moments.
        </p>
    </div>
</section>

<main class="orders-container">

    <div class="section-heading">
        <div>
            <h2>Your Food Journey</h2>
            <p>View your previous orders and their details.</p>
        </div>

        <a class="primary-btn"
           href="<%= ordersContextPath %>/restaurant">
            🍴 Explore Restaurants →
        </a>
    </div>

    <% if (errorMessage != null && !errorMessage.trim().isEmpty()) { %>
        <div class="error-message">
            <%= errorMessage %>
        </div>
    <% } %>

    <% if (ordersList.isEmpty()) { %>

        <section class="empty-state">
            <div class="empty-illustration">🍜</div>

            <h2>Your food journey starts here</h2>

            <p>
                You haven't placed any orders yet.
                Discover a restaurant, choose your favourite dishes,
                and let FoodieHub bring something delicious to you.
            </p>

            <div class="empty-actions">
                <a class="primary-btn"
                   href="<%= ordersContextPath %>/restaurant">
                    Discover Restaurants →
                </a>

                <a class="secondary-btn"
                   href="<%= ordersContextPath %>/cart">
                    🛒 View Cart
                </a>
            </div>
        </section>

    <% } else { %>

        <% for (Order order : ordersList) {

            if (order == null) {
                continue;
            }

            Restaurant restaurant = null;

            if (restaurantsMap != null) {
                restaurant = restaurantsMap.get(order.getRestaurantId());
            }

            String restaurantName = "FoodieHub Restaurant";
            String restaurantAddress = "Restaurant details unavailable";

            if (restaurant != null) {
                if (restaurant.getName() != null
                        && !restaurant.getName().trim().isEmpty()) {
                    restaurantName = restaurant.getName();
                }

                if (restaurant.getAddress() != null
                        && !restaurant.getAddress().trim().isEmpty()) {
                    restaurantAddress = restaurant.getAddress();
                }
            }

            String orderStatus = order.getStatus();

            if (orderStatus == null || orderStatus.trim().isEmpty()) {
                orderStatus = "Placed";
            }

            String statusClass = "";

            if ("delivered".equalsIgnoreCase(orderStatus)) {
                statusClass = "status-delivered";
            } else if ("cancelled".equalsIgnoreCase(orderStatus)) {
                statusClass = "status-cancelled";
            }

            List<OrderItem> currentOrderItems = null;

            if (orderItemsMap != null) {
                currentOrderItems = orderItemsMap.get(order.getOrderId());
            }

            if (currentOrderItems == null) {
                currentOrderItems = new ArrayList<OrderItem>();
            }

            String paymentMode = order.getPaymentMode();

            if (paymentMode == null || paymentMode.trim().isEmpty()) {
                paymentMode = "Not specified";
            }
        %>

        <section class="order-card">

            <div class="order-top">
                <div>
                    <div class="order-number">
                        ORDER #<%= order.getOrderId() %>
                    </div>

                    <h3><%= restaurantName %></h3>

                    <div class="order-date">
                        Ordered on: <%= order.getOrderDate() %>
                    </div>
                </div>

                <span class="order-status <%= statusClass %>">
                    <%= orderStatus %>
                </span>
            </div>

            <div class="restaurant-strip">
                <div class="restaurant-icon">🍴</div>

                <div class="restaurant-details">
                    <h4><%= restaurantName %></h4>
                    <p>📍 <%= restaurantAddress %></p>
                </div>

                <a class="secondary-btn"
                   href="<%= ordersContextPath %>/restaurant">
                    Explore Again →
                </a>
            </div>

            <div class="items-heading">ORDER ITEMS</div>

            <div class="order-items">

                <% if (currentOrderItems.isEmpty()) { %>

                    <div class="no-items">
                        Order item details unavailable for this order.
                        Please check that the order's item records exist
                        in your database.
                    </div>

                <% } else { %>

                    <% for (OrderItem orderItem : currentOrderItems) {

                        if (orderItem == null) {
                            continue;
                        }

                        Menu menu = null;

                        if (menusMap != null) {
                            menu = menusMap.get(orderItem.getMenuId());
                        }

                        String itemName;

                        if (menu != null
                                && menu.getItemName() != null
                                && !menu.getItemName().trim().isEmpty()) {

                            itemName = menu.getItemName();

                        } else {
                            itemName = "Food item (Menu ID: "
                                    + orderItem.getMenuId() + ")";
                        }

                        double itemAmount = orderItem.getTotalAmount();
                    %>

                    <div class="order-item">

                        <div class="item-info">
                            <div class="item-icon">🍛</div>

                            <div>
                                <h5><%= itemName %></h5>

                                <p>
                                    Menu ID: <%= orderItem.getMenuId() %>
                                </p>
                            </div>
                        </div>

                        <div class="item-price">
                            &#8377;<%= String.format(
                                    Locale.US,
                                    "%.2f",
                                    itemAmount
                            ) %>
                        </div>

                    </div>

                    <% } %>

                <% } %>

            </div>

            <div class="order-bottom">

                <div class="payment-info">
                    <div>
                        Payment: <strong><%= paymentMode %></strong>
                    </div>

                    <div>
                        Order ID:
                        <strong>#<%= order.getOrderId() %></strong>
                    </div>
                </div>

                <div>
                    <div class="total-label">TOTAL AMOUNT</div>

                    <div class="total-amount">
                        &#8377;<%= String.format(
                                Locale.US,
                                "%.2f",
                                order.getTotalAmount()
                        ) %>
                    </div>
                </div>

            </div>

        </section>

        <% } %>

    <% } %>

</main>

<footer class="orders-footer">
    <div class="footer-logo">Foodie<span>Hub</span></div>
    <p>Discover delicious food. Delivered with love. ❤️</p>
</footer>

</body>
</html>