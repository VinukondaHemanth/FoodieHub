
package com.tap.controller;

import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.tap.dao.OrderDao;
import com.tap.dao.OrderItemDao;
import com.tap.dao.RestaurantDao;
import com.tap.dao.MenuDao;

import com.tap.daoimpl.OrderDaoImpl;
import com.tap.daoimpl.OrderItemDaoImpl;
import com.tap.daoimpl.RestaurantDaoImpl;
import com.tap.daoimpl.MenuDaoImpl;

import com.tap.model.User;
import com.tap.model.Order;
import com.tap.model.OrderItem;
import com.tap.model.Restaurant;
import com.tap.model.Menu;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/orders")
public class OrdersController extends HttpServlet {

    private static final long serialVersionUID = 1L;

    private final OrderDao orderDao = new OrderDaoImpl();
    private final OrderItemDao orderItemDao = new OrderItemDaoImpl();
    private final RestaurantDao restaurantDao = new RestaurantDaoImpl();
    private final MenuDao menuDao = new MenuDaoImpl();

    @Override
    protected void doGet(
            HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        String contextPath = request.getContextPath();

        // =====================================================
        // 1. CHECK LOGIN SESSION
        // =====================================================

        HttpSession session = request.getSession(false);

        if (session == null
                || !(session.getAttribute("loggedInUser")
                        instanceof User)) {

            response.sendRedirect(contextPath + "/login.jsp");
            return;
        }

        User loggedInUser =
                (User) session.getAttribute("loggedInUser");

        // =====================================================
        // 2. GET ORDERS FOR THE LOGGED-IN USER
        // =====================================================

        List<Order> orders;

        try {
            orders = orderDao.getOrdersByUser(
                    loggedInUser.getUserId());

        } catch (Exception e) {

            getServletContext().log(
                    "Failed to retrieve FoodieHub orders.", e);

            request.setAttribute(
                    "errorMessage",
                    "Unable to load your orders. Please try again.");

            request.setAttribute("orders", new ArrayList<Order>());
            request.setAttribute(
                    "orderItemsMap",
                    new HashMap<Integer, List<OrderItem>>());
            request.setAttribute(
                    "restaurantsMap",
                    new HashMap<Integer, Restaurant>());
            request.setAttribute(
                    "menusMap",
                    new HashMap<Integer, Menu>());

            request.getRequestDispatcher("/orders.jsp")
                    .forward(request, response);

            return;
        }

        if (orders == null) {
            orders = new ArrayList<>();
        }

        // =====================================================
        // 3. CREATE MAPS REQUIRED BY orders.jsp
        // =====================================================

        Map<Integer, List<OrderItem>> orderItemsMap =
                new HashMap<>();

        Map<Integer, Restaurant> restaurantsMap =
                new HashMap<>();

        Map<Integer, Menu> menusMap =
                new HashMap<>();

        // =====================================================
        // 4. LOAD EACH ORDER'S ITEMS AND RELATED DETAILS
        // =====================================================

        for (Order order : orders) {

            if (order == null) {
                continue;
            }

            int orderId = order.getOrderId();
            int restaurantId = order.getRestaurantId();

            // -------------------------------------------------
            // Load items belonging to this specific order.
            // OrderItemDaoImpl must query the table named
            // orderitem, not order_items.
            // -------------------------------------------------

            List<OrderItem> items;

            try {
                items = orderItemDao.getOrderItemsByOrder(orderId);

            } catch (Exception e) {

                getServletContext().log(
                        "Failed to load items for order ID: "
                                + orderId, e);

                items = new ArrayList<>();
            }

            if (items == null) {
                items = new ArrayList<>();
            }

            orderItemsMap.put(orderId, items);

            // -------------------------------------------------
            // Load restaurant details.
            // -------------------------------------------------

            if (!restaurantsMap.containsKey(restaurantId)) {

                try {
                    Restaurant restaurant =
                            restaurantDao.getRestaurant(restaurantId);

                    if (restaurant != null) {
                        restaurantsMap.put(
                                restaurantId, restaurant);
                    }

                } catch (Exception e) {

                    getServletContext().log(
                            "Failed to load restaurant ID: "
                                    + restaurantId, e);
                }
            }

            // -------------------------------------------------
            // Load menu details for each saved order item.
            // -------------------------------------------------

            for (OrderItem item : items) {

                if (item == null) {
                    continue;
                }

                int menuId = item.getMenuId();

                if (!menusMap.containsKey(menuId)) {

                    try {
                        Menu menu = menuDao.getMenu(menuId);

                        if (menu != null) {
                            menusMap.put(menuId, menu);
                        }

                    } catch (Exception e) {

                        getServletContext().log(
                                "Failed to load menu ID: "
                                        + menuId, e);
                    }
                }
            }
        }

        // =====================================================
        // 5. SEND ALL DATA TO orders.jsp
        // =====================================================

        request.setAttribute("orders", orders);
        request.setAttribute("orderItemsMap", orderItemsMap);
        request.setAttribute("restaurantsMap", restaurantsMap);
        request.setAttribute("menusMap", menusMap);

        // =====================================================
        // 6. DISPLAY THE EXISTING ORDER HISTORY PAGE
        // =====================================================

        request.getRequestDispatcher("/orders.jsp")
                .forward(request, response);
    }
}
