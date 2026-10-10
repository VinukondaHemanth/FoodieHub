package com.tap.daoimpl;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.tap.dao.UserDao;
import com.tap.model.User;
import com.tap.util.DBConnection;

public class UserDaoImpl implements UserDao {

    private static final String INSERT_USER =
            "INSERT INTO users (username, password, email, phone, address, role) "
          + "VALUES (?, ?, ?, ?, ?, ?)";

    private static final String SELECT_USER_BY_ID =
            "SELECT user_id, username, password, email, phone, address, role "
          + "FROM users WHERE user_id = ?";

    private static final String SELECT_USER_BY_USERNAME_OR_EMAIL =
            "SELECT user_id, username, password, email, phone, address, role "
          + "FROM users WHERE username = ? OR email = ?";

    private static final String UPDATE_USER =
            "UPDATE users SET username = ?, password = ?, email = ?, "
          + "phone = ?, address = ?, role = ? WHERE user_id = ?";

    private static final String DELETE_USER =
            "DELETE FROM users WHERE user_id = ?";

    private static final String SELECT_ALL_USERS =
            "SELECT user_id, username, password, email, phone, address, role "
          + "FROM users";

    @Override
    public void addUser(User user) {

        try (Connection connection = DBConnection.getConnection();
             PreparedStatement preparedStatement =
                     connection.prepareStatement(INSERT_USER)) {

            preparedStatement.setString(1, user.getUsername());
            preparedStatement.setString(2, user.getPassword());
            preparedStatement.setString(3, user.getEmail());
            preparedStatement.setString(4, user.getPhone());
            preparedStatement.setString(5, user.getAddress());
            preparedStatement.setString(6, user.getRole());

            preparedStatement.executeUpdate();

        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    @Override
    public User getUser(int userId) {

        User user = null;

        try (Connection connection = DBConnection.getConnection();
             PreparedStatement preparedStatement =
                     connection.prepareStatement(SELECT_USER_BY_ID)) {

            preparedStatement.setInt(1, userId);

            try (ResultSet resultSet = preparedStatement.executeQuery()) {

                if (resultSet.next()) {
                    user = mapResultSetToUser(resultSet);
                }
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return user;
    }

    @Override
    public User getUserByUsernameOrEmail(String loginInput) {

        User user = null;

        try (Connection connection = DBConnection.getConnection();
             PreparedStatement preparedStatement =
                     connection.prepareStatement(
                             SELECT_USER_BY_USERNAME_OR_EMAIL)) {

            preparedStatement.setString(1, loginInput);
            preparedStatement.setString(2, loginInput);

            try (ResultSet resultSet = preparedStatement.executeQuery()) {

                if (resultSet.next()) {
                    user = mapResultSetToUser(resultSet);
                }
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return user;
    }

    @Override
    public void updateUser(User user) {

        try (Connection connection = DBConnection.getConnection();
             PreparedStatement preparedStatement =
                     connection.prepareStatement(UPDATE_USER)) {

            preparedStatement.setString(1, user.getUsername());
            preparedStatement.setString(2, user.getPassword());
            preparedStatement.setString(3, user.getEmail());
            preparedStatement.setString(4, user.getPhone());
            preparedStatement.setString(5, user.getAddress());
            preparedStatement.setString(6, user.getRole());
            preparedStatement.setInt(7, user.getUserId());

            preparedStatement.executeUpdate();

        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    @Override
    public void deleteUser(int userId) {

        try (Connection connection = DBConnection.getConnection();
             PreparedStatement preparedStatement =
                     connection.prepareStatement(DELETE_USER)) {

            preparedStatement.setInt(1, userId);

            preparedStatement.executeUpdate();

        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    @Override
    public List<User> getAllUsers() {

        List<User> users = new ArrayList<>();

        try (Connection connection = DBConnection.getConnection();
             PreparedStatement preparedStatement =
                     connection.prepareStatement(SELECT_ALL_USERS);
             ResultSet resultSet = preparedStatement.executeQuery()) {

            while (resultSet.next()) {
                users.add(mapResultSetToUser(resultSet));
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return users;
    }

    private User mapResultSetToUser(ResultSet resultSet)
            throws SQLException {

        User user = new User();

        user.setUserId(resultSet.getInt("user_id"));
        user.setUsername(resultSet.getString("username"));
        user.setPassword(resultSet.getString("password"));
        user.setEmail(resultSet.getString("email"));
        user.setPhone(resultSet.getString("phone"));
        user.setAddress(resultSet.getString("address"));
        user.setRole(resultSet.getString("role"));

        return user;
    }
}