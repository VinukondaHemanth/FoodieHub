<%@ page language="java"
    contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ page import="java.util.List" %>
<%@ page import="com.tap.model.Menu" %>
<%@ page import="com.tap.model.Cart" %>
<%@ page import="com.tap.model.CartItem" %>

<%
    List<Menu> menuList =
        (List<Menu>) request.getAttribute("allMenu");

    Cart cart =
        (Cart) session.getAttribute("cart");
%>

<!DOCTYPE html>
<html lang="en">

<head>

    <meta charset="UTF-8">

    <meta name="viewport"
          content="width=device-width, initial-scale=1.0">

    <title>FoodieHub | Menu</title>

    <link rel="preconnect"
          href="https://fonts.googleapis.com">

    <link rel="preconnect"
          href="https://fonts.gstatic.com"
          crossorigin>

    <link href="https://fonts.googleapis.com/css2?family=DM+Sans:wght@400;500;600;700;800&family=Playfair+Display:wght@600;700;800&display=swap"
          rel="stylesheet">

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
            background: #fffaf5;
            color: #202020;
            overflow-x: hidden;
        }

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
        }


        /* =====================================================
           HERO
        ===================================================== */

        .menu-hero {

            min-height: 390px;

            position: relative;

            display: flex;

            align-items: center;

            justify-content: center;

            text-align: center;

            overflow: hidden;

            padding: 60px 20px;
        }

        .menu-hero::before {

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

        .hero-content {

            position: relative;

            z-index: 2;

            max-width: 800px;

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

        .hero-badge {

            display: inline-block;

            padding:
                9px 17px;

            border-radius:
                50px;

            background:
                rgba(255,255,255,.78);

            border:
                1px solid
                rgba(255,75,43,.13);

            color:
                #ff4b2b;

            font-size:
                11px;

            font-weight:
                800;

            letter-spacing:
                1.5px;
        }

        .menu-hero h1 {

            margin-top:
                23px;

            font-family:
                'Playfair Display',
                Georgia,
                serif;

            font-size:
                clamp(48px,7vw,82px);

            line-height:
                1;

            letter-spacing:
                -3px;

            color:
                #171717;
        }

        .menu-hero h1 span {
            color: #ff4b2b;
        }

        .menu-hero p {

            margin:
                22px auto 0;

            max-width:
                620px;

            color:
                #777;

            line-height:
                1.7;

            font-size:
                16px;
        }


        /* =====================================================
           FLOATING FOOD
        ===================================================== */

        .food-float {

            position:
                absolute;

            font-size:
                42px;

            z-index:
                1;
        }

        .food-one {
            left: 10%;
            top: 22%;
            animation:
                floatOne
                6s
                ease-in-out
                infinite;
        }

        .food-two {
            right: 10%;
            top: 28%;
            animation:
                floatTwo
                7s
                ease-in-out
                infinite;
        }

        .food-three {
            left: 17%;
            bottom: 15%;
            animation:
                floatThree
                6.5s
                ease-in-out
                infinite;
        }

        .food-four {
            right: 17%;
            bottom: 15%;
            animation:
                floatFour
                7s
                ease-in-out
                infinite;
        }

        @keyframes floatOne {

            0%,100% {
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

            0%,100% {
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

            0%,100% {
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

            0%,100% {
                transform:
                    translate(0,0)
                    rotate(5deg);
            }

            50% {
                transform:
                    translate(-15px,-20px)
                    rotate(-9deg);
            }
        }


        /* =====================================================
           SEARCH
        ===================================================== */

        .search-section {

            width:
                min(1100px,92%);

            margin:
                0 auto 35px;
        }

        .search-box-wrapper {

            width: 100%;

            display: flex;

            align-items: center;

            gap: 12px;

            padding:
                14px 20px;

            background:
                rgba(255,255,255,.86);

            border-radius:
                18px;

            box-shadow:
                0 15px 45px
                rgba(0,0,0,.07);
        }

        .search-icon {
            font-size: 22px;
        }

        .search-box {

            width: 100%;

            border: none;

            outline: none;

            background: transparent;

            font-family: inherit;

            font-size: 16px;

            color: #222;
        }


        /* =====================================================
           MENU
        ===================================================== */

        .menu-section {

            width:
                min(1400px,92%);

            margin:
                0 auto 80px;
        }

        .section-header {
            margin-bottom: 28px;
        }

        .section-header h2 {

            font-family:
                'Playfair Display',
                Georgia,
                serif;

            font-size: 36px;

            color: #181818;
        }

        .section-header p {

            margin-top: 7px;

            color: #777;

            font-size: 15px;
        }

        .menu-container {

            display: grid;

            grid-template-columns:
                repeat(3,1fr);

            gap: 36px;
        }


        /* =====================================================
           CARD
        ===================================================== */

        .menu-card {

            background:
                rgba(255,255,255,.92);

            border-radius:
                30px;

            overflow:
                hidden;

            box-shadow:
                0 18px 45px
                rgba(0,0,0,.08);

            transition:
                transform .35s ease,
                box-shadow .35s ease;

            will-change:
                transform;
        }

        .menu-card:hover {

            transform:
                translateY(-10px);

            box-shadow:
                0 25px 55px
                rgba(0,0,0,.12);
        }

        .menu-image-container {

            position: relative;

            height: 305px;

            overflow: hidden;
        }

        .menu-image {

            width: 100%;

            height: 100%;

            object-fit: cover;

            display: block;

            transition:
                transform .5s ease;
        }

        .menu-card:hover .menu-image {

            transform:
                scale(1.06);
        }

        .availability {

            position: absolute;

            top: 18px;

            right: 18px;

            padding:
                9px 15px;

            border-radius:
                50px;

            color:
                #08752d;

            background:
                rgba(230,255,239,.94);

            font-size:
                12px;

            font-weight:
                800;
        }

        .not-available {

            color:
                #777;

            background:
                rgba(245,245,245,.95);
        }

        .menu-content {
            padding: 25px;
        }

        .menu-content h2 {

            font-family:
                'Playfair Display',
                Georgia,
                serif;

            font-size:
                25px;

            color:
                #181818;

            margin-bottom:
                9px;
        }

        .description {

            color:
                #777;

            font-size:
                14px;

            line-height:
                1.65;

            min-height:
                48px;

            margin-bottom:
                22px;
        }

        .menu-bottom {

            display:
                flex;

            align-items:
                center;

            justify-content:
                space-between;

            gap:
                10px;
        }

        .price {

            font-size:
                23px;

            font-weight:
                900;

            color:
                #ff4b2b;
        }


        /* =====================================================
           CART CONTROL
        ===================================================== */

        .cart-control {

            min-height:
                46px;

            min-width:
                150px;

            display:
                flex;

            align-items:
                center;

            justify-content:
                flex-end;
        }


        /* =====================================================
           ADD BUTTON
        ===================================================== */

        .add-cart-btn {

            width:
                135px;

            height:
                46px;

            border:
                none;

            border-radius:
                25px;

            background:
                #ff4b2b;

            color:
                #fff;

            font-family:
                inherit;

            font-size:
                14px;

            font-weight:
                800;

            cursor:
                pointer;

            box-shadow:
                0 9px 20px
                rgba(255,75,43,.22);

            transition:
                transform .25s ease,
                background .25s ease;
        }

        .add-cart-btn:hover {

            transform:
                translateY(-3px);

            background:
                #e83e21;
        }


        /* =====================================================
           QUANTITY CONTROL
           
           IMPORTANT:
           The number has explicit display,
           visibility and opacity.
        ===================================================== */

        .quantity-control {

            width:
                185px !important;

            min-width:
                185px !important;

            height:
                46px !important;

            display:
                flex !important;

            align-items:
                center !important;

            justify-content:
                space-between !important;

            flex-direction:
                row !important;

            border-radius:
                25px;

            background:
                #ff4b2b;

            overflow:
                hidden;

            box-shadow:
                0 9px 20px
                rgba(255,75,43,.22);

            padding:
                0 !important;

            margin:
                0 !important;
        }


        /* =====================================================
           QUANTITY BUTTON
        ===================================================== */

        .quantity-control .quantity-btn {

            flex:
                0 0 55px !important;

            width:
                55px !important;

            min-width:
                55px !important;

            height:
                46px !important;

            padding:
                0 !important;

            margin:
                0 !important;

            border:
                none !important;

            outline:
                none !important;

            background:
                transparent !important;

            color:
                #ffffff !important;

            font-family:
                Arial,
                sans-serif !important;

            font-size:
                27px !important;

            font-weight:
                900 !important;

            line-height:
                46px !important;

            cursor:
                pointer;

            display:
                flex !important;

            align-items:
                center !important;

            justify-content:
                center !important;

            opacity:
                1 !important;

            visibility:
                visible !important;
        }

        .quantity-control .quantity-btn:hover {

            background:
                rgba(0,0,0,.10) !important;
        }


        /* =====================================================
           QUANTITY NUMBER
           
           THIS FIXES THE INVISIBLE NUMBER.
        ===================================================== */

        .quantity-control .quantity-value {

            flex:
                1 1 auto !important;

            width:
                auto !important;

            min-width:
                50px !important;

            max-width:
                75px !important;

            height:
                46px !important;

            display:
                flex !important;

            align-items:
                center !important;

            justify-content:
                center !important;

            visibility:
                visible !important;

            opacity:
                1 !important;

            position:
                relative !important;

            z-index:
                10 !important;

            color:
                #ffffff !important;

            background:
                transparent !important;

            font-family:
                Arial,
                sans-serif !important;

            font-size:
                18px !important;

            font-weight:
                900 !important;

            line-height:
                46px !important;

            text-align:
                center !important;

            text-shadow:
                0 1px 2px
                rgba(0,0,0,.15);
        }


        /* =====================================================
           EMPTY
        ===================================================== */

        .empty-message {

            width:
                min(700px,92%);

            margin:
                70px auto;

            padding:
                70px 30px;

            text-align:
                center;

            background:
                rgba(255,255,255,.88);

            border-radius:
                30px;

            box-shadow:
                0 20px 55px
                rgba(0,0,0,.07);
        }

        .empty-message h2 {

            font-family:
                'Playfair Display',
                Georgia,
                serif;

            font-size:
                32px;

            margin-bottom:
                12px;
        }

        .empty-message p {
            color: #777;
        }


        /* =====================================================
           RESPONSIVE
        ===================================================== */

        @media(max-width:1000px) {

            .menu-container {
                grid-template-columns:
                    repeat(2,1fr);
            }

            .menu-image-container {
                height:
                    270px;
            }
        }

        @media(max-width:650px) {

            .menu-container {
                grid-template-columns:
                    1fr;
            }

            .menu-section {
                width: 92%;
            }

            .menu-hero {
                min-height:
                    340px;
            }

            .menu-hero h1 {
                font-size:
                    52px;
            }

            .food-float {
                font-size:
                    30px;
            }

            .food-three,
            .food-four {
                display:
                    none;
            }

            .menu-bottom {
                align-items:
                    flex-start;
            }

            .quantity-control {
                width:
                    155px !important;

                min-width:
                    155px !important;
            }

            .quantity-control .quantity-btn {
                flex-basis:
                    45px !important;

                width:
                    45px !important;

                min-width:
                    45px !important;
            }
        }

    </style>

</head>

<body>


<%@ include file="components/navbar.jsp" %>


<!-- =====================================================
     HERO
====================================================== -->

<section class="menu-hero">

    <div class="food-float food-one">
        🍕
    </div>

    <div class="food-float food-two">
        🍔
    </div>

    <div class="food-float food-three">
        🍜
    </div>

    <div class="food-float food-four">
        🍰
    </div>


    <div class="hero-content">

        <div class="hero-badge">
            ✨ MADE FOR FOOD LOVERS
        </div>

        <h1>
            Explore Our
            <br>
            <span>Menu.</span>
        </h1>

        <p>
            Discover delicious dishes prepared
            especially for you.
        </p>

    </div>

</section>


<!-- =====================================================
     SEARCH
====================================================== -->

<section class="search-section">

    <div class="search-box-wrapper">

        <span class="search-icon">
            🔍
        </span>

        <input
            type="text"
            id="menuSearch"
            class="search-box"
            placeholder="Search for your favourite food..."
            autocomplete="off"
            oninput="searchMenu()">

    </div>

</section>


<!-- =====================================================
     MENU
====================================================== -->

<section class="menu-section">

    <div class="section-header">

        <h2>
            Delicious Choices
        </h2>

        <p>
            Pick your favourite dish and add it to your cart.
        </p>

    </div>


<%
if (menuList != null && !menuList.isEmpty()) {
%>

    <div
        class="menu-container"
        id="menuContainer">

<%
    for (Menu menu : menuList) {

        CartItem cartItem = null;

        if (cart != null &&
            cart.getRestaurantId() == menu.getRestaurantId()) {

            cartItem =
                cart.getItem(menu.getMenuId());
        }

        String itemName =
            menu.getItemName() != null
                ? menu.getItemName()
                : "Food Item";

        String description =
            menu.getDescription() != null
                ? menu.getDescription()
                : "";

        String searchName =
            itemName.toLowerCase();

        String searchDescription =
            description.toLowerCase();
%>


        <div
            class="menu-card"
            data-name="<%= searchName %>"
            data-description="<%= searchDescription %>">


            <!-- IMAGE -->

            <div class="menu-image-container">

<%
        if (menu.getImagePath() != null &&
            !menu.getImagePath().trim().isEmpty()) {
%>

                <img
                    src="<%= menu.getImagePath() %>"
                    alt="<%= itemName %>"
                    class="menu-image"
                    onerror="
                        this.src='https://via.placeholder.com/600x400?text=FoodieHub+Food';
                    ">

<%
        } else {
%>

                <img
                    src="https://via.placeholder.com/600x400?text=FoodieHub+Food"
                    alt="<%= itemName %>"
                    class="menu-image">

<%
        }
%>


<%
        if (menu.isAvailable()) {
%>

                <div class="availability">
                    ● Available
                </div>

<%
        } else {
%>

                <div class="availability not-available">
                    ● Unavailable
                </div>

<%
        }
%>

            </div>


            <!-- CONTENT -->

            <div class="menu-content">

                <h2>
                    <%= itemName %>
                </h2>

                <p class="description">
                    <%= description %>
                </p>


                <div class="menu-bottom">


                    <span class="price">
                        ₹<%= String.format(
                            "%.2f",
                            menu.getPrice()
                        ) %>
                    </span>


                    <div
                        class="cart-control"
                        id="cart-control-<%= menu.getMenuId() %>">

<%
        if (menu.isAvailable()) {

            if (cartItem != null &&
                cartItem.getQuantity() > 0) {
%>

                        <div
                            class="quantity-control"
                            id="quantity-control-<%= menu.getMenuId() %>">

                            <button
                                type="button"
                                class="quantity-btn"
                                data-menu-id="<%= menu.getMenuId() %>"
                                data-action="decrease"
                                aria-label="Decrease quantity">

                                −

                            </button>


                            <span
                                class="quantity-value"
                                id="quantity-<%= menu.getMenuId() %>">

                                <%= cartItem.getQuantity() %>

                            </span>


                            <button
                                type="button"
                                class="quantity-btn"
                                data-menu-id="<%= menu.getMenuId() %>"
                                data-action="increase"
                                aria-label="Increase quantity">

                                +

                            </button>

                        </div>

<%
            } else {
%>

                        <button
                            type="button"
                            class="add-cart-btn"
                            data-menu-id="<%= menu.getMenuId() %>"
                            data-action="add">

                            🛒 Add

                        </button>

<%
            }

        } else {
%>

                        <button
                            type="button"
                            class="add-cart-btn"
                            disabled>

                            Unavailable

                        </button>

<%
        }
%>

                    </div>

                </div>

            </div>

        </div>


<%
    }
%>

    </div>

<%
} else {
%>

    <div class="empty-message">

        <h2>
            🍽️ No Menu Items Found
        </h2>

        <p>
            This restaurant currently has no menu items available.
        </p>

    </div>

<%
}
%>

</section>


<!-- =====================================================
     JAVASCRIPT
====================================================== -->

<script>

/* =====================================================
   SEARCH
===================================================== */

function searchMenu() {

    const input =
        document.getElementById("menuSearch");

    if (!input) {
        return;
    }

    const value =
        input.value
            .toLowerCase()
            .trim();

    document
        .querySelectorAll(".menu-card")
        .forEach(function(card) {

            const name =
                (
                    card.getAttribute("data-name")
                    || ""
                ).toLowerCase();

            const description =
                (
                    card.getAttribute("data-description")
                    || ""
                ).toLowerCase();


            if (
                name.includes(value) ||
                description.includes(value)
            ) {

                card.style.display = "";

            } else {

                card.style.display = "none";
            }

        });
}


/* =====================================================
   REQUEST QUEUE
   -----------------------------------------------------
   This is important.

   If the user clicks + two times quickly:

       + click
       + click

   both requests are sent one after another.

   Final server quantity:

       1 -> 2 -> 3

   So cart page will also contain quantity 3.
===================================================== */

const cartRequestQueues = {};


function queueCartRequest(
    menuId,
    action
) {

    if (!cartRequestQueues[menuId]) {

        cartRequestQueues[menuId] =
            Promise.resolve();
    }


    cartRequestQueues[menuId] =
        cartRequestQueues[menuId]
            .then(function() {

                return sendCartRequest(
                    menuId,
                    action
                );

            })
            .catch(function(error) {

                console.error(
                    "Queued cart request error:",
                    error
                );

                return {
                    success: false
                };

            });


    return cartRequestQueues[menuId];
}


/* =====================================================
   CLICK HANDLER
===================================================== */

document.addEventListener(
    "click",
    function(event) {

        const button =
            event.target.closest(
                ".add-cart-btn, .quantity-btn"
            );


        if (!button) {
            return;
        }


        if (button.disabled) {
            return;
        }


        const menuId =
            button.getAttribute(
                "data-menu-id"
            );


        const action =
            button.getAttribute(
                "data-action"
            );


        if (!menuId || !action) {
            return;
        }


        handleCartAction(
            menuId,
            action,
            button
        );

    }
);


/* =====================================================
   HANDLE ACTION
===================================================== */

async function handleCartAction(
    menuId,
    action,
    clickedButton
) {

    const cartControl =
        document.getElementById(
            "cart-control-" + menuId
        );


    if (!cartControl) {
        return;
    }


    /* =================================================
       ADD
    ================================================= */

    if (action === "add") {

        /*
         * Prevent accidental double-add
         * while the first ADD is processing.
         */

        clickedButton.disabled = true;


        const result =
            await queueCartRequest(
                menuId,
                ""
            );


        if (!result.success) {

            clickedButton.disabled = false;

            return;
        }


        let quantity =
            Number(result.quantity);


        if (
            !Number.isFinite(quantity) ||
            quantity < 1
        ) {

            quantity = 1;
        }


        /*
         * Build the quantity control.
         *
         * The number is explicitly present
         * between - and +.
         */

        renderQuantityControl(
            cartControl,
            menuId,
            quantity
        );


        return;
    }


    /* =================================================
       INCREASE / DECREASE
    ================================================= */

    const quantityElement =
        document.getElementById(
            "quantity-" + menuId
        );


    if (!quantityElement) {
        return;
    }


    /*
     * Do NOT disable +/− here.
     *
     * User may click + two times quickly.
     *
     * queueCartRequest() handles the
     * requests one by one.
     */


    const result =
        await queueCartRequest(
            menuId,
            action
        );


    if (!result.success) {
        return;
    }


    let quantity =
        Number(result.quantity);


    /* =================================================
       DECREASE TO ZERO
    ================================================= */

    if (
        action === "decrease" &&
        (
            !Number.isFinite(quantity) ||
            quantity <= 0
        )
    ) {

        cartControl.innerHTML = `

            <button
                type="button"
                class="add-cart-btn"
                data-menu-id="${menuId}"
                data-action="add">

                🛒 Add

            </button>

        `;


        return;
    }


    /* =================================================
       UPDATE NUMBER
    ================================================= */

    if (
        Number.isFinite(quantity) &&
        quantity > 0
    ) {

        quantityElement.textContent =
            String(quantity);


        /*
         * Force browser to display
         * the quantity.
         */

        quantityElement.style.display =
            "flex";

        quantityElement.style.visibility =
            "visible";

        quantityElement.style.opacity =
            "1";
    }

}


/* =====================================================
   RENDER QUANTITY CONTROL
===================================================== */

function renderQuantityControl(
    container,
    menuId,
    quantity
) {

    container.innerHTML = "";


    const control =
        document.createElement("div");


    control.className =
        "quantity-control";


    control.id =
        "quantity-control-" + menuId;


    const decrease =
        document.createElement("button");


    decrease.type =
        "button";


    decrease.className =
        "quantity-btn";


    decrease.setAttribute(
        "data-menu-id",
        menuId
    );


    decrease.setAttribute(
        "data-action",
        "decrease"
    );


    decrease.setAttribute(
        "aria-label",
        "Decrease quantity"
    );


    decrease.textContent =
        "−";


    const number =
        document.createElement("span");


    number.className =
        "quantity-value";


    number.id =
        "quantity-" + menuId;


    number.textContent =
        String(quantity);


    /*
     * Explicitly force visibility.
     */

    number.style.display =
        "flex";

    number.style.visibility =
        "visible";

    number.style.opacity =
        "1";

    number.style.color =
        "#ffffff";

    number.style.fontSize =
        "18px";

    number.style.fontWeight =
        "900";

    number.style.alignItems =
        "center";

    number.style.justifyContent =
        "center";

    number.style.textAlign =
        "center";


    const increase =
        document.createElement("button");


    increase.type =
        "button";


    increase.className =
        "quantity-btn";


    increase.setAttribute(
        "data-menu-id",
        menuId
    );


    increase.setAttribute(
        "data-action",
        "increase"
    );


    increase.setAttribute(
        "aria-label",
        "Increase quantity"
    );


    increase.textContent =
        "+";


    control.appendChild(
        decrease
    );


    control.appendChild(
        number
    );


    control.appendChild(
        increase
    );


    container.appendChild(
        control
    );
}


/* =====================================================
   SEND REQUEST TO CART CONTROLLER
===================================================== */

async function sendCartRequest(
    menuId,
    action
) {

    try {

        const formData =
            new URLSearchParams();


        /*
         * menuId is always sent.
         */

        formData.append(
            "menuId",
            menuId
        );


        /*
         * IMPORTANT:
         *
         * ADD = empty action.
         *
         * Your CartController treats
         * empty/null action as ADD.
         */

        if (
            action !== null &&
            action !== undefined &&
            action !== ""
        ) {

            formData.append(
                "action",
                action
            );
        }


        const response =
            await fetch(
                "<%= request.getContextPath() %>/cart",
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


        if (!response.ok) {

            console.error(
                "Cart request HTTP error:",
                response.status
            );

            return {
                success: false
            };
        }


        const responseText =
            await response.text();


        if (
            !responseText ||
            !responseText.trim()
        ) {

            console.error(
                "CartController returned empty response."
            );

            return {
                success: false
            };
        }


        let data;


        try {

            data =
                JSON.parse(
                    responseText
                );

        } catch (error) {

            console.error(
                "CartController returned invalid JSON:",
                responseText
            );

            return {
                success: false
            };
        }


        console.log(
            "Cart response:",
            data
        );


        return {

            success:
                data.success !== false,

            quantity:
                data.quantity !== undefined
                    ? Number(data.quantity)
                    : 1,

            totalAmount:
                data.totalAmount !== undefined
                    ? Number(data.totalAmount)
                    : 0,

            empty:
                data.empty === true
        };


    } catch (error) {

        console.error(
            "Cart request error:",
            error
        );

        return {
            success: false
        };
    }
}


/* =====================================================
   CARD HOVER
===================================================== */

document
    .querySelectorAll(".menu-card")
    .forEach(function(card) {

        card.addEventListener(
            "mousemove",
            function(event) {

                const rect =
                    card.getBoundingClientRect();


                const x =
                    event.clientX -
                    rect.left;


                const y =
                    event.clientY -
                    rect.top;


                const centerX =
                    rect.width / 2;


                const centerY =
                    rect.height / 2;


                const rotateX =
                    ((y - centerY) /
                    centerY) * -2;


                const rotateY =
                    ((x - centerX) /
                    centerX) * 2;


                card.style.transform =
                    "translateY(-10px) " +
                    "perspective(900px) " +
                    "rotateX(" +
                    rotateX +
                    "deg) " +
                    "rotateY(" +
                    rotateY +
                    "deg)";
            }
        );


        card.addEventListener(
            "mouseleave",
            function() {

                card.style.transform = "";

            }
        );

    });

</script>

</body>

</html>