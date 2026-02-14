-- Padua Hardware CRM Database Schema
-- Created: February 6, 2026

CREATE DATABASE IF NOT EXISTS padua_hardware_crm;
USE padua_hardware_crm;

-- Customers Table
CREATE TABLE IF NOT EXISTS customers (
    id INT PRIMARY KEY AUTO_INCREMENT,
    customer_id VARCHAR(20) UNIQUE NOT NULL COMMENT '#CUST-001 format',
    name VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    contact VARCHAR(20) NOT NULL,
    address TEXT NOT NULL,
    status ENUM('Active', 'Pending', 'Inactive') DEFAULT 'Active',
    date_registered DATE NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    INDEX idx_status (status),
    INDEX idx_date (date_registered)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Products Table
CREATE TABLE IF NOT EXISTS products (
    id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100) NOT NULL UNIQUE,
    category VARCHAR(50) NOT NULL,
    price DECIMAL(10, 2) NOT NULL,
    quantity_in_stock INT DEFAULT 0,
    status ENUM('In Stock', 'Low Stock', 'Out of Stock') DEFAULT 'In Stock',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    INDEX idx_status (status),
    INDEX idx_category (category)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Orders Table
CREATE TABLE IF NOT EXISTS orders (
    id INT PRIMARY KEY AUTO_INCREMENT,
    order_id VARCHAR(20) UNIQUE NOT NULL COMMENT '#ORD-1001 format',
    customer_id INT NOT NULL,
    product_id INT NOT NULL,
    quantity INT NOT NULL,
    amount DECIMAL(10, 2) NOT NULL,
    payment_method ENUM('Cash', 'Credit Card', 'Debit Card', 'GCash', 'Bank Transfer') NOT NULL,
    status ENUM('Pending', 'Confirmed', 'Processing', 'Shipped', 'Completed', 'Cancelled') DEFAULT 'Pending',
    order_date DATE NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (customer_id) REFERENCES customers(id) ON DELETE CASCADE,
    FOREIGN KEY (product_id) REFERENCES products(id) ON DELETE RESTRICT,
    INDEX idx_status (status),
    INDEX idx_date (order_date),
    INDEX idx_customer (customer_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Purchase History View (for customer records)
CREATE TABLE IF NOT EXISTS purchase_history (
    id INT PRIMARY KEY AUTO_INCREMENT,
    customer_id INT NOT NULL,
    order_id INT NOT NULL,
    amount DECIMAL(10, 2) NOT NULL,
    purchase_date DATE NOT NULL,
    status VARCHAR(20) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (customer_id) REFERENCES customers(id) ON DELETE CASCADE,
    FOREIGN KEY (order_id) REFERENCES orders(id) ON DELETE CASCADE,
    INDEX idx_customer (customer_id),
    INDEX idx_date (purchase_date)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Insert sample products
INSERT INTO products (name, category, price, quantity_in_stock, status) VALUES
('Cement (50kg)', 'Building Materials', 750.00, 245, 'In Stock'),
('Latex Paint (1L)', 'Paint & Coatings', 350.00, 78, 'In Stock'),
('Claw Hammer', 'Tools', 600.00, 156, 'In Stock'),
('Screwdriver Set', 'Tools', 450.00, 42, 'Low Stock'),
('Paint Roller', 'Tools', 210.00, 89, 'In Stock'),
('Pliers', 'Tools', 350.00, 18, 'Low Stock'),
('Wood Nails (1kg)', 'Hardware', 120.00, 234, 'In Stock'),
('Sandpaper (Pack)', 'Finishing', 85.00, 156, 'In Stock');

-- Insert sample customers
INSERT INTO customers (customer_id, name, email, contact, address, status, date_registered) VALUES
('#CUST-001', 'Juan Dela Cruz', 'juan.cruz@email.com', '0917-123-4567', 'Brgy. San Isidro, Quezon City', 'Active', '2025-08-15'),
('#CUST-002', 'Maria Santos', 'maria.santos@email.com', '0918-234-5678', 'Brgy. Kapitolyo, Makati', 'Active', '2025-09-10'),
('#CUST-003', 'Pedro Garcia', 'pedro.garcia@email.com', '0919-345-6789', 'Brgy. Bagumbayan, Taguig', 'Active', '2025-09-20'),
('#CUST-004', 'Ana Rodriguez', 'ana.rodriguez@email.com', '0944-222-3333', 'Brgy. Santa Cruz, Manila', 'Active', '2025-09-30');

-- Insert sample orders
INSERT INTO orders (order_id, customer_id, product_id, quantity, amount, payment_method, status, order_date) VALUES
('#ORD-1045', 1, 3, 2, 1200.00, 'Cash', 'Completed', '2026-02-05'),
('#ORD-1044', 2, 2, 3, 1050.00, 'Credit Card', 'Shipped', '2026-02-05'),
('#ORD-1043', 3, 4, 1, 450.00, 'Cash', 'Processing', '2026-02-05'),
('#ORD-1042', 4, 1, 5, 3750.00, 'GCash', 'Confirmed', '2026-02-04'),
('#ORD-1041', 1, 5, 2, 420.00, 'Cash', 'Pending', '2026-02-04');
