<%@ page language="java"
    contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ page import="com.tap.model.User" %>

<%
    String contextPath = request.getContextPath();

    User loggedInUser =
        (User) session.getAttribute("loggedInUser");
%>

<style>
.fh-navbar,
.fh-navbar * {
    box-sizing: border-box;
}

.fh-navbar {
    width: 100%;
    min-height: 100px;
    padding: 18px 6%;
    background: #ffffff;
    display: flex;
    align-items: center;
    justify-content: space-between;
    gap: 25px;
    position: relative;
    z-index: 1000;
    box-shadow: 0 4px 20px rgba(40, 25, 15, 0.04);
    font-family: 'DM Sans', Arial, sans-serif;
}

.fh-logo {
    text-decoration: none;
    color: #202020;
    font-family: 'Playfair Display', Georgia, serif;
    font-size: 38px;
    font-weight: 800;
    letter-spacing: -1.5px;
    white-space: nowrap;
}

.fh-logo span {
    color: #ff4b2b;
}

.fh-nav-links {
    display: flex;
    align-items: center;
    justify-content: flex-end;
    gap: 14px;
    flex-wrap: wrap;
}

.fh-nav-link {
    display: inline-flex;
    align-items: center;
    justify-content: center;
    gap: 9px;
    padding: 15px 22px;
    border: 1px solid transparent;
    border-radius: 20px;
    color: #292929;
    background: transparent;
    font-size: 17px;
    font-weight: 800;
    text-decoration: none;
    white-space: nowrap;
    transition: all 0.25s ease;
}

.fh-nav-link:hover {
    color: #ff4b2b;
    background: #fff3ed;
    border-color: #ffded2;
    transform: translateY(-2px);
}

.fh-cart-link {
    color: #ffffff;
    background: #ff4b2b;
    box-shadow: 0 8px 22px rgba(255, 75, 43, 0.18);
}

.fh-cart-link:hover {
    color: #ffffff;
    background: #e83b20;
    border-color: #e83b20;
}

.fh-orders-link {
    color: #ff4b2b;
    background: #fff4ef;
    border-color: #ffdbd0;
}

.fh-profile {
    position: relative;
}

.fh-profile-button {
    width: 62px;
    height: 62px;
    border: none;
    border-radius: 50%;
    background: #fff5ef;
    box-shadow: 0 5px 20px rgba(40, 25, 15, 0.07);
    cursor: pointer;
    font-size: 29px;
    display: flex;
    align-items: center;
    justify-content: center;
    transition: all 0.25s ease;
}

.fh-profile-button:hover {
    background: #ffe7dc;
    transform: translateY(-2px);
}

.fh-profile-menu {
    display: none;
    position: absolute;
    top: 75px;
    right: 0;
    width: 235px;
    background: #ffffff;
    border: 1px solid #f0e5de;
    border-radius: 16px;
    padding: 12px;
    box-shadow: 0 15px 40px rgba(30, 20, 15, 0.14);
    z-index: 2000;
}

.fh-profile-menu.show {
    display: block;
    animation: fhDropdown 0.2s ease;
}

@keyframes fhDropdown {
    from {
        opacity: 0;
        transform: translateY(-7px);
    }
    to {
        opacity: 1;
        transform: translateY(0);
    }
}

.fh-profile-name {
    padding: 12px;
    border-bottom: 1px solid #f1e8e2;
    margin-bottom: 7px;
    overflow-wrap: anywhere;
}

.fh-profile-name strong {
    display: block;
    color: #242424;
    font-size: 15px;
}

.fh-profile-name small {
    display: block;
    color: #888888;
    margin-top: 5px;
    font-size: 12px;
}

.fh-dropdown-link {
    display: block;
    padding: 12px;
    border-radius: 9px;
    color: #333333;
    font-size: 14px;
    font-weight: 700;
    text-decoration: none;
    transition: background 0.2s ease;
}

.fh-dropdown-link:hover {
    color: #ff4b2b;
    background: #fff3ed;
}

@media (max-width: 900px) {
    .fh-navbar {
        padding: 17px 4%;
        gap: 15px;
    }

    .fh-logo {
        font-size: 31px;
    }

    .fh-nav-links {
        gap: 7px;
    }

    .fh-nav-link {
        padding: 12px 14px;
        font-size: 14px;
    }

    .fh-profile-button {
        width: 50px;
        height: 50px;
        font-size: 24px;
    }
}

@media (max-width: 650px) {
    .fh-navbar {
        flex-direction: column;
        align-items: stretch;
        gap: 14px;
        padding: 17px 4%;
    }

    .fh-logo {
        align-self: flex-start;
        font-size: 32px;
    }

    .fh-nav-links {
        justify-content: flex-start;
        gap: 7px;
    }

    .fh-nav-link {
        padding: 11px 12px;
        border-radius: 13px;
        font-size: 13px;
    }

    .fh-profile-button {
        width: 43px;
        height: 43px;
        font-size: 21px;
    }

    .fh-profile-menu {
        top: 52px;
        right: 0;
    }
}

@media (max-width: 390px) {
    .fh-nav-links {
        gap: 4px;
    }

    .fh-nav-link {
        padding: 10px 8px;
        font-size: 12px;
    }
}
</style>

<nav class="fh-navbar">

    <!-- LOGO -->
    <a href="<%= contextPath %>/restaurant"
       class="fh-logo">
        Foodie<span>Hub</span>
    </a>

    <!-- NAVIGATION LINKS -->
    <div class="fh-nav-links">

        <a href="<%= contextPath %>/restaurant"
           class="fh-nav-link">
            Restaurants
        </a>

        <a href="<%= contextPath %>/cart"
           class="fh-nav-link fh-cart-link">
            🛒 Cart
        </a>

        <a href="<%= contextPath %>/orders"
           class="fh-nav-link fh-orders-link">
            📦 My Orders
        </a>

        <!-- PROFILE -->
        <div class="fh-profile">

            <button type="button"
                    class="fh-profile-button"
                    id="fhProfileButton"
                    aria-label="Open profile menu"
                    aria-expanded="false">
                👨🏻
            </button>

            <div class="fh-profile-menu"
                 id="fhProfileMenu">

                <% if (loggedInUser != null) { %>

                    <div class="fh-profile-name">
                        <strong>
                            <%= loggedInUser.getUsername() != null
                                ? loggedInUser.getUsername()
                                : "FoodieHub User" %>
                        </strong>

                        <small>Welcome to FoodieHub!</small>
                    </div>

                    <a href="<%= contextPath %>/orders"
                       class="fh-dropdown-link">
                        📦 My Orders
                    </a>

                    <a href="<%= contextPath %>/cart"
                       class="fh-dropdown-link">
                        🛒 My Cart
                    </a>

                    <a href="<%= contextPath %>/logout"
                       class="fh-dropdown-link">
                        🚪 Logout
                    </a>

                <% } else { %>

                    <div class="fh-profile-name">
                        <strong>Welcome, Foodie!</strong>
                        <small>Sign in to continue</small>
                    </div>

                    <a href="<%= contextPath %>/login.jsp"
                       class="fh-dropdown-link">
                        🔐 Login
                    </a>

                    <a href="<%= contextPath %>/signup.jsp"
                       class="fh-dropdown-link">
                        ✨ Create Account
                    </a>

                <% } %>

            </div>
        </div>
    </div>
</nav>

<script>
(function () {

    const profileButton =
        document.getElementById("fhProfileButton");

    const profileMenu =
        document.getElementById("fhProfileMenu");

    if (!profileButton || !profileMenu) {
        return;
    }

    profileButton.addEventListener("click", function (event) {

        event.stopPropagation();

        const isOpen =
            profileMenu.classList.toggle("show");

        profileButton.setAttribute(
            "aria-expanded",
            String(isOpen)
        );
    });

    document.addEventListener("click", function (event) {

        if (!event.target.closest(".fh-profile")) {

            profileMenu.classList.remove("show");

            profileButton.setAttribute(
                "aria-expanded",
                "false"
            );
        }
    });

})();
</script>