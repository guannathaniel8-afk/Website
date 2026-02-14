SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

CREATE DATABASE IF NOT EXISTS `padua_hardware_db` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;
USE `padua_hardware_db`;

DROP TABLE IF EXISTS `customers`;
CREATE TABLE `customers` (
  `customer_id` int(11) NOT NULL,
  `customer_name` varchar(255) NOT NULL,
  `cext DEFAULT NULL,
  `order_detaontact_no` varchar(20) DEFAULT NULL,
  `address` tils` text DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT current_timestamp()
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

DROP TABLE IF EXISTS `deliveries`;
CREATE TABLE `deliveries` (
  `delivery_id` int(11) NOT NULL,
  `order_id` int(11) NOT NULL,
  `customer_name` varchar(100) NOT NULL,
  `contact_number` varchar(20) DEFAULT NULL,
  `delivery_address` text NOT NULL,
  `assigned_staff` varchar(100) DEFAULT NULL,
  `delivery_status` enum('Assigned','Out for Delivery','Delivered','Failed','Returned') DEFAULT 'Assigned',
  `delivery_date` date DEFAULT NULL,
  `last_updated` timestamp NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

INSERT INTO `deliveries` (`delivery_id`, `order_id`, `customer_name`, `contact_number`, `delivery_address`, `assigned_staff`, `delivery_status`, `delivery_date`, `last_updated`) VALUES
(1, 1, 'Juan Dela Cruz', '09123456789', 'Quezon City', 'Pedro Reyes', 'Out for Delivery', '2026-01-28', '2026-01-28 14:21:36');

DROP TABLE IF EXISTS `inventory`;
CREATE TABLE `inventory` (
  `product_id` int(11) NOT NULL,
  `product_name` varchar(100) NOT NULL,
  `category` varchar(50) NOT NULL,
  `variant` varchar(50) DEFAULT NULL,
  `stock` int(11) NOT NULL DEFAULT 0,
  `unit_price` decimal(10,2) NOT NULL,
  `status` enum('In Stock','Low Stock','Out of Stock') DEFAULT 'In Stock',
  `created_at` timestamp NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

INSERT INTO `inventory` (`product_id`, `product_name`, `category`, `variant`, `stock`, `unit_price`, `status`, `created_at`, `updated_at`) VALUES
(1, 'Claw Hammer', 'Tools', 'Medium', 25, 350.00, 'In Stock', '2026-01-28 13:34:37', '2026-01-28 13:34:37');

DROP TABLE IF EXISTS `notifications`;
CREATE TABLE `notifications` (
  `notification_id` int(11) NOT NULL,
  `title` varchar(100) NOT NULL,
  `message` text NOT NULL,
  `notification_type` enum('Order','Inventory','Payment','Delivery','System') NOT NULL,
  `reference_id` int(11) DEFAULT NULL,
  `is_read` tinyint(1) DEFAULT 0,
  `created_at` timestamp NULL DEFAULT current_timestamp()
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

INSERT INTO `notifications` (`notification_id`, `title`, `message`, `notification_type`, `reference_id`, `is_read`, `created_at`) VALUES
(1, 'New Order Received', 'Order #1023 has been placed.', 'Order', 1023, 1, '2026-01-28 14:23:32'),
(2, 'Low Stock Alert', 'Cement is low in stock (20 remaining).', 'Inventory', 5, 0, '2026-01-28 14:23:32'),
(3, 'Payment Received', 'Payment for Order #1001 has been received.', 'Payment', 1001, 0, '2026-01-28 14:23:32'),
(4, 'Out for Delivery', 'Order #1003 is out for delivery.', 'Delivery', 1003, 0, '2026-01-28 14:23:32');

DROP TABLE IF EXISTS `order_items`;
CREATE TABLE `order_items` (
  `order_id` int(11) NOT NULL,
  `customer_name` varchar(100) NOT NULL,
  `payment_method` enum('Cash','GCash','Card') NOT NULL,
  `order_type` enum('Walk-in','Online','Delivery') NOT NULL,
  `total_amount` decimal(10,2) NOT NULL,
  `order_status` enum('Pending','Confirmed','Out for Delivery','Completed','Cancelled') DEFAULT 'Pending',
  `order_date` timestamp NULL DEFAULT current_timestamp()
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

INSERT INTO `order_items` (`order_id`, `customer_name`, `payment_method`, `order_type`, `total_amount`, `order_status`, `order_date`) VALUES
(1, 'Juan Dela Cruz', 'GCash', 'Delivery', 4790.00, 'Out for Delivery', '2026-01-28 13:41:42');

DROP TABLE IF EXISTS `payments`;
CREATE TABLE `payments` (
  `payment_id` int(11) NOT NULL,
  `order_id` int(11) NOT NULL,
  `payment_method` enum('Cash','GCash','Card') NOT NULL,
  `payment_status` enum('Paid','Unpaid','Refunded') DEFAULT 'Paid',
  `amount` decimal(10,2) NOT NULL,
  `payment_date` timestamp NULL DEFAULT current_timestamp()
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

INSERT INTO `payments` (`payment_id`, `order_id`, `payment_method`, `payment_status`, `amount`, `payment_date`) VALUES
(1, 1, 'GCash', 'Paid', 4790.00, '2026-01-28 13:51:29');

DROP TABLE IF EXISTS `users`;
CREATE TABLE `users` (
  `user_id` int(11) NOT NULL,
  `fullname` varchar(100) NOT NULL,
  `email` varchar(100) NOT NULL,
  `password` varchar(255) NOT NULL,
  `role` enum('Admin') DEFAULT 'Admin',
  `created_at` timestamp NULL DEFAULT current_timestamp()
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;


ALTER TABLE `customers`
  ADD PRIMARY KEY (`customer_id`);

ALTER TABLE `deliveries`
  ADD PRIMARY KEY (`delivery_id`),
  ADD KEY `fk_delivery_order` (`order_id`);

ALTER TABLE `inventory`
  ADD PRIMARY KEY (`product_id`);

ALTER TABLE `notifications`
  ADD PRIMARY KEY (`notification_id`);

ALTER TABLE `order_items`
  ADD PRIMARY KEY (`order_id`);

ALTER TABLE `payments`
  ADD PRIMARY KEY (`payment_id`),
  ADD KEY `fk_payment_order` (`order_id`);

ALTER TABLE `users`
  ADD PRIMARY KEY (`user_id`),
  ADD UNIQUE KEY `email` (`email`);


ALTER TABLE `customers`
  MODIFY `customer_id` int(11) NOT NULL AUTO_INCREMENT;

ALTER TABLE `deliveries`
  MODIFY `delivery_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

ALTER TABLE `inventory`
  MODIFY `product_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

ALTER TABLE `notifications`
  MODIFY `notification_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

ALTER TABLE `order_items`
  MODIFY `order_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

ALTER TABLE `payments`
  MODIFY `payment_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

ALTER TABLE `users`
  MODIFY `user_id` int(11) NOT NULL AUTO_INCREMENT;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
