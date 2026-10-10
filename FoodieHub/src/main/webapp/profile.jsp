<%@ page language="java"
    contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ page import="com.tap.model.User" %>

<%
    String profileContextPath =
        request.getContextPath();

    User profileUser =
        (User) session.getAttribute("loggedInUser");


    if (profileUser == null) {

        response.sendRedirect(
            profileContextPath + "/login.jsp"
        );

        return;
    }
%>

<!DOCTYPE html>

<html lang="en">

<head>

    <meta charset="UTF-8">

    <meta name="viewport"
          content="width=device-width, initial-scale=1.0">

    <title>FoodieHub | Profile</title>


    <link rel="preconnect"
          href="https://fonts.googleapis.com">

    <link rel="preconnect"
          href="https://fonts.gstatic.com"
          crossorigin>

    <link
        href="https://fonts.googleapis.com/css2?family=Manrope:wght@400;500;600;700;800&display=swap"
        rel="stylesheet">


    <link
        rel="stylesheet"
        href="<%= profileContextPath %>/css/global.css">

    <link
        rel="stylesheet"
        href="<%= profileContextPath %>/css/navbar.css">

    <link
        rel="stylesheet"
        href="<%= profileContextPath %>/css/profile.css">

</head>


<body>


    <%@ include file="components/navbar.jsp" %>


    <main class="profile-page">


        <div class="profile-container">


            <div class="profile-eyebrow">

                FOODIEHUB ACCOUNT

            </div>


            <section class="profile-card">


                <div class="profile-header">


                    <div class="profile-icon">
                        👤
                    </div>


                    <div>

                        <h1>
                            My Profile
                        </h1>


                        <p>
                            Manage your FoodieHub account details.
                        </p>

                    </div>


                </div>


                <div class="profile-details">


                    <h2 class="profile-details-title">

                        Account Information

                    </h2>


                    <div class="profile-details-grid">


                        <div class="profile-detail">

                            <span class="detail-label">
                                Username
                            </span>

                            <span class="detail-value">
                                <%= profileUser.getUsername() %>
                            </span>

                        </div>


                        <div class="profile-detail">

                            <span class="detail-label">
                                Email
                            </span>

                            <span class="detail-value">
                                <%= profileUser.getEmail() %>
                            </span>

                        </div>


                        <div class="profile-detail">

                            <span class="detail-label">
                                Phone
                            </span>

                            <span class="detail-value">
                                <%= profileUser.getPhone() %>
                            </span>

                        </div>


                        <div class="profile-detail">

                            <span class="detail-label">
                                Role
                            </span>

                            <span class="detail-value">
                                <%= profileUser.getRole() %>
                            </span>

                        </div>


                        <div class="profile-detail full">

                            <span class="detail-label">
                                Address
                            </span>

                            <span class="detail-value">
                                <%= profileUser.getAddress() %>
                            </span>

                        </div>


                    </div>

                </div>


                <div class="profile-actions">


                    <a
                        href="<%= profileContextPath %>/restaurant"
                        class="profile-action primary">

                        🍽️
                        Browse Restaurants

                    </a>


                    <a
                        href="<%= profileContextPath %>/cart"
                        class="profile-action secondary">

                        🛒
                        My Cart

                    </a>


                    <a
                        href="<%= profileContextPath %>/logout"
                        class="profile-action secondary">

                        Logout

                    </a>


                </div>


            </section>

        </div>

    </main>


</body>

</html>