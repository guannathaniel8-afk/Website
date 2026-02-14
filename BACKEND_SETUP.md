# Padua Hardware CRM - Backend Setup Guide

## 📋 System Requirements
- PHP 7.4+ (with MySQLi extension)
- MySQL 5.7+ or MariaDB 10.3+
- Local development server (XAMPP, WAMP, LAMP, or similar)

---

## 🚀 Setup Instructions

### Step 1: Database Setup

1. **Open phpMyAdmin** (usually at `http://localhost/phpmyadmin`)
2. **Import the SQL file:**
   - Click "Import" tab
   - Choose `padua_hardware_setup.sql`
   - Click "Go"
   - Database `padua_hardware_crm` will be created with tables and sample data

**OR** - Run via command line:
```bash
mysql -u root -p < padua_hardware_setup.sql
```

### Step 2: Configure Database Connection

Edit `config/db_config.php` and update these values if needed:

```php
define('DB_HOST', 'localhost');   // Database host
define('DB_USER', 'root');        // Database username
define('DB_PASS', '');            // Database password (empty for local)
define('DB_NAME', 'padua_hardware_crm');  // Database name
```

### Step 3: File Structure

```
Offline/
├── config/
│   └── db_config.php          # Database connection
├── api/
│   ├── customers.php          # Customers API
│   ├── orders.php             # Orders API
│   └── products.php           # Products API
├── Staff1.html                # Frontend (updated)
├── padua_hardware_setup.sql   # Database schema
└── README.md                  # This file
```

### Step 4: Start Local Server

For **XAMPP**:
1. Start Apache and MySQL from XAMPP Control Panel
2. Access at: `http://localhost/Offline/Staff1.html`

For **WAMP**:
1. Start all services from WAMP tray menu
2. Access at: `http://localhost/Offline/Staff1.html`

---

## 🔌 API Endpoints

### Customers API

**Get All Customers:**
```
GET http://localhost/Offline/api/customers.php?action=all
```

**Get Single Customer:**
```
GET http://localhost/Offline/api/customers.php?action=single&id=1
```

**Add Customer:**
```
POST http://localhost/Offline/api/customers.php
Content-Type: application/json

{
  "name": "John Doe",
  "email": "john@example.com",
  "contact": "09171234567",
  "address": "123 Main St, Manila"
}
```

**Update Customer:**
```
PUT http://localhost/Offline/api/customers.php
Content-Type: application/json

{
  "id": 1,
  "name": "John Doe",
  "email": "john@example.com",
  "contact": "09171234567",
  "address": "123 Main St, Manila",
  "status": "Active"
}
```

**Delete Customer:**
```
DELETE http://localhost/Offline/api/customers.php?id=1
```

---

### Orders API

**Get All Orders:**
```
GET http://localhost/Offline/api/orders.php?action=all
```

**Add Order:**
```
POST http://localhost/Offline/api/orders.php
Content-Type: application/json

{
  "customer": "Juan Dela Cruz",
  "product": "Cement (50kg)",
  "quantity": 2,
  "paymentMethod": "Cash"
}
```

**Update Order Status:**
```
PUT http://localhost/Offline/api/orders.php
Content-Type: application/json

{
  "id": 1,
  "status": "Completed"
}
```

**Delete Order:**
```
DELETE http://localhost/Offline/api/orders.php?id=1
```

---

### Products API

**Get All Products:**
```
GET http://localhost/Offline/api/products.php?action=all
```

---

## 🔄 Frontend Integration

The `Staff1.html` has been updated to use backend API calls. Key changes:

### Before (Local Data):
```javascript
const customersData = [...];
customersData.push(newCustomer);
```

### After (Backend):
```javascript
fetch('api/customers.php', {
  method: 'POST',
  headers: { 'Content-Type': 'application/json' },
  body: JSON.stringify(formData)
})
.then(response => response.json())
.then(data => {
  // Handle response
})
```

---

## ✅ Testing

### Test Add Customer:
1. Navigate to Staff1.html
2. Click "Add New Customer"
3. Fill in form and submit
4. Check browser Console (F12) for logs
5. Verify customer appears in table

### Test Create Order:
1. Click "Create New Order"
2. Select customer, product, quantity, payment
3. Click "Create Order"
4. Verify order appears in table and metrics update

### Test via API:
Use **Postman** or **cURL**:

```bash
# Get all customers
curl http://localhost/Offline/api/customers.php?action=all

# Add customer
curl -X POST http://localhost/Offline/api/customers.php \
  -H "Content-Type: application/json" \
  -d '{"name":"Test","email":"test@test.com","contact":"0917000","address":"Test Address"}'
```

---

## 🐛 Troubleshooting

### "Connection failed" error
- Check MySQL is running
- Verify DB credentials in `config/db_config.php`
- Check database name is `padua_hardware_crm`

### "404 Not Found" on API calls
- Ensure files are in correct folder: `api/customers.php`
- Check URL path matches your server setup

### Changes not appearing
- Clear browser cache (Ctrl+Shift+Delete)
- Check browser Console for errors (F12)
- Verify PHP error logs

### CORS errors
- CORS headers are already set in API files
- If still issues, add `.htaccess` file:
```
Header set Access-Control-Allow-Origin "*"
Header set Access-Control-Allow-Methods "GET, POST, PUT, DELETE"
Header set Access-Control-Allow-Headers "Content-Type"
```

---

## 📊 Database Schema

### customers
- id (Primary Key)
- customer_id (#CUST-001 format)
- name
- email
- contact
- address
- status (Active, Pending, Inactive)
- date_registered
- created_at, updated_at

### orders
- id (Primary Key)
- order_id (#ORD-1001 format)
- customer_id (Foreign Key)
- product_id (Foreign Key)
- quantity
- amount
- payment_method
- status (Pending, Confirmed, Processing, Shipped, Completed, Cancelled)
- order_date
- created_at, updated_at

### products
- id (Primary Key)
- name
- category
- price
- quantity_in_stock
- status (In Stock, Low Stock, Out of Stock)
- created_at, updated_at

---

## 🔐 Security Notes

⚠️ **For Production, add:**
1. Input validation/sanitization
2. SQL injection prevention (using prepared statements ✓)
3. Authentication/Authorization
4. Rate limiting
5. HTTPS/SSL
6. Better error handling
7. Logging and monitoring

---

## 📞 Support

For issues, check:
1. Browser Console (F12)
2. PHP error logs
3. MySQL error logs
4. Network tab in DevTools to see API responses

---

**Last Updated:** February 6, 2026
