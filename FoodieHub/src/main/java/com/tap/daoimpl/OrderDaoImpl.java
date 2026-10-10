package com.tap.daoimpl;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.tap.dao.OrderDao;
import com.tap.model.Order;
import com.tap.util.DBConnection;

public class OrderDaoImpl implements OrderDao {

    private static final String INSERT_ORDER =
            "INSERT INTO orders "
          + "(user_id, restaurant_id, order_date, total_amount, status, payment_mode) "
          + "VALUES (?, ?, ?, ?, ?, ?)";

    private static final String SELECT_ORDER_BY_ID =
            "SELECT order_id, user_id, restaurant_id, order_date, "
          + "total_amount, status, payment_mode "
          + "FROM orders WHERE order_id = ?";

    private static final String SELECT_ORDERS_BY_USER =
            "SELECT order_id, user_id, restaurant_id, order_date, "
          + "total_amount, status, payment_mode "
          + "FROM orders WHERE user_id = ?";

    private static final String SELECT_ORDERS_BY_RESTAURANT =
            "SELECT order_id, user_id, restaurant_id, order_date, "
          + "total_amount, status, payment_mode "
          + "FROM orders WHERE restaurant_id = ?";

    private static final String UPDATE_ORDER =
            "UPDATE orders SET user_id = ?, restaurant_id = ?, order_date = ?, "
          + "total_amount = ?, status = ?, payment_mode = ? "
          + "WHERE order_id = ?";

    private static final String DELETE_ORDER =
            "DELETE FROM orders WHERE order_id = ?";

    private static final String SELECT_ALL_ORDERS =
            "SELECT order_id, user_id, restaurant_id, order_date, "
          + "total_amount, status, payment_mode "
          + "FROM orders";

    @Override
    public void addOrder(Order order) {

        try (Connection connection = DBConnection.getConnection();
             PreparedStatement preparedStatement =
                     connection.prepareStatement(INSERT_ORDER)) {

            preparedStatement.setInt(1, order.getUserId());
            preparedStatement.setInt(2, order.getRestaurantId());
            preparedStatement.setString(3, order.getOrderDate());
            preparedStatement.setDouble(4, order.getTotalAmount());
            preparedStatement.setString(5, order.getStatus());
            preparedStatement.setString(6, order.getPaymentMode());

            preparedStatement.executeUpdate();

        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    @Override
    public Order getOrder(int orderId) {

        Order order = null;

        try (Connection connection = DBConnection.getConnection();
             PreparedStatement preparedStatement =
                     connection.prepareStatement(SELECT_ORDER_BY_ID)) {

            preparedStatement.setInt(1, orderId);

            try (ResultSet resultSet = preparedStatement.executeQuery()) {

                if (resultSet.next()) {
                    order = mapResultSetToOrder(resultSet);
                }
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return order;
    }

    @Override
    public List<Order> getOrdersByUser(int userId) {

        List<Order> orders = new ArrayList<>();

        try (Connection connection = DBConnection.getConnection();
             PreparedStatement preparedStatement =
                     connection.prepareStatement(SELECT_ORDERS_BY_USER)) {

            preparedStatement.setInt(1, userId);

            try (ResultSet resultSet = preparedStatement.executeQuery()) {

                while (resultSet.next()) {
                    orders.add(mapResultSetToOrder(resultSet));
                }
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return orders;
    }

    @Override
    public List<Order> getOrdersByRestaurant(int restaurantId) {

        List<Order> orders = new ArrayList<>();

        try (Connection connection = DBConnection.getConnection();
             PreparedStatement preparedStatement =
                     connection.prepareStatement(SELECT_ORDERS_BY_RESTAURANT)) {

            preparedStatement.setInt(1, restaurantId);

            try (ResultSet resultSet = preparedStatement.executeQuery()) {

                while (resultSet.next()) {
                    orders.add(mapResultSetToOrder(resultSet));
                }
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return orders;
    }

    @Override
    public void updateOrder(Order order) {

        try (Connection connection = DBConnection.getConnection();
             PreparedStatement preparedStatement =
                     connection.prepareStatement(UPDATE_ORDER)) {

            preparedStatement.setInt(1, order.getUserId());
            preparedStatement.setInt(2, order.getRestaurantId());
            preparedStatement.setString(3, order.getOrderDate());
            preparedStatement.setDouble(4, order.getTotalAmount());
            preparedStatement.setString(5, order.getStatus());
            preparedStatement.setString(6, order.getPaymentMode());
            preparedStatement.setInt(7, order.getOrderId());

            preparedStatement.executeUpdate();

        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    @Override
    public void deleteOrder(int orderId) {

        try (Connection connection = DBConnection.getConnection();
             PreparedStatement preparedStatement =
                     connection.prepareStatement(DELETE_ORDER)) {

            preparedStatement.setInt(1, orderId);

            preparedStatement.executeUpdate();

        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    @Override
    public List<Order> getAllOrders() {

        List<Order> orders = new ArrayList<>();

        try (Connection connection = DBConnection.getConnection();
             PreparedStatement preparedStatement =
                     connection.prepareStatement(SELECT_ALL_ORDERS);
             ResultSet resultSet = preparedStatement.executeQuery()) {

            while (resultSet.next()) {
                orders.add(mapResultSetToOrder(resultSet));
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return orders;
    }

    private Order mapResultSetToOrder(ResultSet resultSet)
            throws SQLException {

        Order order = new Order();

        order.setOrderId(
                resultSet.getInt("order_id"));

        order.setUserId(
                resultSet.getInt("user_id"));

        order.setRestaurantId(
                resultSet.getInt("restaurant_id"));

        order.setOrderDate(
                resultSet.getString("order_date"));

        order.setTotalAmount(
                resultSet.getDouble("total_amount"));

        order.setStatus(
                resultSet.getString("status"));

        order.setPaymentMode(
                resultSet.getString("payment_mode"));

        return order;
    }
}