<%@ page language="java"
    contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!DOCTYPE html>

<html lang="en">

<head>

    <meta charset="UTF-8">

    <meta name="viewport"
          content="width=device-width, initial-scale=1.0">

    <title>FoodieHub | Sign Up</title>


    <!-- GOOGLE FONTS -->

    <link rel="preconnect"
          href="https://fonts.googleapis.com">

    <link rel="preconnect"
          href="https://fonts.gstatic.com"
          crossorigin>

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

    min-height: 100vh;

    font-family:
        'DM Sans',
        sans-serif;

    background:
        #fffaf5;

    color:
        #202020;

    overflow-x:
        hidden;
}


/* =========================================================
   BACKGROUND
========================================================= */

body::before {

    content: "";

    position: fixed;

    inset: -20%;

    z-index: -5;

    background:

        radial-gradient(
            circle at 10% 15%,
            rgba(255,75,43,.15),
            transparent 25%
        ),

        radial-gradient(
            circle at 90% 20%,
            rgba(255,138,0,.14),
            transparent 25%
        ),

        radial-gradient(
            circle at 20% 85%,
            rgba(255,75,43,.10),
            transparent 25%
        ),

        radial-gradient(
            circle at 85% 85%,
            rgba(255,138,0,.10),
            transparent 25%
        );

    filter:
        blur(25px);

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
            translate(-2%, -1%)
            scale(1);
    }

    50% {

        transform:
            translate(3%, 3%)
            scale(1.05);
    }

    100% {

        transform:
            translate(-1%, -2%)
            scale(1.08);
    }
}


/* =========================================================
   SIGNUP PAGE
========================================================= */

.signup-page {

    min-height:
        calc(100vh - 76px);

    display:
        flex;

    align-items:
        center;

    justify-content:
        center;

    padding:
        45px 20px 70px;

    position:
        relative;

    overflow:
        hidden;
}


/* =========================================================
   FLOATING FOOD
========================================================= */

.food {

    position:
        absolute;

    font-size:
        44px;

    filter:
        drop-shadow(
            0 12px 15px
            rgba(0,0,0,.12)
        );
}


.food-one {

    left:
        9%;

    top:
        15%;

    animation:
        floatOne
        6s
        ease-in-out
        infinite;
}


.food-two {

    right:
        9%;

    top:
        18%;

    animation:
        floatTwo
        7s
        ease-in-out
        infinite;
}


.food-three {

    left:
        15%;

    bottom:
        12%;

    animation:
        floatThree
        6.5s
        ease-in-out
        infinite;
}


.food-four {

    right:
        15%;

    bottom:
        12%;

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
            translateY(25px)
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
            translate(-18px,-22px)
            rotate(-8deg);
    }
}


/* =========================================================
   SIGNUP CARD
========================================================= */

.signup-card {

    width:
        min(500px,94%);

    padding:
        36px;

    border-radius:
        30px;

    background:
        rgba(255,255,255,.86);

    border:
        1px solid
        rgba(255,255,255,.95);

    box-shadow:
        0 25px 70px
        rgba(0,0,0,.09);

    backdrop-filter:
        blur(25px);

    -webkit-backdrop-filter:
        blur(25px);

    position:
        relative;

    z-index:
        5;

    animation:
        cardReveal
        .9s
        cubic-bezier(.16,1,.3,1)
        forwards;
}


@keyframes cardReveal {

    from {

        opacity:
            0;

        transform:
            translateY(45px)
            scale(.94);
    }

    to {

        opacity:
            1;

        transform:
            translateY(0)
            scale(1);
    }
}


/* =========================================================
   ICON
========================================================= */

.signup-icon {

    width:
        68px;

    height:
        68px;

    margin:
        0 auto 18px;

    display:
        flex;

    align-items:
        center;

    justify-content:
        center;

    border-radius:
        21px;

    background:
        linear-gradient(
            135deg,
            #ff4b2b,
            #ff8a00
        );

    color:
        white;

    font-size:
        29px;

    box-shadow:
        0 12px 30px
        rgba(255,75,43,.25);

    animation:
        iconFloat
        4s
        ease-in-out
        infinite;
}


@keyframes iconFloat {

    0%,100% {

        transform:
            translateY(0)
            rotate(0);
    }

    50% {

        transform:
            translateY(-7px)
            rotate(3deg);
    }
}


/* =========================================================
   HEADING
========================================================= */

.signup-card h1 {

    text-align:
        center;

    font-family:
        'Playfair Display',
        Georgia,
        serif;

    font-size:
        37px;

    letter-spacing:
        -1px;
}


.signup-card h1 span {

    color:
        #ff4b2b;
}


.signup-subtitle {

    text-align:
        center;

    color:
        #888;

    font-size:
        13px;

    line-height:
        1.6;

    margin:
        9px auto 25px;
}


/* =========================================================
   ERROR
========================================================= */

.error-message {

    padding:
        12px 14px;

    margin-bottom:
        18px;

    border-radius:
        13px;

    background:
        #fff0e8;

    border:
        1px solid
        rgba(255,75,43,.15);

    color:
        #d93618;

    font-size:
        12px;

    font-weight:
        700;

    text-align:
        center;

    animation:
        errorShake
        .4s
        ease;
}


@keyframes errorShake {

    0%,100% {
        transform:
            translateX(0);
    }

    25% {
        transform:
            translateX(-5px);
    }

    75% {
        transform:
            translateX(5px);
    }
}


/* =========================================================
   FORM GRID
========================================================= */

.form-grid {

    display:
        grid;

    grid-template-columns:
        1fr 1fr;

    gap:
        16px;
}


.form-group {

    display:
        flex;

    flex-direction:
        column;

    gap:
        7px;
}


.form-group.full {

    grid-column:
        1 / -1;
}


.form-group label {

    margin-left:
        3px;

    font-size:
        12px;

    font-weight:
        800;

    color:
        #444;
}


/* =========================================================
   INPUT
========================================================= */

.input-wrapper {

    position:
        relative;
}


.input-wrapper input {

    width:
        100%;

    padding:
        13px 15px;

    border:
        1px solid
        rgba(0,0,0,.09);

    border-radius:
        14px;

    background:
        rgba(255,255,255,.72);

    outline:
        none;

    font-family:
        inherit;

    font-size:
        13px;

    color:
        #222;

    transition:
        all .3s ease;
}


.input-wrapper input::placeholder {

    color:
        #aaa;
}


.input-wrapper input:focus {

    border-color:
        rgba(255,75,43,.55);

    box-shadow:
        0 0 0 4px
        rgba(255,75,43,.08);

    transform:
        translateY(-1px);
}


/* =========================================================
   PASSWORD INPUT
========================================================= */

.password-wrapper input {

    padding-right:
        48px;
}


/* =========================================================
   PASSWORD EYE BUTTON
========================================================= */

.password-toggle {

    position:
        absolute;

    right:
        8px;

    top:
        50%;

    width:
        38px;

    height:
        38px;

    transform:
        translateY(-50%);

    border:
        none;

    background:
        transparent;

    cursor:
        pointer;

    display:
        flex;

    align-items:
        center;

    justify-content:
        center;

    color:
        #777;

    opacity:
        .75;

    border-radius:
        10px;

    transition:
        all .25s ease;

    z-index:
        10;
}


.password-toggle:hover {

    opacity:
        1;

    background:
        #fff0e8;

    color:
        #ff4b2b;

    transform:
        translateY(-50%)
        scale(1.05);
}


.password-toggle:focus {

    outline:
        2px solid
        rgba(255,75,43,.25);

    outline-offset:
        2px;
}


.password-toggle svg {

    width:
        20px;

    height:
        20px;

    pointer-events:
        none;
}


/* =========================================================
   SIGNUP BUTTON
========================================================= */

.signup-btn {

    width:
        100%;

    margin-top:
        21px;

    padding:
        15px;

    border:
        none;

    border-radius:
        15px;

    background:
        linear-gradient(
            135deg,
            #ff4b2b,
            #ff8a00
        );

    color:
        white;

    font-family:
        inherit;

    font-size:
        13px;

    font-weight:
        900;

    cursor:
        pointer;

    box-shadow:
        0 12px 28px
        rgba(255,75,43,.22);

    transition:
        all .4s ease;
}


.signup-btn:hover {

    transform:
        translateY(-3px);

    box-shadow:
        0 17px 35px
        rgba(255,75,43,.30);
}


/* =========================================================
   LOGIN
========================================================= */

.login-section {

    text-align:
        center;

    margin-top:
        23px;

    padding-top:
        21px;

    border-top:
        1px solid
        rgba(0,0,0,.07);
}


.login-section p {

    color:
        #888;

    font-size:
        12px;

    margin-bottom:
        7px;
}


.login-link {

    color:
        #ff4b2b;

    text-decoration:
        none;

    font-size:
        13px;

    font-weight:
        900;
}


.login-link:hover {

    color:
        #ff8a00;
}


/* =========================================================
   BACK
========================================================= */

.back-link {

    display:
        block;

    text-align:
        center;

    margin-top:
        17px;

    color:
        #999;

    text-decoration:
        none;

    font-size:
        11px;

    font-weight:
        700;
}


.back-link:hover {

    color:
        #ff4b2b;
}


/* =========================================================
   RESPONSIVE
========================================================= */

@media(max-width:650px) {

    .signup-page {

        padding:
            35px 15px 50px;
    }


    .signup-card {

        padding:
            28px 21px;

        border-radius:
            24px;
    }


    .signup-card h1 {

        font-size:
            33px;
    }


    .form-grid {

        grid-template-columns:
            1fr;
    }


    .form-group.full {

        grid-column:
            auto;
    }


    .food {

        font-size:
            28px;

        opacity:
            .55;
    }


    .food-one {
        left: 3%;
    }


    .food-two {
        right: 3%;
    }


    .food-three {
        left: 5%;
    }


    .food-four {
        right: 5%;
    }

}

</style>

</head>


<body>


<!-- =====================================================
     CORRECT NAVBAR PATH
====================================================== -->

<%@ include file="components/navbar.jsp" %>


<!-- =====================================================
     SIGNUP PAGE
====================================================== -->

<section class="signup-page">


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


    <div class="signup-card">


        <div class="signup-icon">
            ✨
        </div>


        <h1>

            Join
            <span>FoodieHub.</span>

        </h1>


        <p class="signup-subtitle">

            Create your account and start
            discovering delicious food.

        </p>


        <!-- ERROR -->

        <%
            String error =
                (String) request.getAttribute("error");

            if (error != null) {
        %>

            <div class="error-message">

                <%= error %>

            </div>

        <%
            }
        %>


        <!-- SIGNUP FORM -->

        <form
            action="signup"
            method="post"
            id="signupForm">


            <div class="form-grid">


                <!-- USERNAME -->

                <div class="form-group">

                    <label for="username">

                        Username *

                    </label>


                    <div class="input-wrapper">

                        <input
                            type="text"
                            id="username"
                            name="username"
                            placeholder="Choose a username"
                            autocomplete="username"
                            required>

                    </div>

                </div>


                <!-- PASSWORD -->

                <div class="form-group">

                    <label for="signupPassword">

                        Password *

                    </label>


                    <div
                        class="input-wrapper password-wrapper">


                        <input
                            type="password"
                            id="signupPassword"
                            name="password"
                            placeholder="Create a password"
                            autocomplete="new-password"
                            required>


                        <button
                            type="button"
                            class="password-toggle"
                            data-target="signupPassword"
                            aria-label="Show password"
                            title="Show password">


                            <svg
                                class="eye-icon"
                                viewBox="0 0 24 24"
                                fill="none"
                                stroke="currentColor"
                                stroke-width="2"
                                stroke-linecap="round"
                                stroke-linejoin="round">

                                <path
                                    d="M2 12s3.5-6 10-6 10 6 10 6-3.5 6-10 6S2 12 2 12z">
                                </path>

                                <circle
                                    cx="12"
                                    cy="12"
                                    r="2.5">
                                </circle>

                            </svg>

                        </button>


                    </div>

                </div>


                <!-- EMAIL -->

                <div class="form-group">

                    <label for="email">

                        Email *

                    </label>


                    <div class="input-wrapper">

                        <input
                            type="email"
                            id="email"
                            name="email"
                            placeholder="Enter your email"
                            autocomplete="email"
                            required>

                    </div>

                </div>


                <!-- PHONE -->

                <div class="form-group">

                    <label for="phone">

                        Phone *

                    </label>


                    <div class="input-wrapper">

                        <input
                            type="tel"
                            id="phone"
                            name="phone"
                            placeholder="10-digit mobile number"
                            maxlength="10"
                            autocomplete="tel"
                            required>

                    </div>

                </div>


                <!-- ADDRESS -->

                <div class="form-group full">

                    <label for="address">

                        Address *

                    </label>


                    <div class="input-wrapper">

                        <input
                            type="text"
                            id="address"
                            name="address"
                            placeholder="Enter your complete address"
                            autocomplete="street-address"
                            required>

                    </div>

                </div>


            </div>


            <!-- CREATE ACCOUNT -->

            <button
                type="submit"
                class="signup-btn">

                Create Account
                &nbsp; →

            </button>


        </form>


        <!-- LOGIN -->

        <div class="login-section">

            <p>

                Already have an account?

            </p>


            <a
                href="login.jsp"
                class="login-link">

                Login to FoodieHub

            </a>

        </div>


        <!-- BACK -->

        <a
            href="restaurant"
            class="back-link">

            ← Back to Restaurants

        </a>


    </div>

</section>


<!-- =====================================================
     PASSWORD TOGGLE
====================================================== -->

<script>

document.addEventListener(
    "DOMContentLoaded",
    function() {


        const passwordButtons =
            document.querySelectorAll(
                ".password-toggle"
            );


        passwordButtons.forEach(
            function(button) {


                button.addEventListener(
                    "click",
                    function(event) {


                        /*
                         * Prevent form submission.
                         */

                        event.preventDefault();


                        /*
                         * Get exact password
                         * input ID.
                         */

                        const targetId =
                            button.getAttribute(
                                "data-target"
                            );


                        const passwordInput =
                            document.getElementById(
                                targetId
                            );


                        if (!passwordInput) {

                            return;

                        }


                        const eyeIcon =
                            button.querySelector(
                                ".eye-icon"
                            );


                        /*
                         * SHOW PASSWORD
                         */

                        if (
                            passwordInput.type ===
                            "password"
                        ) {


                            passwordInput.type =
                                "text";


                            button.setAttribute(
                                "aria-label",
                                "Hide password"
                            );


                            button.setAttribute(
                                "title",
                                "Hide password"
                            );


                            eyeIcon.innerHTML = `

                                <path
                                    d="M3 3l18 18">
                                </path>

                                <path
                                    d="M10.6 10.6a2 2 0 0 0 2.8 2.8">
                                </path>

                                <path
                                    d="M9.9 4.3A10.7 10.7 0 0 1 12 4c7 0 10 8 10 8a17.7 17.7 0 0 1-3.1 4.4">
                                </path>

                                <path
                                    d="M6.2 6.2C3.5 8.1 2 12 2 12s3.5 8 10 8c1.5 0 2.8-.3 4-.9">
                                </path>

                            `;

                        }


                        /*
                         * HIDE PASSWORD
                         */

                        else {


                            passwordInput.type =
                                "password";


                            button.setAttribute(
                                "aria-label",
                                "Show password"
                            );


                            button.setAttribute(
                                "title",
                                "Show password"
                            );


                            eyeIcon.innerHTML = `

                                <path
                                    d="M2 12s3.5-6 10-6 10 6 10 6-3.5 6-10 6S2 12 2 12z">
                                </path>

                                <circle
                                    cx="12"
                                    cy="12"
                                    r="2.5">
                                </circle>

                            `;

                        }

                    }
                );

            }
        );

    }
);


/* =========================================================
   PHONE VALIDATION
========================================================= */

document
    .getElementById("signupForm")
    .addEventListener(
        "submit",
        function(event) {


            const phone =
                document
                    .getElementById("phone")
                    .value
                    .trim();


            if (
                !/^[0-9]{10}$/.test(phone)
            ) {


                event.preventDefault();


                alert(
                    "Please enter a valid 10-digit mobile number."
                );


                document
                    .getElementById("phone")
                    .focus();

            }

        }
    );


/* =========================================================
   PHONE NUMBERS ONLY
========================================================= */

document
    .getElementById("phone")
    .addEventListener(
        "input",
        function() {

            this.value =
                this.value.replace(
                    /[^0-9]/g,
                    ""
                );

        }
    );

</script>


</body>

</html>