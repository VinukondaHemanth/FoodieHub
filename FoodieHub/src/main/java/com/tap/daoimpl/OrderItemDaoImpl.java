
package com.tap.daoimpl;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.tap.dao.OrderItemDao;
import com.tap.model.OrderItem;
import com.tap.util.DBConnection;

public class OrderItemDaoImpl implements OrderItemDao {

    private static final String INSERT_ORDER_ITEM =
            "INSERT INTO orderitem "
          + "(order_id, menu_id, total_amount) "
          + "VALUES (?, ?, ?)";

    private static final String SELECT_ORDER_ITEM_BY_ID =
            "SELECT order_item_id, order_id, menu_id, total_amount "
          + "FROM orderitem WHERE order_item_id = ?";

    private static final String SELECT_ORDER_ITEMS_BY_ORDER =
            "SELECT order_item_id, order_id, menu_id, total_amount "
          + "FROM orderitem WHERE order_id = ?";

    private static final String SELECT_ORDER_ITEMS_BY_MENU =
            "SELECT order_item_id, order_id, menu_id, total_amount "
          + "FROM orderitem WHERE menu_id = ?";

    private static final String UPDATE_ORDER_ITEM =
            "UPDATE orderitem SET order_id = ?, menu_id = ?, "
          + "total_amount = ? WHERE order_item_id = ?";

    private static final String DELETE_ORDER_ITEM =
            "DELETE FROM orderitem WHERE order_item_id = ?";

    private static final String SELECT_ALL_ORDER_ITEMS =
            "SELECT order_item_id, order_id, menu_id, total_amount "
          + "FROM orderitem";

    @Override
    public void addOrderItem(OrderItem orderItem) {

        if (orderItem == null) {
            return;
        }

        try (Connection connection = DBConnection.getConnection();
             PreparedStatement preparedStatement =
                     connection.prepareStatement(INSERT_ORDER_ITEM)) {

            preparedStatement.setInt(1, orderItem.getOrderId());
            preparedStatement.setInt(2, orderItem.getMenuId());
            preparedStatement.setDouble(3, orderItem.getTotalAmount());

            preparedStatement.executeUpdate();

        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    @Override
    public OrderItem getOrderItem(int orderItemId) {

        OrderItem orderItem = null;

        try (Connection connection = DBConnection.getConnection();
             PreparedStatement preparedStatement =
                     connection.prepareStatement(SELECT_ORDER_ITEM_BY_ID)) {

            preparedStatement.setInt(1, orderItemId);

            try (ResultSet resultSet = preparedStatement.executeQuery()) {

                if (resultSet.next()) {
                    orderItem = mapResultSetToOrderItem(resultSet);
                }
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return orderItem;
    }

    @Override
    public List<OrderItem> getOrderItemsByOrder(int orderId) {

        List<OrderItem> orderItems = new ArrayList<>();

        try (Connection connection = DBConnection.getConnection();
             PreparedStatement preparedStatement =
                     connection.prepareStatement(SELECT_ORDER_ITEMS_BY_ORDER)) {

            preparedStatement.setInt(1, orderId);

            try (ResultSet resultSet = preparedStatement.executeQuery()) {

                while (resultSet.next()) {
                    orderItems.add(mapResultSetToOrderItem(resultSet));
                }
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return orderItems;
    }

    @Override
    public List<OrderItem> getOrderItemsByMenu(int menuId) {

        List<OrderItem> orderItems = new ArrayList<>();

        try (Connection connection = DBConnection.getConnection();
             PreparedStatement preparedStatement =
                     connection.prepareStatement(SELECT_ORDER_ITEMS_BY_MENU)) {

            preparedStatement.setInt(1, menuId);

            try (ResultSet resultSet = preparedStatement.executeQuery()) {

                while (resultSet.next()) {
                    orderItems.add(mapResultSetToOrderItem(resultSet));
                }
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return orderItems;
    }

    @Override
    public void updateOrderItem(OrderItem orderItem) {

        if (orderItem == null) {
            return;
        }

        try (Connection connection = DBConnection.getConnection();
             PreparedStatement preparedStatement =
                     connection.prepareStatement(UPDATE_ORDER_ITEM)) {

            preparedStatement.setInt(1, orderItem.getOrderId());
            preparedStatement.setInt(2, orderItem.getMenuId());
            preparedStatement.setDouble(3, orderItem.getTotalAmount());
            preparedStatement.setInt(4, orderItem.getOrderItemId());

            preparedStatement.executeUpdate();

        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    @Override
    public void deleteOrderItem(int orderItemId) {

        try (Connection connection = DBConnection.getConnection();
             PreparedStatement preparedStatement =
                     connection.prepareStatement(DELETE_ORDER_ITEM)) {

            preparedStatement.setInt(1, orderItemId);

            preparedStatement.executeUpdate();

        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    @Override
    public List<OrderItem> getAllOrderItems() {

        List<OrderItem> orderItems = new ArrayList<>();

        try (Connection connection = DBConnection.getConnection();
             PreparedStatement preparedStatement =
                     connection.prepareStatement(SELECT_ALL_ORDER_ITEMS);
             ResultSet resultSet = preparedStatement.executeQuery()) {

            while (resultSet.next()) {
                orderItems.add(mapResultSetToOrderItem(resultSet));
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return orderItems;
    }

    private OrderItem mapResultSetToOrderItem(ResultSet resultSet)
            throws SQLException {

        OrderItem orderItem = new OrderItem();

        orderItem.setOrderItemId(
                resultSet.getInt("order_item_id"));

        orderItem.setOrderId(
                resultSet.getInt("order_id"));

        orderItem.setMenuId(
                resultSet.getInt("menu_id"));

        orderItem.setTotalAmount(
                resultSet.getDouble("total_amount"));

        return orderItem;
    }
}
