package com.tap.controller;

import java.io.IOException;

import com.tap.daoimpl.MenuDaoImpl;
import com.tap.model.Cart;
import com.tap.model.CartItem;
import com.tap.model.Menu;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/cart")
public class CartController extends HttpServlet {

    // =========================================================
    // POST : ADD / INCREASE / DECREASE / REMOVE / CLEAR
    // =========================================================

    @Override
    protected void doPost(HttpServletRequest req,
                          HttpServletResponse resp)
            throws ServletException, IOException {

        resp.setContentType("application/json");
        resp.setCharacterEncoding("UTF-8");

        HttpSession session = req.getSession();

        String action = req.getParameter("action");

        Cart cart = (Cart) session.getAttribute("cart");

        // =====================================================
        // 1. CLEAR CART
        // =====================================================

        if ("clear".equals(action)) {

            if (cart != null) {

                cart.clearCart();

                session.removeAttribute("cart");
            }

            resp.getWriter().write(
                    "{\"success\":true,"
                    + "\"quantity\":0,"
                    + "\"totalAmount\":0,"
                    + "\"empty\":true}"
            );

            return;
        }

        // =====================================================
        // 2. GET MENU ID
        // =====================================================

        String menuIdParameter =
                req.getParameter("menuId");

        if (menuIdParameter == null
                || menuIdParameter.trim().isEmpty()) {

            resp.getWriter().write(
                    "{\"success\":false,"
                    + "\"quantity\":0,"
                    + "\"totalAmount\":0}"
            );

            return;
        }

        int menuId;

        try {

            menuId = Integer.parseInt(menuIdParameter);

        } catch (NumberFormatException e) {

            resp.getWriter().write(
                    "{\"success\":false,"
                    + "\"quantity\":0,"
                    + "\"totalAmount\":0}"
            );

            return;
        }

        // =====================================================
        // 3. ADD TO CART
        // =====================================================

        if ("add".equals(action)
                || action == null
                || action.isEmpty()) {

            MenuDaoImpl menuDao =
                    new MenuDaoImpl();

            Menu menu =
                    menuDao.getMenu(menuId);

            // -------------------------------------------------
            // Menu not found
            // -------------------------------------------------

            if (menu == null) {

                resp.getWriter().write(
                        "{\"success\":false,"
                        + "\"quantity\":0,"
                        + "\"totalAmount\":0}"
                );

                return;
            }

            // -------------------------------------------------
            // Menu unavailable
            // -------------------------------------------------

            if (!menu.isAvailable()) {

                resp.getWriter().write(
                        "{\"success\":false,"
                        + "\"quantity\":0,"
                        + "\"totalAmount\":0}"
                );

                return;
            }

            // -------------------------------------------------
            // Create cart if cart does not exist
            // -------------------------------------------------

            if (cart == null) {

                cart = new Cart(
                        menu.getRestaurantId()
                );
            }

            // -------------------------------------------------
            // Different restaurant
            //
            // Only one restaurant can exist in cart
            // -------------------------------------------------

            else if (
                    cart.getRestaurantId()
                    != menu.getRestaurantId()
            ) {

                cart = new Cart(
                        menu.getRestaurantId()
                );
            }

            // -------------------------------------------------
            // Create CartItem
            // -------------------------------------------------

            CartItem cartItem =
                    new CartItem(
                            menu.getMenuId(),
                            menu.getItemName(),
                            menu.getPrice(),
                            1,
                            menu.getImagePath()
                    );

            // -------------------------------------------------
            // Add item
            // -------------------------------------------------

            cart.addItem(cartItem);

            // -------------------------------------------------
            // Save cart in session
            // -------------------------------------------------

            session.setAttribute(
                    "cart",
                    cart
            );

            // -------------------------------------------------
            // Get updated item
            // -------------------------------------------------

            CartItem updatedItem =
                    cart.getItem(menuId);

            int quantity =
                    updatedItem != null
                    ? updatedItem.getQuantity()
                    : 1;

            // -------------------------------------------------
            // Get total
            // -------------------------------------------------

            double totalAmount =
                    cart.getTotalAmount();

            // -------------------------------------------------
            // Send response
            // -------------------------------------------------

            resp.getWriter().write(
                    "{\"success\":true,"
                    + "\"quantity\":" + quantity + ","
                    + "\"totalAmount\":" + totalAmount
                    + "}"
            );

            return;
        }

        // =====================================================
        // 4. CART DOES NOT EXIST
        // =====================================================

        if (cart == null) {

            resp.getWriter().write(
                    "{\"success\":false,"
                    + "\"quantity\":0,"
                    + "\"totalAmount\":0}"
            );

            return;
        }

        // =====================================================
        // 5. INCREASE QUANTITY
        // =====================================================

        if ("increase".equals(action)) {

            cart.increaseQuantity(menuId);
        }

        // =====================================================
        // 6. DECREASE QUANTITY
        // =====================================================

        else if ("decrease".equals(action)) {

            cart.decreaseQuantity(menuId);
        }

        // =====================================================
        // 7. REMOVE ITEM
        // =====================================================

        else if ("remove".equals(action)) {

            cart.removeItem(menuId);
        }

        // =====================================================
        // INVALID ACTION
        // =====================================================

        else {

            resp.getWriter().write(
                    "{\"success\":false,"
                    + "\"quantity\":0,"
                    + "\"totalAmount\":0}"
            );

            return;
        }

        // =====================================================
        // 8. SAVE UPDATED CART
        // =====================================================

        session.setAttribute(
                "cart",
                cart
        );

        // =====================================================
        // 9. GET UPDATED ITEM
        // =====================================================

        CartItem updatedItem =
                cart.getItem(menuId);

        int quantity =
                updatedItem != null
                ? updatedItem.getQuantity()
                : 0;

        // =====================================================
        // 10. GET UPDATED TOTAL
        // =====================================================

        double totalAmount =
                cart.getTotalAmount();

        // =====================================================
        // 11. CHECK EMPTY CART
        // =====================================================

        if (cart.isEmpty()) {

            session.removeAttribute("cart");

            resp.getWriter().write(
                    "{\"success\":true,"
                    + "\"quantity\":0,"
                    + "\"totalAmount\":0,"
                    + "\"empty\":true}"
            );

            return;
        }

        // =====================================================
        // 12. RETURN UPDATED CART DATA
        // =====================================================

        resp.getWriter().write(
                "{\"success\":true,"
                + "\"quantity\":" + quantity + ","
                + "\"totalAmount\":" + totalAmount
                + "}"
        );
    }

    // =========================================================
    // GET : DISPLAY CART PAGE
    // =========================================================

    @Override
    protected void doGet(HttpServletRequest req,
                         HttpServletResponse resp)
            throws ServletException, IOException {

        req.getRequestDispatcher(
                "cart.jsp"
        ).forward(
                req,
                resp
        );
    }
}