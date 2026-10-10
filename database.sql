CREATE DATABASE foodiehub;
USE foodiehub;

-- =========================================
-- 1. USERS TABLE
-- =========================================
CREATE TABLE IF NOT EXISTS users (
    user_id INT PRIMARY KEY AUTO_INCREMENT,
    username VARCHAR(100) NOT NULL,
    password VARCHAR(255) NOT NULL,
    email VARCHAR(150) NOT NULL,
    phone VARCHAR(20) NOT NULL,
    address VARCHAR(255) NOT NULL,
    role VARCHAR(50) NOT NULL
);

-- =========================================
-- 2. RESTAURANTS TABLE
-- =========================================
CREATE TABLE IF NOT EXISTS restaurants (
    restaurant_id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(150) NOT NULL,
    address VARCHAR(255) NOT NULL,
    cuisine_type VARCHAR(100),
    delivery_time VARCHAR(50),
    image_path VARCHAR(500)
);

-- =========================================
-- 3. MENU TABLE
-- =========================================
CREATE TABLE IF NOT EXISTS menu (
    menu_id INT PRIMARY KEY AUTO_INCREMENT,
    restaurant_id INT NOT NULL,
    item_name VARCHAR(150) NOT NULL,
    description VARCHAR(500),
    price DOUBLE NOT NULL,
    image_path VARCHAR(500),
    FOREIGN KEY (restaurant_id)
        REFERENCES restaurants(restaurant_id)
);

-- =========================================
-- 4. ORDERS TABLE
-- =========================================
CREATE TABLE IF NOT EXISTS orders (
    order_id INT PRIMARY KEY AUTO_INCREMENT,
    user_id INT NOT NULL,
    restaurant_id INT NOT NULL,
    order_date DATETIME,
    total_amount DOUBLE NOT NULL,
    status VARCHAR(50),
    payment_mode VARCHAR(50),
    FOREIGN KEY (user_id)
        REFERENCES users(user_id),
    FOREIGN KEY (restaurant_id)
        REFERENCES restaurants(restaurant_id)
);

-- =========================================
-- 5. ORDERITEM TABLE
-- =========================================
CREATE TABLE IF NOT EXISTS orderitem (
    order_item_id INT PRIMARY KEY AUTO_INCREMENT,
    order_id INT NOT NULL,
    menu_id INT NOT NULL,
    total_amount DOUBLE NOT NULL,
    FOREIGN KEY (order_id)
        REFERENCES orders(order_id),
    FOREIGN KEY (menu_id)
        REFERENCES menu(menu_id)
);

-- =========================================
-- VERIFY TABLES
-- =========================================
SHOW TABLES;
