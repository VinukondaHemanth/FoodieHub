package com.tap.model;

import java.util.Collection;
import java.util.LinkedHashMap;
import java.util.Map;

public class Cart {

    // =========================================================
    // RESTAURANT ID
    // =========================================================

    private int restaurantId;

    // =========================================================
    // CART ITEMS
    // menuId -> CartItem
    // =========================================================

    private Map<Integer, CartItem> items;

    // =========================================================
    // DEFAULT CONSTRUCTOR
    // =========================================================

    public Cart() {

        items = new LinkedHashMap<>();
    }

    // =========================================================
    // RESTAURANT CONSTRUCTOR
    // =========================================================

    public Cart(int restaurantId) {

        this.restaurantId = restaurantId;
        this.items = new LinkedHashMap<>();
    }

    // =========================================================
    // GET RESTAURANT ID
    // =========================================================

    public int getRestaurantId() {

        return restaurantId;
    }

    // =========================================================
    // SET RESTAURANT ID
    // =========================================================

    public void setRestaurantId(int restaurantId) {

        this.restaurantId = restaurantId;
    }

    // =========================================================
    // ADD ITEM TO CART
    // =========================================================

    public void addItem(CartItem item) {

        if (item == null) {
            return;
        }

        int menuId = item.getMenuId();

        // -----------------------------------------------------
        // Item already exists
        // -----------------------------------------------------

        if (items.containsKey(menuId)) {

            CartItem existingItem =
                    items.get(menuId);

            int newQuantity =
                    existingItem.getQuantity()
                    + item.getQuantity();

            existingItem.setQuantity(newQuantity);
        }

        // -----------------------------------------------------
        // New item
        // -----------------------------------------------------

        else {

            items.put(menuId, item);
        }
    }

    // =========================================================
    // REMOVE ITEM
    // =========================================================

    public void removeItem(int menuId) {

        items.remove(menuId);
    }

    // =========================================================
    // INCREASE QUANTITY
    // =========================================================

    public void increaseQuantity(int menuId) {

        CartItem item =
                items.get(menuId);

        if (item != null) {

            int currentQuantity =
                    item.getQuantity();

            item.setQuantity(
                    currentQuantity + 1
            );
        }
    }

    // =========================================================
    // DECREASE QUANTITY
    // =========================================================

    public void decreaseQuantity(int menuId) {

        CartItem item =
                items.get(menuId);

        if (item != null) {

            int currentQuantity =
                    item.getQuantity();

            // -------------------------------------------------
            // If quantity is greater than 1
            // decrease by 1
            // -------------------------------------------------

            if (currentQuantity > 1) {

                item.setQuantity(
                        currentQuantity - 1
                );
            }

            // -------------------------------------------------
            // If quantity is 1
            // remove item from cart
            // -------------------------------------------------

            else {

                items.remove(menuId);
            }
        }
    }

    // =========================================================
    // CLEAR ENTIRE CART
    // =========================================================

    public void clearCart() {

        items.clear();
    }

    // =========================================================
    // GET ALL CART ITEMS
    // =========================================================

    public Collection<CartItem> getItems() {

        return items.values();
    }

    // =========================================================
    // GET SPECIFIC CART ITEM
    // =========================================================

    public CartItem getItem(int menuId) {

        return items.get(menuId);
    }

    // =========================================================
    // GET TOTAL AMOUNT
    // =========================================================

    public double getTotalAmount() {

        double total = 0.0;

        for (CartItem item : items.values()) {

            total +=
                    item.getPrice()
                    * item.getQuantity();
        }

        return total;
    }

    // =========================================================
    // CHECK CART EMPTY
    // =========================================================

    public boolean isEmpty() {

        return items.isEmpty();
    }

    // =========================================================
    // GET NUMBER OF DIFFERENT ITEMS
    // =========================================================

    public int getItemCount() {

        return items.size();
    }

    // =========================================================
    // GET TOTAL QUANTITY
    // =========================================================

    public int getTotalQuantity() {

        int totalQuantity = 0;

        for (CartItem item : items.values()) {

            totalQuantity += item.getQuantity();
        }

        return totalQuantity;
    }

    // =========================================================
    // TO STRING
    // =========================================================

    @Override
    public String toString() {

        return "Cart [restaurantId="
                + restaurantId
                + ", items="
                + items
                + ", totalAmount="
                + getTotalAmount()
                + "]";
    }
}