
package com.tap.controller;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.sql.Timestamp;
import java.util.LinkedHashMap;
import java.util.Map;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import com.tap.model.Cart;
import com.tap.model.CartItem;
import com.tap.model.Order;
import com.tap.model.User;
import com.tap.util.DBConnection;

@WebServlet("/place-order")
public class PlaceOrderController extends HttpServlet {

    private static final long serialVersionUID = 1L;

    @Override
    protected void doPost(
            HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        String contextPath = request.getContextPath();

        HttpSession session = request.getSession(false);

        if (session == null) {
            response.sendRedirect(contextPath + "/login.jsp");
            return;
        }

        User user = (User) session.getAttribute("loggedInUser");
        Cart cart = (Cart) session.getAttribute("cart");

        if (user == null) {
            response.sendRedirect(contextPath + "/login.jsp");
            return;
        }

        if (cart == null || cart.isEmpty()) {
            response.sendRedirect(contextPath + "/cart");
            return;
        }

        String fullName = trim(request.getParameter("fullName"));
        String phone = trim(request.getParameter("phone"));
        String addressLine1 = trim(request.getParameter("addressLine1"));
        String city = trim(request.getParameter("city"));
        String state = trim(request.getParameter("state"));
        String pinCode = trim(request.getParameter("pinCode"));
        String country = trim(request.getParameter("country"));
        String payment = trim(request.getParameter("payment"));

        if (fullName.isEmpty()
                || phone.isEmpty()
                || addressLine1.isEmpty()
                || city.isEmpty()
                || state.isEmpty()
                || pinCode.isEmpty()
                || country.isEmpty()) {

            forwardError(
                    request,
                    response,
                    "Please fill in all required checkout fields."
            );
            return;
        }

        if (!phone.matches("[6-9][0-9]{9}")) {
            forwardError(
                    request,
                    response,
                    "Enter a valid 10-digit Indian mobile number."
            );
            return;
        }

        if (!pinCode.matches("[0-9]{6}")) {
            forwardError(
                    request,
                    response,
                    "Enter a valid 6-digit PIN code."
            );
            return;
        }

        if (!"COD".equals(payment)) {
            forwardError(
                    request,
                    response,
                    "Online payment is not configured yet. "
                    + "Please select Cash on Delivery."
            );
            return;
        }

        int restaurantId = cart.getRestaurantId();

        if (restaurantId <= 0) {
            forwardError(
                    request,
                    response,
                    "Restaurant information is missing from your cart."
            );
            return;
        }

        Cart successCart = new Cart(restaurantId);

        Map<Integer, Integer> successQuantities =
                new LinkedHashMap<>();

        double totalAmount = 0.0;

        for (CartItem item : cart.getItems()) {

            if (item == null
                    || item.getMenuId() <= 0
                    || item.getQuantity() <= 0
                    || item.getPrice() < 0) {

                forwardError(
                        request,
                        response,
                        "Your cart contains invalid item details."
                );
                return;
            }

            double subtotal =
                    item.getPrice() * item.getQuantity();

            totalAmount += subtotal;

            CartItem copy = new CartItem(
                    item.getMenuId(),
                    item.getItemName(),
                    item.getPrice(),
                    item.getQuantity(),
                    item.getImagePath()
            );

            successCart.addItem(copy);

            successQuantities.put(
                    item.getMenuId(),
                    item.getQuantity()
            );
        }

        if (totalAmount <= 0
                || Double.isNaN(totalAmount)
                || Double.isInfinite(totalAmount)) {

            forwardError(
                    request,
                    response,
                    "The order total is invalid."
            );
            return;
        }

        Connection connection = null;
        boolean committed = false;

        try {
            connection = DBConnection.getConnection();

            if (connection == null) {
                throw new SQLException(
                        "Database connection is unavailable."
                );
            }

            connection.setAutoCommit(false);

            int orderId;

            String orderSql =
                    "INSERT INTO orders "
                    + "(user_id, restaurant_id, order_date, "
                    + "total_amount, status, payment_mode) "
                    + "VALUES (?, ?, ?, ?, ?, ?)";

            try (PreparedStatement orderStatement =
                    connection.prepareStatement(
                            orderSql,
                            Statement.RETURN_GENERATED_KEYS)) {

                orderStatement.setInt(1, user.getUserId());
                orderStatement.setInt(2, restaurantId);

                orderStatement.setTimestamp(
                        3,
                        new Timestamp(System.currentTimeMillis())
                );

                orderStatement.setDouble(4, totalAmount);
                orderStatement.setString(5, "Placed");
                orderStatement.setString(6, payment);

                int rows = orderStatement.executeUpdate();

                if (rows != 1) {
                    throw new SQLException(
                            "Order record was not inserted."
                    );
                }

                try (ResultSet keys =
                        orderStatement.getGeneratedKeys()) {

                    if (!keys.next()) {
                        throw new SQLException(
                                "Could not retrieve the generated order ID."
                        );
                    }

                    orderId = keys.getInt(1);
                }
            }

            String itemSql =
                    "INSERT INTO orderitem "
                    + "(order_id, menu_id, total_amount) "
                    + "VALUES (?, ?, ?)";

            try (PreparedStatement itemStatement =
                    connection.prepareStatement(itemSql)) {

                for (CartItem item : successCart.getItems()) {

                    double itemSubtotal =
                            item.getPrice() * item.getQuantity();

                    itemStatement.setInt(1, orderId);
                    itemStatement.setInt(2, item.getMenuId());
                    itemStatement.setDouble(3, itemSubtotal);

                    itemStatement.addBatch();
                }

                int[] results = itemStatement.executeBatch();

                if (results.length != successCart.getItemCount()) {
                    throw new SQLException(
                            "Not all order items were saved."
                    );
                }
            }

            connection.commit();
            committed = true;

            Order placedOrder = new Order();

            placedOrder.setOrderId(orderId);
            placedOrder.setUserId(user.getUserId());
            placedOrder.setRestaurantId(restaurantId);
            placedOrder.setTotalAmount(totalAmount);
            placedOrder.setStatus("Placed");
            placedOrder.setPaymentMode(payment);

            session.setAttribute("placedOrder", placedOrder);
            session.setAttribute("successCart", successCart);

            session.setAttribute(
                    "successQuantities",
                    successQuantities
            );

            session.setAttribute(
                    "successRestaurantName",
                    "FoodieHub Restaurant"
            );

            session.setAttribute("orderFullName", fullName);
            session.setAttribute("orderPhone", phone);
            session.setAttribute("orderAddressLine1", addressLine1);
            session.setAttribute("orderCity", city);
            session.setAttribute("orderState", state);
            session.setAttribute("orderPinCode", pinCode);
            session.setAttribute("orderCountry", country);

            cart.clearCart();
            session.removeAttribute("cart");

            response.sendRedirect(
                    contextPath + "/order-success.jsp"
            );
            return;

        } catch (Exception e) {

            if (connection != null && !committed) {
                try {
                    connection.rollback();
                } catch (SQLException rollbackError) {
                    e.addSuppressed(rollbackError);
                }
            }

            getServletContext().log(
                    "FoodieHub order placement failed.",
                    e
            );

            forwardError(
                    request,
                    response,
                    "Order placement failed. Please check the server console."
            );

        } finally {

            if (connection != null) {
                try {
                    connection.close();
                } catch (SQLException closeError) {
                    getServletContext().log(
                            "Error closing database connection.",
                            closeError
                    );
                }
            }
        }
    }

    private void forwardError(
            HttpServletRequest request,
            HttpServletResponse response,
            String message)
            throws ServletException, IOException {

        request.setAttribute("errorMessage", message);

        request.getRequestDispatcher("/checkout.jsp")
                .forward(request, response);
    }

    private String trim(String value) {
        return value == null ? "" : value.trim();
    }
}