<%@ page language="java"
    contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ page import="java.util.Collection" %>
<%@ page import="com.tap.model.Cart" %>
<%@ page import="com.tap.model.CartItem" %>
<%@ page import="com.tap.model.Restaurant" %>
<%@ page import="com.tap.daoimpl.RestaurantDaoImpl" %>


<%
    /*
     * =====================================================
     * CART
     * =====================================================
     */

    Cart cart =
        (Cart) session.getAttribute("cart");


    /*
     * =====================================================
     * RESTAURANT
     * =====================================================
     */

    Restaurant restaurant = null;


    if (cart != null) {

        RestaurantDaoImpl restaurantDao =
            new RestaurantDaoImpl();

        restaurant =
            restaurantDao.getRestaurant(
                cart.getRestaurantId()
            );
    }


    /*
     * =====================================================
     * LOGIN STATUS
     *
     * loggedInUser is created in navbar.jsp.
     *
     * We only need a boolean here.
     * =====================================================
     */

    boolean isUserLoggedIn =
        session.getAttribute("loggedInUser") != null;

%>


<!DOCTYPE html>

<html lang="en">


<head>

    <meta charset="UTF-8">

    <meta name="viewport"
          content="width=device-width, initial-scale=1.0">


    <title>
        FoodieHub | Cart
    </title>


    <!-- GOOGLE FONTS -->

    <link rel="preconnect"
          href="https://fonts.googleapis.com">

    <link rel="preconnect"
          href="https://fonts.gstatic.com"
          crossorigin>

    <link href="https://fonts.googleapis.com/css2?family=DM+Sans:wght@400;500;600;700;800;900&family=Playfair+Display:wght@600;700;800&display=swap"
          rel="stylesheet">


<style>

/* =========================================================
   GLOBAL
========================================================= */

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

    background: #fffaf5;

    color: #202020;

    overflow-x: hidden;
}


/* =========================================================
   ANIMATED BACKGROUND
========================================================= */

body::before {

    content: "";

    position: fixed;

    inset: -20%;

    z-index: -5;

    pointer-events: none;

    background:

        radial-gradient(
            circle at 10% 15%,
            rgba(255,75,43,.13),
            transparent 24%
        ),

        radial-gradient(
            circle at 90% 20%,
            rgba(255,154,0,.12),
            transparent 25%
        ),

        radial-gradient(
            circle at 20% 80%,
            rgba(255,75,43,.08),
            transparent 24%
        ),

        radial-gradient(
            circle at 80% 85%,
            rgba(255,154,0,.08),
            transparent 25%
        );

    filter: blur(25px);

    animation:
        backgroundMove
        18s
        ease-in-out
        infinite
        alternate;
}


@keyframes backgroundMove {

    0% {

        transform:
            translate3d(-2%,-1%,0)
            scale(1);
    }


    50% {

        transform:
            translate3d(3%,3%,0)
            scale(1.05);
    }


    100% {

        transform:
            translate3d(-1%,-2%,0)
            scale(1.08);
    }
}


/* =========================================================
   CART HERO
========================================================= */

.cart-hero {

    position: relative;

    min-height: 340px;

    display: flex;

    align-items: center;

    justify-content: center;

    text-align: center;

    overflow: hidden;

    padding: 60px 20px;
}


.cart-hero::before {

    content: "";

    position: absolute;

    width: 430px;

    height: 430px;

    border-radius: 50%;

    background:
        rgba(255,75,43,.10);

    filter: blur(8px);

    animation:
        heroGlow
        6s
        ease-in-out
        infinite
        alternate;
}


@keyframes heroGlow {

    from {
        transform: scale(.85);
    }

    to {
        transform: scale(1.15);
    }
}


.cart-hero-content {

    position: relative;

    z-index: 2;

    animation:
        heroReveal
        1s
        cubic-bezier(.16,1,.3,1)
        forwards;
}


@keyframes heroReveal {

    from {

        opacity: 0;

        transform:
            translateY(45px)
            scale(.96);
    }

    to {

        opacity: 1;

        transform:
            translateY(0)
            scale(1);
    }
}


/* =========================================================
   BADGE
========================================================= */

.hero-badge {

    display: inline-block;

    padding: 9px 17px;

    border-radius: 50px;

    background:
        rgba(255,255,255,.78);

    border:
        1px solid rgba(255,75,43,.13);

    color: #ff4b2b;

    font-size: 11px;

    font-weight: 800;

    letter-spacing: 1.5px;

    backdrop-filter: blur(15px);

    animation:
        badgeFloat
        4s
        ease-in-out
        infinite;
}


@keyframes badgeFloat {

    0%,
    100% {
        transform: translateY(0);
    }

    50% {
        transform: translateY(-6px);
    }
}


/* =========================================================
   HERO TITLE
========================================================= */

.cart-hero h1 {

    margin-top: 22px;

    font-family:
        'Playfair Display',
        Georgia,
        serif;

    font-size:
        clamp(48px,7vw,78px);

    line-height: 1;

    letter-spacing: -3px;

    color: #171717;
}


.cart-hero h1 span {

    color: #ff4b2b;

    background:
        linear-gradient(
            90deg,
            #ff4b2b,
            #ff8a00,
            #ff4b2b
        );

    background-size: 200% auto;

    -webkit-background-clip: text;

    background-clip: text;

    -webkit-text-fill-color: transparent;

    animation:
        gradientText
        5s
        linear
        infinite;
}


@keyframes gradientText {

    from {
        background-position: 0 center;
    }

    to {
        background-position: 200% center;
    }
}


.cart-hero p {

    max-width: 600px;

    margin:
        20px auto 0;

    color: #777;

    line-height: 1.7;

    font-size: 15px;
}


/* =========================================================
   FLOATING FOOD
========================================================= */

.food {

    position: absolute;

    z-index: 1;

    font-size: 42px;

    filter:
        drop-shadow(
            0 10px 12px
            rgba(0,0,0,.12)
        );
}


.food-one {

    left: 12%;

    top: 20%;

    animation:
        floatOne
        6s
        ease-in-out
        infinite;
}


.food-two {

    right: 12%;

    top: 25%;

    animation:
        floatTwo
        7s
        ease-in-out
        infinite;
}


.food-three {

    left: 20%;

    bottom: 15%;

    animation:
        floatThree
        6.5s
        ease-in-out
        infinite;
}


.food-four {

    right: 20%;

    bottom: 15%;

    animation:
        floatFour
        7s
        ease-in-out
        infinite;
}


@keyframes floatOne {

    0%,
    100% {

        transform:
            translateY(0)
            rotate(-7deg);
    }

    50% {

        transform:
            translateY(-25px)
            rotate(8deg);
    }
}


@keyframes floatTwo {

    0%,
    100% {

        transform:
            translateY(0)
            rotate(7deg);
    }

    50% {

        transform:
            translateY(28px)
            rotate(-8deg);
    }
}


@keyframes floatThree {

    0%,
    100% {

        transform:
            translate(0,0)
            rotate(0);
    }

    50% {

        transform:
            translate(15px,-20px)
            rotate(9deg);
    }
}


@keyframes floatFour {

    0%,
    100% {

        transform:
            translate(0,0)
            rotate(5deg);
    }

    50% {

        transform:
            translate(-18px,-22px)
            rotate(-8deg);
    }
}


/* =========================================================
   CART CONTAINER
========================================================= */

.cart-section {

    width:
        min(1150px,92%);

    margin:
        -30px auto 90px;

    position: relative;

    z-index: 5;
}


/* =========================================================
   RESTAURANT HEADER
========================================================= */

.restaurant-card {

    padding:
        25px 30px;

    margin-bottom:
        25px;

    border-radius:
        25px;

    background:
        rgba(255,255,255,.82);

    border:
        1px solid
        rgba(255,255,255,.95);

    box-shadow:
        0 20px 60px
        rgba(0,0,0,.07);

    backdrop-filter:
        blur(20px);

    animation:
        cardReveal
        .8s
        cubic-bezier(.16,1,.3,1)
        forwards;
}


@keyframes cardReveal {

    from {

        opacity: 0;

        transform:
            translateY(35px);
    }

    to {

        opacity: 1;

        transform:
            translateY(0);
    }
}


.restaurant-label {

    color: #999;

    font-size: 11px;

    font-weight: 800;

    letter-spacing: 1.5px;

    text-transform: uppercase;

    margin-bottom: 7px;
}


.restaurant-name {

    font-family:
        'Playfair Display',
        Georgia,
        serif;

    font-size: 29px;

    color: #181818;
}


.restaurant-name span {

    color: #ff4b2b;
}


/* =========================================================
   MAIN CART LAYOUT
========================================================= */

.cart-layout {

    display: grid;

    grid-template-columns:
        minmax(0,1fr)
        350px;

    gap: 25px;

    align-items: start;
}


/* =========================================================
   ITEMS BOX
========================================================= */

.items-box {

    padding: 25px;

    border-radius: 28px;

    background:
        rgba(255,255,255,.82);

    border:
        1px solid
        rgba(255,255,255,.95);

    box-shadow:
        0 20px 60px
        rgba(0,0,0,.07);

    backdrop-filter:
        blur(20px);
}


.items-heading {

    display: flex;

    align-items: center;

    justify-content:
        space-between;

    margin-bottom: 20px;
}


.items-heading h2 {

    font-family:
        'Playfair Display',
        Georgia,
        serif;

    font-size: 27px;
}


.item-count {

    padding:
        7px 12px;

    border-radius: 20px;

    background:
        #fff0e8;

    color:
        #ff4b2b;

    font-size: 11px;

    font-weight: 800;
}


/* =========================================================
   CART ITEM
========================================================= */

.cart-item {

    display: grid;

    grid-template-columns:
        105px
        1fr;

    gap: 18px;

    padding: 18px 0;

    border-bottom:
        1px solid
        rgba(0,0,0,.07);

    animation:
        itemReveal
        .6s
        ease
        both;
}


.cart-item:last-child {

    border-bottom: none;
}


@keyframes itemReveal {

    from {

        opacity: 0;

        transform:
            translateX(-20px);
    }

    to {

        opacity: 1;

        transform:
            translateX(0);
    }
}


/* =========================================================
   ITEM IMAGE
========================================================= */

.item-image {

    width: 105px;

    height: 90px;

    object-fit: cover;

    border-radius: 18px;

    transition:
        transform .4s ease;
}


.cart-item:hover .item-image {

    transform:
        scale(1.06);
}


/* =========================================================
   ITEM CONTENT
========================================================= */

.item-content {

    min-width: 0;
}


.item-top {

    display: flex;

    justify-content:
        space-between;

    gap: 10px;
}


.item-name {

    font-size: 17px;

    font-weight: 800;

    color: #222;
}


.item-price {

    color: #ff4b2b;

    font-size: 15px;

    font-weight: 900;

    white-space: nowrap;
}


.item-subtotal {

    margin-top: 6px;

    color: #888;

    font-size: 12px;
}


/* =========================================================
   ITEM ACTIONS
========================================================= */

.item-actions {

    display: flex;

    align-items: center;

    justify-content:
        space-between;

    margin-top: 15px;

    gap: 10px;
}


/* =========================================================
   QUANTITY
========================================================= */

.quantity-control {

    display: flex;

    align-items: center;

    overflow: hidden;

    border-radius: 12px;

    background: #181818;
}


.quantity-btn {

    width: 35px;

    height: 35px;

    border: none;

    background: transparent;

    color: white;

    font-size: 18px;

    cursor: pointer;

    transition:
        background .3s ease;
}


.quantity-btn:hover {

    background: #ff4b2b;
}


.quantity-value {

    min-width: 35px;

    text-align: center;

    color: white;

    font-size: 13px;

    font-weight: 800;
}


/* =========================================================
   REMOVE
========================================================= */

.remove-btn {

    border: none;

    background: #fff0e8;

    color: #ff4b2b;

    padding:
        9px 13px;

    border-radius: 11px;

    font-family: inherit;

    font-size: 11px;

    font-weight: 800;

    cursor: pointer;

    transition:
        all .35s ease;
}


.remove-btn:hover {

    background: #ff4b2b;

    color: white;

    transform:
        translateY(-2px);
}


/* =========================================================
   SUMMARY
========================================================= */

.summary-box {

    position: sticky;

    top: 105px;

    padding: 28px;

    border-radius: 28px;

    background:
        rgba(255,255,255,.84);

    border:
        1px solid
        rgba(255,255,255,.95);

    box-shadow:
        0 20px 60px
        rgba(0,0,0,.08);

    backdrop-filter:
        blur(20px);

    animation:
        summaryReveal
        .8s
        .15s
        ease
        both;
}


@keyframes summaryReveal {

    from {

        opacity: 0;

        transform:
            translateY(30px);
    }

    to {

        opacity: 1;

        transform:
            translateY(0);
    }
}


.summary-box h2 {

    font-family:
        'Playfair Display',
        Georgia,
        serif;

    font-size: 27px;

    margin-bottom: 25px;
}


.summary-row {

    display: flex;

    justify-content:
        space-between;

    padding: 10px 0;

    color: #777;

    font-size: 13px;
}


.summary-row strong {

    color: #222;
}


.summary-divider {

    height: 1px;

    background:
        rgba(0,0,0,.08);

    margin:
        10px 0;
}


.total-row {

    display: flex;

    justify-content:
        space-between;

    align-items: center;

    margin-top: 10px;

    padding-top: 10px;
}


.total-label {

    font-size: 15px;

    font-weight: 800;
}


.total-amount {

    color: #ff4b2b;

    font-size: 25px;

    font-weight: 900;
}


/* =========================================================
   CHECKOUT BUTTON
========================================================= */

.checkout-btn {

    width: 100%;

    margin-top: 22px;

    padding:
        15px 20px;

    border: none;

    border-radius: 15px;

    background:
        linear-gradient(
            135deg,
            #ff4b2b,
            #ff8a00
        );

    color: white;

    text-decoration: none;

    display: flex;

    align-items: center;

    justify-content: center;

    font-family: inherit;

    font-size: 13px;

    font-weight: 900;

    cursor: pointer;

    box-shadow:
        0 10px 25px
        rgba(255,75,43,.22);

    transition:
        transform .4s ease,
        box-shadow .4s ease;
}


.checkout-btn:hover {

    transform:
        translateY(-4px);

    box-shadow:
        0 15px 32px
        rgba(255,75,43,.32);
}


/* =========================================================
   CLEAR BUTTON
========================================================= */

.clear-btn {

    width: 100%;

    margin-top: 11px;

    padding: 12px;

    border:
        1px solid
        rgba(255,75,43,.18);

    border-radius: 14px;

    background: transparent;

    color: #ff4b2b;

    font-family: inherit;

    font-size: 12px;

    font-weight: 800;

    cursor: pointer;

    transition:
        all .35s ease;
}


.clear-btn:hover {

    background: #fff0e8;

    transform:
        translateY(-2px);
}


/* =========================================================
   EMPTY CART
========================================================= */

.empty-cart {

    width:
        min(650px,92%);

    margin:
        30px auto 90px;

    padding:
        70px 30px;

    text-align: center;

    border-radius: 30px;

    background:
        rgba(255,255,255,.82);

    box-shadow:
        0 20px 60px
        rgba(0,0,0,.07);

    backdrop-filter:
        blur(20px);
}


.empty-icon {

    font-size: 60px;

    margin-bottom: 18px;

    animation:
        emptyFloat
        3s
        ease-in-out
        infinite;
}


@keyframes emptyFloat {

    0%,
    100% {
        transform: translateY(0);
    }

    50% {
        transform: translateY(-10px);
    }
}


.empty-cart h2 {

    font-family:
        'Playfair Display',
        Georgia,
        serif;

    font-size: 30px;

    margin-bottom: 10px;
}


.empty-cart p {

    color: #888;

    font-size: 14px;

    margin-bottom: 25px;
}


.browse-btn {

    display: inline-flex;

    padding:
        13px 22px;

    border-radius: 14px;

    background: #181818;

    color: white;

    text-decoration: none;

    font-size: 12px;

    font-weight: 800;

    transition:
        all .35s ease;
}


.browse-btn:hover {

    background:
        linear-gradient(
            135deg,
            #ff4b2b,
            #ff8a00
        );

    transform:
        translateY(-3px);
}


/* =========================================================
   LOGIN REQUIRED MODAL
========================================================= */

.login-overlay {

    position: fixed;

    inset: 0;

    background:
        rgba(15,15,15,.60);

    backdrop-filter:
        blur(8px);

    display: none;

    align-items: center;

    justify-content: center;

    padding: 20px;

    z-index: 9999;

    opacity: 0;

    transition:
        opacity .3s ease;
}


.login-overlay.show {

    display: flex;

    opacity: 1;
}


.login-modal {

    width:
        min(430px,100%);

    background:
        rgba(255,255,255,.97);

    border-radius: 28px;

    padding: 35px 30px;

    text-align: center;

    box-shadow:
        0 30px 90px
        rgba(0,0,0,.25);

    transform:
        translateY(25px)
        scale(.95);

    animation:
        modalOpen
        .35s
        cubic-bezier(.16,1,.3,1)
        forwards;
}


@keyframes modalOpen {

    to {

        transform:
            translateY(0)
            scale(1);
    }
}


.login-modal-icon {

    width: 72px;

    height: 72px;

    margin:
        0 auto 20px;

    border-radius: 50%;

    display: flex;

    align-items: center;

    justify-content: center;

    font-size: 31px;

    background:
        #fff0e8;

    box-shadow:
        0 10px 30px
        rgba(255,75,43,.15);
}


.login-modal h2 {

    font-family:
        'Playfair Display',
        Georgia,
        serif;

    font-size: 29px;

    color: #181818;

    margin-bottom: 10px;
}


.login-modal h2 span {

    color: #ff4b2b;
}


.login-modal p {

    color: #777;

    font-size: 14px;

    line-height: 1.7;

    margin-bottom: 25px;
}


.login-modal-buttons {

    display: grid;

    grid-template-columns:
        1fr 1fr;

    gap: 12px;
}


.login-now-btn {

    border: none;

    border-radius: 13px;

    padding: 13px;

    background:
        linear-gradient(
            135deg,
            #ff4b2b,
            #ff8a00
        );

    color: white;

    font-family: inherit;

    font-size: 13px;

    font-weight: 800;

    cursor: pointer;

    text-decoration: none;

    display: flex;

    align-items: center;

    justify-content: center;

    transition:
        transform .3s ease,
        box-shadow .3s ease;
}


.login-now-btn:hover {

    transform:
        translateY(-3px);

    box-shadow:
        0 10px 25px
        rgba(255,75,43,.25);
}


.cancel-login-btn {

    border:
        1px solid
        #e7e7e7;

    border-radius: 13px;

    padding: 13px;

    background: white;

    color: #444;

    font-family: inherit;

    font-size: 13px;

    font-weight: 800;

    cursor: pointer;

    transition:
        all .3s ease;
}


.cancel-login-btn:hover {

    background: #f7f7f7;

    transform:
        translateY(-3px);
}


/* =========================================================
   RESPONSIVE
========================================================= */

@media(max-width:850px) {

    .cart-layout {

        grid-template-columns: 1fr;
    }


    .summary-box {

        position: relative;

        top: auto;
    }
}


@media(max-width:600px) {

    .cart-hero {

        min-height: 310px;
    }


    .cart-hero h1 {

        font-size: 48px;

        letter-spacing: -2px;
    }


    .food {

        font-size: 28px;

        opacity: .65;
    }


    .cart-section {

        width: 92%;

        margin-top: -20px;
    }


    .restaurant-card {

        padding: 20px;
    }


    .restaurant-name {

        font-size: 24px;
    }


    .items-box,
    .summary-box {

        padding: 20px;
    }


    .cart-item {

        grid-template-columns:
            80px
            1fr;

        gap: 13px;
    }


    .item-image {

        width: 80px;

        height: 75px;
    }


    .item-top {

        flex-direction: column;

        gap: 4px;
    }


    .item-actions {

        align-items:
            flex-start;

        flex-direction:
            column;
    }


    .quantity-control {

        align-self:
            flex-start;
    }


    .remove-btn {

        align-self:
            flex-start;
    }


    .login-modal {

        padding:
            30px 20px;
    }


    .login-modal-buttons {

        grid-template-columns: 1fr;
    }
}


@media(prefers-reduced-motion: reduce) {

    *,
    *::before,
    *::after {

        animation-duration:
            .01ms !important;

        animation-iteration-count:
            1 !important;

        transition-duration:
            .01ms !important;
    }
}

</style>

</head>


<body>


<!-- =====================================================
     COMMON NAVBAR
====================================================== -->

<%@ include file="components/navbar.jsp" %>


<%
/*
 * =====================================================
 * EMPTY CART
 * =====================================================
 */

if (cart == null || cart.isEmpty()) {

%>


    <!-- EMPTY CART -->

    <section class="empty-cart">

        <div class="empty-icon">
            🛒
        </div>


        <h2>
            Your Cart is Empty
        </h2>


        <p>
            Looks like you haven't added
            anything delicious yet.
        </p>


        <a
            href="restaurant"
            class="browse-btn">

            Explore Restaurants
            →

        </a>

    </section>


<%

} else {

%>


<!-- =====================================================
     HERO
====================================================== -->

<section class="cart-hero">


    <div class="food food-one">
        🍕
    </div>


    <div class="food food-two">
        🍔
    </div>


    <div class="food food-three">
        🍜
    </div>


    <div class="food food-four">
        🍰
    </div>


    <div class="cart-hero-content">

        <div class="hero-badge">
            🛒 YOUR FOOD JOURNEY
        </div>


        <h1>

            Your
            <span>Cart.</span>

        </h1>


        <p>

            Your favourite dishes are waiting
            for you. Almost time to eat!

        </p>

    </div>

</section>



<!-- =====================================================
     CART SECTION
====================================================== -->

<section class="cart-section">


    <!-- =================================================
         RESTAURANT
    ================================================== -->

    <div class="restaurant-card">

        <div class="restaurant-label">

            ORDERING FROM

        </div>


        <div class="restaurant-name">

<%
if (restaurant != null) {
%>

            <%= restaurant.getName() %>

<%
} else {
%>

            FoodieHub Restaurant

<%
}
%>

            <span>•</span>

            FoodieHub

        </div>

    </div>



    <!-- =================================================
         CART LAYOUT
    ================================================== -->

    <div class="cart-layout">


        <!-- =============================================
             ITEMS
        ============================================== -->

        <div class="items-box">


            <div class="items-heading">

                <h2>
                    Your Items
                </h2>


                <span class="item-count">

                    <%= cart.getItemCount() %>
                    Items

                </span>

            </div>


<%

Collection<CartItem> items =
    cart.getItems();


for (CartItem item : items) {


    double itemTotal =
        item.getPrice()
        * item.getQuantity();

%>


            <!-- =========================================
                 CART ITEM
            ========================================== -->

            <div
                class="cart-item"
                id="cart-item-<%= item.getMenuId() %>">


<%
if (item.getImagePath() != null &&
    !item.getImagePath().trim().isEmpty()) {
%>


                <img
                    src="<%= item.getImagePath() %>"
                    alt="<%= item.getItemName() %>"
                    class="item-image"

                    onerror="
                        this.src='https://via.placeholder.com/300x200?text=FoodieHub';
                    ">


<%
} else {
%>


                <img
                    src="https://via.placeholder.com/300x200?text=FoodieHub"
                    alt="Food"
                    class="item-image">


<%
}
%>


                <div class="item-content">


                    <div class="item-top">


                        <div class="item-name">

                            <%= item.getItemName() %>

                        </div>


                        <div class="item-price">

                            ₹<%= String.format(
                                "%.2f",
                                item.getPrice()
                            ) %>

                        </div>

                    </div>


                    <div class="item-subtotal">

                        Item Total:

                        ₹<span
                            id="item-total-<%= item.getMenuId() %>">

                            <%= String.format(
                                "%.2f",
                                itemTotal
                            ) %>

                        </span>

                    </div>


                    <div class="item-actions">


                        <!-- QUANTITY -->

                        <div
                            class="quantity-control">


                            <button
                                type="button"
                                class="quantity-btn"

                                onclick="
                                    updateCart(
                                        <%= item.getMenuId() %>,
                                        'decrease'
                                    )
                                ">

                                −

                            </button>


                            <span
                                class="quantity-value"
                                id="quantity-<%= item.getMenuId() %>">

                                <%= item.getQuantity() %>

                            </span>


                            <button
                                type="button"
                                class="quantity-btn"

                                onclick="
                                    updateCart(
                                        <%= item.getMenuId() %>,
                                        'increase'
                                    )
                                ">

                                +

                            </button>

                        </div>



                        <!-- REMOVE -->

                        <button
                            type="button"
                            class="remove-btn"

                            onclick="
                                removeItem(
                                    <%= item.getMenuId() %>
                                )
                            ">

                            ✕ Remove

                        </button>


                    </div>


                </div>

            </div>


<%
}
%>


        </div>



        <!-- =============================================
             SUMMARY
        ============================================== -->

        <aside class="summary-box">


            <h2>
                Order Summary
            </h2>


            <div class="summary-row">

                <span>
                    Items
                </span>

                <strong id="summary-item-count">

                    <%= cart.getItemCount() %>

                </strong>

            </div>


            <div class="summary-row">

                <span>
                    Delivery
                </span>

                <strong>
                    FREE
                </strong>

            </div>


            <div class="summary-divider"></div>


            <div class="total-row">

                <span class="total-label">
                    Total
                </span>


                <span
                    class="total-amount"
                    id="cart-total">

                    ₹<%= String.format(
                        "%.2f",
                        cart.getTotalAmount()
                    ) %>

                </span>

            </div>



            <!-- =========================================
                 PROCEED TO CHECKOUT
            ========================================== -->

            <button
                type="button"
                class="checkout-btn"
                onclick="proceedToCheckout()">

                Proceed to Checkout
                &nbsp; →

            </button>



            <!-- =========================================
                 CLEAR CART
            ========================================== -->

            <button
                type="button"
                class="clear-btn"

                onclick="clearCart()">

                🗑 Clear Cart

            </button>


        </aside>


    </div>


</section>


<%
}
%>



<!-- =====================================================
     LOGIN REQUIRED MODAL
====================================================== -->

<div
    class="login-overlay"
    id="loginOverlay">


    <div class="login-modal">


        <div class="login-modal-icon">

            🔐

        </div>


        <h2>

            Login <span>Required</span>

        </h2>


        <p>

            Please login to your FoodieHub account
            before continuing to checkout.
            Your cart will be kept safe.

        </p>


        <div class="login-modal-buttons">


            <a
                href="login.jsp"
                class="login-now-btn">

                👤 Login Now

            </a>


            <button
                type="button"
                class="cancel-login-btn"
                onclick="closeLoginModal()">

                Cancel

            </button>


        </div>


    </div>

</div>



<!-- =====================================================
     JAVASCRIPT
====================================================== -->

<script>


/* =========================================================
   LOGIN CHECK
========================================================= */

function proceedToCheckout() {


    /*
     * Server-side JSP value.
     *
     * true  = user already logged in
     * false = user is not logged in
     */

    const isLoggedIn =
        <%= isUserLoggedIn %>;


    /*
     * USER ALREADY LOGGED IN
     */

    if (isLoggedIn) {

        window.location.href =
            "checkout.jsp";

        return;
    }


    /*
     * USER NOT LOGGED IN
     */

    openLoginModal();
}


/* =========================================================
   OPEN LOGIN MODAL
========================================================= */

function openLoginModal() {

    const overlay =
        document.getElementById(
            "loginOverlay"
        );


    overlay.style.display =
        "flex";


    setTimeout(
        function() {

            overlay.classList.add(
                "show"
            );

        },
        10
    );


    document.body.style.overflow =
        "hidden";
}


/* =========================================================
   CLOSE LOGIN MODAL
========================================================= */

function closeLoginModal() {

    const overlay =
        document.getElementById(
            "loginOverlay"
        );


    overlay.classList.remove(
        "show"
    );


    setTimeout(
        function() {

            overlay.style.display =
                "none";

            document.body.style.overflow =
                "";

        },
        300
    );
}


/* =========================================================
   CLOSE MODAL WHEN CLICKING OUTSIDE
========================================================= */

document
    .getElementById("loginOverlay")
    .addEventListener(
        "click",
        function(event) {

            if (
                event.target ===
                this
            ) {

                closeLoginModal();

            }

        }
    );


/* =========================================================
   ESCAPE KEY
========================================================= */

document.addEventListener(
    "keydown",
    function(event) {

        if (
            event.key === "Escape"
        ) {

            closeLoginModal();

        }

    }
);


/* =========================================================
   UPDATE CART
========================================================= */

async function updateCart(
    menuId,
    action
) {


    const quantityElement =
        document.getElementById(
            "quantity-" + menuId
        );


    if (!quantityElement) {

        return;
    }


    let quantity =
        parseInt(
            quantityElement
                .textContent
                .trim()
        );


    if (action === "increase") {

        quantity++;

    }


    else if (
        action === "decrease"
    ) {

        quantity--;

    }


    /*
     * If quantity reaches zero,
     * remove the item.
     */

    if (quantity <= 0) {

        removeItem(menuId);

        return;
    }


    /*
     * Update UI immediately.
     */

    quantityElement.textContent =
        quantity;


    try {


        const formData =
            new URLSearchParams();


        formData.append(
            "menuId",
            menuId
        );


        formData.append(
            "action",
            action
        );


        const response =
            await fetch(
                "cart",
                {

                    method:
                        "POST",

                    headers: {

                        "Content-Type":
                            "application/x-www-form-urlencoded"

                    },

                    body:
                        formData.toString()
                }
            );


        const data =
            await response.json();


        if (data.success) {


            /*
             * Update total.
             */

            updateTotal(
                data.totalAmount
            );


            /*
             * Update item subtotal.
             */

            const itemSubtotal =
                document.getElementById(
                    "item-total-" + menuId
                );


            if (itemSubtotal) {

                /*
                 * We can calculate the
                 * current item subtotal
                 * from the displayed price.
                 */

                const itemElement =
                    document.getElementById(
                        "cart-item-" + menuId
                    );


                if (itemElement) {

                    const priceText =
                        itemElement
                            .querySelector(
                                ".item-price"
                            )
                            .textContent
                            .replace(
                                "₹",
                                ""
                            )
                            .trim();


                    const price =
                        parseFloat(
                            priceText
                        );


                    itemSubtotal.textContent =
                        (
                            price *
                            data.quantity
                        ).toFixed(2);
                }
            }


            /*
             * If cart became empty.
             */

            if (data.empty) {

                showEmptyCart();

            }

        }

    }

    catch (error) {

        console.error(
            "Cart update error:",
            error
        );

    }

}


/* =========================================================
   REMOVE ITEM
========================================================= */

async function removeItem(
    menuId
) {


    const item =
        document.getElementById(
            "cart-item-" + menuId
        );


    try {


        const formData =
            new URLSearchParams();


        formData.append(
            "menuId",
            menuId
        );


        formData.append(
            "action",
            "remove"
        );


        const response =
            await fetch(
                "cart",
                {

                    method:
                        "POST",

                    headers: {

                        "Content-Type":
                            "application/x-www-form-urlencoded"

                    },

                    body:
                        formData.toString()
                }
            );


        const data =
            await response.json();


        if (data.success) {


            if (item) {

                item.style.opacity =
                    "0";

                item.style.transform =
                    "translateX(30px)";


                setTimeout(
                    function() {


                        item.remove();


                        updateTotal(
                            data.totalAmount
                        );


                        updateItemCount(
                            data.itemCount
                        );


                        if (
                            data.empty
                        ) {

                            showEmptyCart();

                        }

                    },
                    350
                );

            }

        }

    }

    catch (error) {

        console.error(
            "Remove error:",
            error
        );

    }

}


/* =========================================================
   CLEAR CART
========================================================= */

async function clearCart() {


    try {


        const formData =
            new URLSearchParams();


        formData.append(
            "action",
            "clear"
        );


        const response =
            await fetch(
                "cart",
                {

                    method:
                        "POST",

                    headers: {

                        "Content-Type":
                            "application/x-www-form-urlencoded"

                    },

                    body:
                        formData.toString()
                }
            );


        const data =
            await response.json();


        if (data.success) {

            showEmptyCart();

        }

    }

    catch (error) {

        console.error(
            "Clear cart error:",
            error
        );

    }

}


/* =========================================================
   UPDATE TOTAL
========================================================= */

function updateTotal(
    total
) {


    const totalElement =
        document.getElementById(
            "cart-total"
        );


    if (totalElement) {

        totalElement.textContent =
            "₹" +
            Number(total)
                .toFixed(2);

    }

}


/* =========================================================
   UPDATE ITEM COUNT
========================================================= */

function updateItemCount(
    count
) {


    const countElement =
        document.getElementById(
            "summary-item-count"
        );


    if (countElement) {

        countElement.textContent =
            count;

    }


    const badgeElements =
        document.querySelectorAll(
            ".item-count"
        );


    badgeElements.forEach(
        function(element) {

            element.textContent =
                count + " Items";

        }
    );

}


/* =========================================================
   EMPTY CART UI
========================================================= */

function showEmptyCart() {


    document.body.innerHTML = `

        <style>

            .empty-final {

                min-height:
                    100vh;

                display:
                    flex;

                align-items:
                    center;

                justify-content:
                    center;

                text-align:
                    center;

                font-family:
                    'DM Sans',
                    sans-serif;

                background:
                    #fffaf5;

                padding:
                    30px;

            }


            .empty-final-box {

                padding:
                    60px 30px;

                max-width:
                    600px;

            }


            .empty-final-icon {

                font-size:
                    65px;

                margin-bottom:
                    20px;

                animation:
                    emptyFloat
                    3s
                    ease-in-out
                    infinite;

            }


            .empty-final h1 {

                font-family:
                    'Playfair Display',
                    Georgia,
                    serif;

                font-size:
                    38px;

                margin-bottom:
                    10px;

            }


            .empty-final p {

                color:
                    #777;

                margin-bottom:
                    25px;

            }


            .empty-final a {

                display:
                    inline-block;

                padding:
                    13px 22px;

                border-radius:
                    14px;

                background:
                    linear-gradient(
                        135deg,
                        #ff4b2b,
                        #ff8a00
                    );

                color:
                    white;

                text-decoration:
                    none;

                font-weight:
                    700;

            }

        </style>


        <div class="empty-final">

            <div class="empty-final-box">

                <div class="empty-final-icon">

                    🛒

                </div>


                <h1>

                    Your Cart is Empty

                </h1>


                <p>

                    Add something delicious
                    from FoodieHub.

                </p>


                <a href="restaurant">

                    Explore Restaurants →

                </a>

            </div>

        </div>

    `;

}

</script>


</body>

</html>