<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ page import="java.util.List"%>
<%@ page import="com.tap.model.Restaurant"%>

<%
    List<Restaurant> restaurants =
        (List<Restaurant>) request.getAttribute("restaurants");
%>

<!DOCTYPE html>
<html lang="en">

<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">

<title>FoodieHub | Restaurants</title>

<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>

<link href="https://fonts.googleapis.com/css2?family=DM+Sans:wght@400;500;600;700;800&family=Playfair+Display:wght@600;700;800&display=swap"
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
    position: relative;
    background: #fffdfb;
    color: #202020;
    overflow-x: hidden;
}

body::before {
    content: "";
    position: fixed;
    inset: -20%;
    z-index: -10;
    pointer-events: none;
    background:
        radial-gradient(circle at 12% 18%, rgba(255,75,43,.16), transparent 22%),
        radial-gradient(circle at 88% 22%, rgba(255,193,7,.13), transparent 24%),
        radial-gradient(circle at 25% 78%, rgba(255,120,50,.10), transparent 20%),
        radial-gradient(circle at 78% 82%, rgba(255,75,43,.09), transparent 22%);
    filter: blur(25px);
    animation: pageGlowMove 18s ease-in-out infinite alternate;
}

body::after {
    content: "";
    position: fixed;
    inset: 0;
    z-index: -9;
    pointer-events: none;
    opacity: .38;
    background-image:
        radial-gradient(rgba(255,75,43,.12) 1px, transparent 1px),
        radial-gradient(rgba(255,193,7,.10) 1px, transparent 1px);
    background-size: 55px 55px, 85px 85px;
    background-position: 0 0, 20px 35px;
    animation: dotDrift 24s linear infinite;
}

@keyframes pageGlowMove {
    0% { transform: translate3d(-2%, -1%, 0) scale(1); }
    35% { transform: translate3d(3%, 2%, 0) scale(1.06); }
    70% { transform: translate3d(-1%, 4%, 0) scale(1.02); }
    100% { transform: translate3d(4%, -2%, 0) scale(1.08); }
}

@keyframes dotDrift {
    from { background-position: 0 0, 20px 35px; }
    to { background-position: 110px 70px, -80px 120px; }
}

/* =========================================================
   NAVBAR
========================================================= */

.navbar {
    position: sticky;
    top: 0;
    z-index: 1000;
    min-height: 76px;
    display: flex;
    align-items: center;
    justify-content: space-between;
    padding: 12px 6%;
    background: rgba(255,255,255,.90);
    backdrop-filter: blur(20px);
    -webkit-backdrop-filter: blur(20px);
    border-bottom: 1px solid rgba(0,0,0,.06);
    box-shadow: 0 8px 35px rgba(0,0,0,.05);
}

.logo {
    font-family: 'Playfair Display', serif;
    font-size: 29px;
    font-weight: 800;
    text-decoration: none;
    color: #ff4b2b;
    letter-spacing: -.5px;
    white-space: nowrap;
}

.logo span {
    color: #202020;
}

.nav-right {
    display: flex;
    align-items: center;
    justify-content: flex-end;
    gap: 16px;
    flex-wrap: wrap;
}

.nav-link {
    text-decoration: none;
    color: #333;
    font-size: 14px;
    font-weight: 700;
    transition: color .3s ease;
}

.nav-link:hover {
    color: #ff4b2b;
}

/* =========================================================
   NAVBAR BUTTONS
========================================================= */

.nav-button {
    position: relative;
    overflow: hidden;
    display: inline-flex;
    align-items: center;
    justify-content: center;
    gap: 6px;
    padding: 11px 17px;
    border-radius: 30px;
    text-decoration: none;
    color: white;
    background: #202020;
    font-size: 13px;
    font-weight: 700;
    white-space: nowrap;
    transition: background .4s ease, box-shadow .4s ease;
}

.nav-button:hover {
    background: linear-gradient(135deg, #ff4b2b, #ff8a00);
    box-shadow: 0 8px 22px rgba(255,75,43,.35);
    animation: buttonBounce .7s ease;
}

@keyframes buttonBounce {
    0%, 100% { transform: translate(0, 0); }
    25% { transform: translate(-3px, -2px); }
    50% { transform: translate(3px, 2px); }
    75% { transform: translate(-2px, 1px); }
}

/* =========================================================
   PROFILE DROPDOWN
========================================================= */

.profile-wrapper {
    position: relative;
}

.profile-btn {
    border: none;
    border-radius: 50%;
    width: 43px;
    height: 43px;
    cursor: pointer;
    background: #fff0e9;
    color: #ff4b2b;
    font-size: 20px;
    transition: .3s;
}

.profile-btn:hover {
    background: #ff4b2b;
    color: white;
    box-shadow: 0 0 20px rgba(255,75,43,.3);
}

.profile-dropdown {
    display: none;
    position: absolute;
    top: 55px;
    right: 0;
    width: 230px;
    padding: 12px;
    background: white;
    border: 1px solid #eee;
    border-radius: 16px;
    box-shadow: 0 15px 45px rgba(0,0,0,.14);
    z-index: 2000;
}

.profile-dropdown.show {
    display: block;
    animation: dropdownShow .2s ease;
}

@keyframes dropdownShow {
    from { opacity: 0; transform: translateY(-8px); }
    to { opacity: 1; transform: translateY(0); }
}

.profile-user {
    padding: 10px;
    border-bottom: 1px solid #eee;
    margin-bottom: 7px;
    overflow-wrap: anywhere;
}

.profile-user small {
    display: block;
    color: #888;
    font-size: 11px;
    margin-bottom: 4px;
}

.profile-username {
    color: #222;
    font-weight: 800;
    font-size: 14px;
}

.profile-menu-link {
    display: block;
    padding: 11px 10px;
    color: #333;
    text-decoration: none;
    border-radius: 9px;
    font-size: 13px;
    font-weight: 600;
    transition: .2s;
}

.profile-menu-link:hover {
    color: #ff4b2b;
    background: #fff3ee;
}

/* =========================================================
   HERO
========================================================= */

.hero {
    position: relative;
    min-height: 470px;
    display: flex;
    align-items: center;
    justify-content: center;
    text-align: center;
    overflow: hidden;
    background:
        radial-gradient(circle at 10% 20%, rgba(255,75,43,.28), transparent 30%),
        radial-gradient(circle at 90% 75%, rgba(255,193,7,.24), transparent 32%),
        radial-gradient(circle at 50% 50%, rgba(255,120,60,.13), transparent 35%),
        linear-gradient(135deg, #fff5ee, #fff 48%, #fff3e8);
    background-size: 170% 170%, 160% 160%, 150% 150%, 100% 100%;
    animation: heroBackground 10s ease-in-out infinite alternate;
    isolation: isolate;
    box-shadow: inset 0 -35px 80px rgba(255,75,43,.04);
}

.hero::before {
    content: "";
    position: absolute;
    width: 520px;
    height: 520px;
    left: -180px;
    top: -180px;
    border-radius: 50%;
    background: radial-gradient(circle, rgba(255,75,43,.25), rgba(255,193,7,.10), transparent 70%);
    filter: blur(18px);
    animation: glowMoveOne 10s ease-in-out infinite alternate;
    z-index: -2;
}

.hero::after {
    content: "";
    position: absolute;
    width: 480px;
    height: 480px;
    right: -170px;
    bottom: -190px;
    border-radius: 50%;
    background: radial-gradient(circle, rgba(255,193,7,.24), rgba(255,75,43,.10), transparent 70%);
    filter: blur(22px);
    animation: glowMoveTwo 12s ease-in-out infinite alternate;
    z-index: -2;
}

@keyframes heroBackground {
    0% { background-position: 0% 0%, 100% 20%, 50% 100%, 0% 50%; }
    50% { background-position: 35% 30%, 70% 60%, 30% 70%, 100% 50%; }
    100% { background-position: 70% 60%, 20% 80%, 80% 30%, 0% 50%; }
}

@keyframes glowMoveOne {
    0% { transform: translate(0,0) scale(1); }
    50% { transform: translate(180px,100px) scale(1.15); }
    100% { transform: translate(320px,40px) scale(.9); }
}

@keyframes glowMoveTwo {
    0% { transform: translate(0,0) scale(1); }
    50% { transform: translate(-150px,-100px) scale(1.2); }
    100% { transform: translate(-280px,20px) scale(.9); }
}

.hero-content {
    position: relative;
    z-index: 5;
    max-width: 900px;
    padding: 70px 20px;
}

.hero-badge {
    display: inline-flex;
    align-items: center;
    gap: 8px;
    padding: 9px 18px;
    border-radius: 30px;
    background: rgba(255,75,43,.08);
    color: #ff4b2b;
    font-size: 13px;
    font-weight: 800;
    margin-bottom: 22px;
    border: 1px solid rgba(255,75,43,.12);
}

.hero h1 {
    font-family: 'Playfair Display', serif;
    font-size: clamp(45px, 7vw, 78px);
    line-height: 1.02;
    letter-spacing: -2px;
    margin-bottom: 22px;
    animation: heroText 1s ease forwards;
}

.hero h1 span {
    color: #ff4b2b;
}

.hero-description {
    max-width: 650px;
    margin: auto;
    color: #777;
    font-size: 17px;
    line-height: 1.8;
}

@keyframes heroText {
    from { opacity: 0; transform: translateY(25px); }
    to { opacity: 1; transform: translateY(0); }
}

/* =========================================================
   FLOATING FOOD AND PARTICLES
========================================================= */

.food {
    position: absolute;
    font-size: 40px;
    opacity: .82;
    filter: drop-shadow(0 12px 18px rgba(0,0,0,.10));
    animation: foodFloat 7s ease-in-out infinite;
    z-index: 3;
}

.food-one { left: 8%; top: 23%; }
.food-two { right: 10%; top: 25%; animation-delay: 1s; }
.food-three { left: 15%; bottom: 15%; animation-delay: 2s; }
.food-four { right: 17%; bottom: 13%; animation-delay: 3s; }

@keyframes foodFloat {
    0% { transform: translate(0,0) rotate(0deg) scale(1); }
    20% { transform: translate(15px,-20px) rotate(6deg) scale(1.05); }
    40% { transform: translate(-12px,-38px) rotate(-5deg) scale(1.1); }
    60% { transform: translate(20px,-20px) rotate(8deg) scale(1.05); }
    80% { transform: translate(-15px,5px) rotate(-6deg) scale(.98); }
    100% { transform: translate(0,0) rotate(0deg) scale(1); }
}

.particle {
    position: absolute;
    width: 8px;
    height: 8px;
    border-radius: 50%;
    background: linear-gradient(135deg, #ff4b2b, #ffc107);
    box-shadow: 0 0 16px rgba(255,75,43,.35);
    opacity: .55;
    z-index: 1;
    animation: particleFloat 6s ease-in-out infinite;
}

.particle-1 { left: 8%; top: 35%; }
.particle-2 { left: 20%; top: 15%; animation-delay: 1s; }
.particle-3 { left: 31%; top: 78%; animation-delay: 2s; }
.particle-4 { left: 45%; top: 18%; animation-delay: 3s; }
.particle-5 { left: 57%; top: 82%; animation-delay: 1.5s; }
.particle-6 { right: 30%; top: 28%; animation-delay: 2.5s; }
.particle-7 { right: 18%; top: 70%; animation-delay: .8s; }
.particle-8 { right: 8%; top: 42%; animation-delay: 3.5s; }
.particle-9 { left: 38%; top: 90%; animation-delay: 4s; }
.particle-10 { right: 40%; top: 8%; animation-delay: 4.5s; }

@keyframes particleFloat {
    0%, 100% { transform: translate(0,0) scale(.8); opacity: .25; }
    25% { transform: translate(18px,-22px) scale(1.15); opacity: .7; }
    50% { transform: translate(-15px,-45px) scale(.9); opacity: .4; }
    75% { transform: translate(25px,-18px) scale(1.2); opacity: .65; }
}

/* =========================================================
   SEARCH
========================================================= */

.search-wrapper {
    width: 88%;
    max-width: 850px;
    margin: -38px auto 50px;
    position: relative;
    z-index: 20;
}

.search-box {
    display: flex;
    align-items: center;
    background: white;
    padding: 7px;
    border-radius: 50px;
    box-shadow: 0 18px 55px rgba(0,0,0,.12);
    border: 1px solid rgba(0,0,0,.04);
}

.search-icon {
    width: 52px;
    height: 52px;
    min-width: 52px;
    border-radius: 50%;
    display: flex;
    align-items: center;
    justify-content: center;
    background: #ff4b2b;
    color: white;
    font-size: 20px;
}

.search-box input {
    flex: 1;
    min-width: 0;
    border: none;
    outline: none;
    background: transparent;
    padding: 0 20px;
    font-family: inherit;
    font-size: 15px;
    color: #222;
}

.search-box input::placeholder {
    color: #999;
}

/* =========================================================
   CUISINE FILTERS
========================================================= */

.filter-section {
    width: 88%;
    max-width: 1250px;
    margin: 0 auto 40px;
}

.filter-title {
    font-family: 'Playfair Display', serif;
    font-size: 25px;
    margin-bottom: 17px;
}

.filters {
    display: flex;
    gap: 10px;
    flex-wrap: wrap;
}

.filter-btn {
    border: 1px solid #eee;
    background: white;
    color: #555;
    padding: 10px 18px;
    border-radius: 30px;
    font-family: inherit;
    font-size: 13px;
    font-weight: 700;
    cursor: pointer;
    transition: .3s;
}

.filter-btn:hover {
    border-color: #ff4b2b;
    color: #ff4b2b;
    transform: translateY(-2px);
}

.filter-btn.active {
    background: #ff4b2b;
    color: white;
    border-color: #ff4b2b;
    box-shadow: 0 8px 20px rgba(255,75,43,.20);
}

/* =========================================================
   RESTAURANT SECTION
========================================================= */

.restaurant-section {
    position: relative;
    width: 88%;
    max-width: 1250px;
    margin: 0 auto 90px;
}

.restaurant-section::before {
    content: "";
    position: absolute;
    width: 360px;
    height: 360px;
    left: -180px;
    top: 140px;
    border-radius: 50%;
    background: radial-gradient(circle, rgba(255,75,43,.07), transparent 70%);
    filter: blur(18px);
    pointer-events: none;
    animation: sectionGlow 9s ease-in-out infinite alternate;
}

@keyframes sectionGlow {
    from { transform: translate(0,0) scale(.9); opacity: .45; }
    to { transform: translate(90px,80px) scale(1.2); opacity: .9; }
}

.section-header {
    display: flex;
    align-items: flex-end;
    justify-content: space-between;
    gap: 20px;
    margin-bottom: 28px;
}

.section-header h2 {
    font-family: 'Playfair Display', serif;
    font-size: clamp(27px, 4vw, 38px);
    margin-bottom: 8px;
}

.section-header p {
    color: #888;
    font-size: 14px;
}

.restaurant-count {
    padding: 10px 15px;
    border-radius: 25px;
    background: #fff0e9;
    color: #ff4b2b;
    font-size: 13px;
    font-weight: 800;
    white-space: nowrap;
}

/* =========================================================
   RESTAURANT GRID AND CARDS
========================================================= */

.restaurant-grid {
    display: grid;
    grid-template-columns: repeat(3, minmax(0, 1fr));
    gap: 28px;
}

.restaurant-card {
    position: relative;
    overflow: hidden;
    background: rgba(255,255,255,.96);
    border: 1px solid rgba(0,0,0,.06);
    border-radius: 22px;
    box-shadow: 0 10px 30px rgba(0,0,0,.055);
    transition: transform .4s ease, box-shadow .4s ease, border-color .4s ease;
    animation: cardAppear .7s ease both;
}

.restaurant-card:hover {
    transform: translateY(-9px);
    border-color: rgba(255,75,43,.45);
    box-shadow:
        0 20px 45px rgba(255,75,43,.14),
        0 0 25px rgba(255,193,7,.10);
}

@keyframes cardAppear {
    from { opacity: 0; transform: translateY(22px); }
    to { opacity: 1; transform: translateY(0); }
}

.restaurant-image {
    height: 225px;
    position: relative;
    overflow: hidden;
    background: #fff0e9;
}

.restaurant-image img {
    display: block;
    width: 100%;
    height: 100%;
    object-fit: cover;
    transition: transform .7s ease;
}

.restaurant-card:hover .restaurant-image img {
    transform: scale(1.08);
}

.image-overlay {
    position: absolute;
    inset: 0;
    background: linear-gradient(to top, rgba(0,0,0,.28), transparent 55%);
    pointer-events: none;
}

.rating {
    position: absolute;
    left: 14px;
    top: 14px;
    display: flex;
    align-items: center;
    gap: 5px;
    padding: 7px 11px;
    border-radius: 25px;
    background: rgba(255,255,255,.96);
    color: #222;
    font-size: 13px;
    font-weight: 800;
    box-shadow: 0 4px 12px rgba(0,0,0,.1);
}

.rating-star {
    color: #ffad00;
    font-size: 16px;
}

.status {
    position: absolute;
    right: 14px;
    top: 14px;
    padding: 7px 10px;
    border-radius: 25px;
    font-size: 10px;
    font-weight: 800;
    letter-spacing: .4px;
}

.status.open {
    background: #e6fff0;
    color: #168447;
}

.status.closed {
    background: #ffe8e6;
    color: #c62828;
}

.restaurant-content {
    padding: 21px;
}

.restaurant-name {
    color: #202020;
    font-family: 'Playfair Display', serif;
    font-size: 23px;
    line-height: 1.3;
    margin-bottom: 8px;
    overflow-wrap: anywhere;
}

.cuisine {
    display: inline-block;
    color: #ff4b2b;
    background: #fff0e9;
    padding: 6px 11px;
    border-radius: 20px;
    font-size: 11px;
    font-weight: 800;
    margin-bottom: 18px;
}

.restaurant-info {
    display: grid;
    gap: 13px;
    margin-bottom: 21px;
}

.info-row {
    display: flex;
    align-items: flex-start;
    gap: 10px;
    color: #777;
    font-size: 13px;
    line-height: 1.6;
}

.info-icon {
    display: flex;
    align-items: center;
    justify-content: center;
    flex: 0 0 29px;
    width: 29px;
    height: 29px;
    border-radius: 9px;
    background: #fff3ed;
    font-size: 14px;
}

.info-row span {
    padding-top: 4px;
    overflow-wrap: anywhere;
}

.explore-btn {
    display: flex;
    align-items: center;
    justify-content: center;
    gap: 8px;
    width: 100%;
    padding: 13px 16px;
    border-radius: 12px;
    background: #202020;
    color: white;
    text-decoration: none;
    font-size: 13px;
    font-weight: 800;
    transition: background .3s ease, box-shadow .3s ease, transform .3s ease;
}

.explore-btn:hover {
    background: linear-gradient(135deg, #ff4b2b, #ff8a00);
    box-shadow: 0 8px 20px rgba(255,75,43,.22);
    transform: translateY(-2px);
}

/* =========================================================
   EMPTY STATE
========================================================= */

.empty-state {
    padding: 60px 20px;
    text-align: center;
    background: rgba(255,255,255,.88);
    border: 1px dashed #ffd0c1;
    border-radius: 22px;
    margin: 20px 0;
}

.empty-icon {
    font-size: 48px;
    margin-bottom: 18px;
}

.empty-state h3 {
    font-family: 'Playfair Display', serif;
    font-size: 25px;
    margin-bottom: 10px;
}

.empty-state p {
    color: #888;
    font-size: 14px;
    line-height: 1.7;
}

/* =========================================================
   FOOTER
========================================================= */

footer {
    position: relative;
    padding: 42px 20px;
    text-align: center;
    background: #202020;
    color: white;
    overflow: hidden;
}

footer::before {
    content: "";
    position: absolute;
    width: 300px;
    height: 300px;
    top: -220px;
    left: calc(50% - 150px);
    border-radius: 50%;
    background: rgba(255,75,43,.3);
    filter: blur(45px);
}

.footer-logo {
    position: relative;
    font-family: 'Playfair Display', serif;
    font-size: 29px;
    font-weight: 800;
    color: #ff4b2b;
    margin-bottom: 12px;
}

.footer-logo span {
    color: white;
}

footer p {
    position: relative;
    color: #bbb;
    font-size: 13px;
    line-height: 1.8;
}

/* =========================================================
   RESPONSIVE
========================================================= */

@media (max-width: 1000px) {
    .restaurant-grid {
        grid-template-columns: repeat(2, minmax(0, 1fr));
    }

    .restaurant-section,
    .filter-section {
        width: 92%;
    }

    .search-wrapper {
        width: 92%;
    }
}

@media (max-width: 650px) {
    .navbar {
        padding: 12px 4%;
        min-height: 70px;
        gap: 12px;
    }

    .logo {
        font-size: 24px;
    }

    .nav-right {
        gap: 8px;
    }

    .nav-link {
        display: none;
    }

    .nav-button {
        padding: 10px 12px;
        font-size: 12px;
    }

    .hero {
        min-height: 410px;
    }

    .hero h1 {
        font-size: 44px;
        letter-spacing: -1px;
    }

    .hero-description {
        font-size: 15px;
    }

    .restaurant-grid {
        grid-template-columns: 1fr;
    }

    .restaurant-section,
    .filter-section {
        width: 92%;
    }

    .search-wrapper {
        width: 92%;
    }

    .section-header {
        flex-direction: column;
        align-items: flex-start;
        gap: 12px;
    }

    .food {
        font-size: 28px;
    }

    .restaurant-image {
        height: 230px;
    }

    .profile-dropdown {
        right: -5px;
        width: 225px;
    }
}

@media (max-width: 420px) {
    .logo {
        font-size: 21px;
    }

    .nav-button {
        padding: 9px 10px;
        font-size: 11px;
    }

    .profile-btn {
        width: 38px;
        height: 38px;
    }

    .hero h1 {
        font-size: 39px;
    }

    .restaurant-image {
        height: 220px;
    }

    .search-box input {
        padding: 0 12px;
        font-size: 13px;
    }

    .search-icon {
        width: 44px;
        height: 44px;
        min-width: 44px;
    }
}

/* =========================================================
   REDUCED MOTION ACCESSIBILITY
========================================================= */

@media (prefers-reduced-motion: reduce) {
    *,
    *::before,
    *::after {
        animation-duration: .01ms !important;
        animation-iteration-count: 1 !important;
        scroll-behavior: auto !important;
        transition-duration: .01ms !important;
    }
}
</style>
</head>

<body>

<!-- =====================================================
     NAVBAR
     No static navbar include here.
     This prevents duplicate contextPath and loggedInUser
     declarations from navbar.jsp.
====================================================== -->

<nav class="navbar">

    <a href="${pageContext.request.contextPath}/restaurant"
       class="logo">
        Foodie<span>Hub</span>
    </a>

    <div class="nav-right">

        <a href="${pageContext.request.contextPath}/restaurant"
           class="nav-link">
            Restaurants
        </a>

        <a href="${pageContext.request.contextPath}/orders"
           class="nav-link">
            📦 Orders
        </a>

        <a href="${pageContext.request.contextPath}/cart"
           class="nav-button">
            🛒 Cart
        </a>

        <%
            com.tap.model.User restaurantLoggedInUser =
                (com.tap.model.User) session.getAttribute("loggedInUser");
        %>

        <% if (restaurantLoggedInUser != null) { %>

            <div class="profile-wrapper">

                <button type="button"
                        class="profile-btn"
                        id="restaurantProfileButton"
                        onclick="toggleRestaurantProfile(event)"
                        aria-label="Open profile menu">
                    👤
                </button>

                <div class="profile-dropdown"
                     id="restaurantProfileDropdown">

                    <div class="profile-user">
                        <small>Logged in as</small>

                        <div class="profile-username">
                            <%= restaurantLoggedInUser.getUsername() != null
                                ? restaurantLoggedInUser.getUsername()
                                : "FoodieHub User" %>
                        </div>
                    </div>

                    <a class="profile-menu-link"
                       href="${pageContext.request.contextPath}/profile.jsp">
                        👤 My Profile
                    </a>

                    <a class="profile-menu-link"
                       href="${pageContext.request.contextPath}/orders">
                        📦 My Orders
                    </a>

                    <a class="profile-menu-link"
                       href="${pageContext.request.contextPath}/logout">
                        🚪 Logout
                    </a>

                </div>

            </div>

        <% } else { %>

            <a href="${pageContext.request.contextPath}/login.jsp"
               class="nav-button">
                Login
            </a>

        <% } %>

    </div>

</nav>


<!-- =====================================================
     HERO
====================================================== -->

<section class="hero">

    <div class="food food-one">🍕</div>
    <div class="food food-two">🍔</div>
    <div class="food food-three">🍜</div>
    <div class="food food-four">🍰</div>

    <div class="particle particle-1"></div>
    <div class="particle particle-2"></div>
    <div class="particle particle-3"></div>
    <div class="particle particle-4"></div>
    <div class="particle particle-5"></div>
    <div class="particle particle-6"></div>
    <div class="particle particle-7"></div>
    <div class="particle particle-8"></div>
    <div class="particle particle-9"></div>
    <div class="particle particle-10"></div>

    <div class="hero-content">

        <div class="hero-badge">
            ✨ DISCOVER YOUR NEXT FAVOURITE
        </div>

        <h1>
            Good Food.<br>
            <span>Great Mood.</span>
        </h1>

        <p class="hero-description">
            Explore the best restaurants around you,
            discover delicious dishes and enjoy every
            bite with FoodieHub.
        </p>

    </div>

</section>


<!-- =====================================================
     SEARCH
====================================================== -->

<div class="search-wrapper">

    <div class="search-box">

        <div class="search-icon">🔍</div>

        <input type="text"
               id="restaurantSearch"
               placeholder="Search restaurants, cuisines..."
               autocomplete="off">

    </div>

</div>


<!-- =====================================================
     CUISINE FILTER
====================================================== -->

<section class="filter-section">

    <h3 class="filter-title">
        Explore by Cuisine
    </h3>

    <div class="filters">

        <button class="filter-btn active"
                data-filter="all">
            All
        </button>

        <button class="filter-btn"
                data-filter="south indian">
            South Indian
        </button>

        <button class="filter-btn"
                data-filter="north indian">
            North Indian
        </button>

        <button class="filter-btn"
                data-filter="biryani">
            Biryani
        </button>

        <button class="filter-btn"
                data-filter="chinese">
            Chinese
        </button>

        <button class="filter-btn"
                data-filter="multi cuisine">
            Multi Cuisine
        </button>

    </div>

</section>


<!-- =====================================================
     RESTAURANTS
====================================================== -->

<section class="restaurant-section">

    <div class="section-header">

        <div>
            <h2>Popular Restaurants</h2>
            <p>Find your perfect place to eat.</p>
        </div>

        <div class="restaurant-count">
            <%= restaurants != null ? restaurants.size() : 0 %>
            Restaurants
        </div>

    </div>

    <%
        if (restaurants != null && !restaurants.isEmpty()) {
    %>

        <div class="restaurant-grid" id="restaurantGrid">

            <%
                for (Restaurant restaurant : restaurants) {

                    String imagePath = restaurant.getImagePath();

                    if (imagePath == null || imagePath.trim().isEmpty()) {
                        imagePath =
                            "https://via.placeholder.com/800x500?text=FoodieHub";
                    }

                    String restaurantName =
                        restaurant.getName() != null
                            ? restaurant.getName()
                            : "Restaurant";

                    String cuisineType =
                        restaurant.getCuisineType() != null
                            ? restaurant.getCuisineType()
                            : "Multi Cuisine";

                    String restaurantAddress =
                        restaurant.getAddress() != null
                            ? restaurant.getAddress()
                            : "Address not available";

                    String deliveryTime =
                        restaurant.getDeliveryTime() != null
                            ? String.valueOf(restaurant.getDeliveryTime())
                            : "Delivery time unavailable";

                    String searchData =
                        (restaurantName + " " + cuisineType + " "
                            + restaurantAddress).toLowerCase();

                    String safeSearchData =
                        searchData.replace("&", "&amp;")
                                  .replace("\"", "&quot;")
                                  .replace("<", "&lt;")
                                  .replace(">", "&gt;");

                    String safeCuisine =
                        cuisineType.toLowerCase()
                                   .replace("&", "&amp;")
                                   .replace("\"", "&quot;")
                                   .replace("<", "&lt;")
                                   .replace(">", "&gt;");
            %>

                <article class="restaurant-card"
                         data-search="<%= safeSearchData %>"
                         data-cuisine="<%= safeCuisine %>">

                    <div class="restaurant-image">

                        <img src="<%= imagePath %>"
                             alt="<%= restaurantName %>"
                             loading="lazy"
                             onerror="this.onerror=null;this.src='https://via.placeholder.com/800x500?text=FoodieHub';">

                        <div class="image-overlay"></div>

                        <div class="rating">
                            <span class="rating-star">★</span>

                            <%= String.format(
                                java.util.Locale.US,
                                "%.1f",
                                restaurant.getRating()
                            ) %>
                        </div>

                        <% if (restaurant.isActive()) { %>

                            <div class="status open">
                                ● OPEN
                            </div>

                        <% } else { %>

                            <div class="status closed">
                                ● CLOSED
                            </div>

                        <% } %>

                    </div>

                    <div class="restaurant-content">

                        <h3 class="restaurant-name">
                            <%= restaurantName %>
                        </h3>

                        <div class="cuisine">
                            <%= cuisineType %>
                        </div>

                        <div class="restaurant-info">

                            <div class="info-row">
                                <div class="info-icon">📍</div>

                                <span>
                                    <%= restaurantAddress %>
                                </span>
                            </div>

                            <div class="info-row">
                                <div class="info-icon">🛵</div>

                                <span>
                                    <%= deliveryTime %>
                                </span>
                            </div>

                        </div>

                        <a href="${pageContext.request.contextPath}/menu?restaurantId=<%= restaurant.getRestaurantId() %>"
                           class="explore-btn">
                            Explore Menu &nbsp; →
                        </a>

                    </div>

                </article>

            <%
                }
            %>

        </div>

        <div id="noResults"
             class="empty-state"
             style="display:none;">

            <div class="empty-icon">🔍</div>

            <h3>No restaurants found</h3>

            <p>
                Try another restaurant name or cuisine.
            </p>

        </div>

    <%
        } else {
    %>

        <div class="empty-state">

            <div class="empty-icon">🍽️</div>

            <h3>No Restaurants Available</h3>

            <p>
                Restaurants will appear here once they
                are added to FoodieHub.
            </p>

        </div>

    <%
        }
    %>

</section>


<!-- =====================================================
     FOOTER
====================================================== -->

<footer>

    <div class="footer-logo">
        Foodie<span>Hub</span>
    </div>

    <p>
        Discover delicious food.<br>
        Delivered with love. ❤️
    </p>

</footer>


<!-- =====================================================
     JAVASCRIPT
====================================================== -->

<script>

/* =========================================================
   PROFILE DROPDOWN
========================================================= */

function toggleRestaurantProfile(event) {

    event.stopPropagation();

    const dropdown =
        document.getElementById("restaurantProfileDropdown");

    if (dropdown) {
        dropdown.classList.toggle("show");
    }
}

document.addEventListener("click", function(event) {

    const dropdown =
        document.getElementById("restaurantProfileDropdown");

    const button =
        document.getElementById("restaurantProfileButton");

    if (!dropdown) {
        return;
    }

    if (
        !dropdown.contains(event.target) &&
        (!button || !button.contains(event.target))
    ) {
        dropdown.classList.remove("show");
    }
});


/* =========================================================
   SEARCH AND CUISINE FILTER
========================================================= */

const searchInput =
    document.getElementById("restaurantSearch");

const cards =
    document.querySelectorAll(".restaurant-card");

const filterButtons =
    document.querySelectorAll(".filter-btn");

const noResults =
    document.getElementById("noResults");

let currentFilter = "all";


function filterRestaurants() {

    const searchValue = searchInput
        ? searchInput.value.toLowerCase().trim()
        : "";

    let visibleCount = 0;

    cards.forEach(function(card) {

        const searchData =
            (card.getAttribute("data-search") || "").toLowerCase();

        const cuisine =
            (card.getAttribute("data-cuisine") || "").toLowerCase();

        const matchesSearch =
            searchData.includes(searchValue);

        const matchesCuisine =
            currentFilter === "all" ||
            cuisine.includes(currentFilter);

        if (matchesSearch && matchesCuisine) {

            card.style.display = "";

            visibleCount++;

        } else {

            card.style.display = "none";

        }
    });

    if (noResults) {
        noResults.style.display =
            visibleCount === 0 ? "block" : "none";
    }
}


/* Search input */

if (searchInput) {

    searchInput.addEventListener(
        "input",
        filterRestaurants
    );

}


/* Cuisine buttons */

filterButtons.forEach(function(button) {

    button.addEventListener("click", function() {

        filterButtons.forEach(function(btn) {
            btn.classList.remove("active");
        });

        this.classList.add("active");

        currentFilter =
            this.getAttribute("data-filter") || "all";

        filterRestaurants();

    });

});

</script>

</body>
</html>