# Testing Guide - Staff Dashboard Backend Integration

## Quick Start (5 minutes)

### Prerequisites
- XAMPP, WAMP, or similar local server installed and running
- Apache and MySQL services started
- `padua_hardware_setup.sql` imported into MySQL

### Step 1: Verify Database
```bash
# Open phpMyAdmin at: http://localhost/phpmyadmin
# Click on 'padua_hardware_crm' database
# You should see 4 tables:
  - customers (with 4 sample records)
  - products (with 8 sample products)
  - orders (with 5 sample orders)
  - purchase_history
```

### Step 2: Verify Database Configuration
1. Open `config/db_config.php`
2. Check database credentials match your setup:
   ```php
   define('DB_HOST', 'localhost');
   define('DB_USER', 'root');
   define('DB_PASS', '');
   define('DB_NAME', 'padua_hardware_crm');
   ```

### Step 3: Test Backend API
Open browser and test each endpoint:

#### Get Customers
```
http://localhost/Offline/api/customers.php?action=all
```
**Expected Response:**
```json
{
  "success": true,
  "customers": [
    { "id": 1, "customer_id": "#CUST-001", "name": "John Doe", ... },
    { "id": 2, "customer_id": "#CUST-002", "name": "Jane Smith", ... }
  ]
}
```

#### Get Orders
```
http://localhost/Offline/api/orders.php?action=all
```
**Expected Response:**
```json
{
  "success": true,
  "orders": [
    { "id": 1, "order_id": "#ORD-1001", "customer_id": 1, ... }
  ]
}
```

#### Get Products
```
http://localhost/Offline/api/products.php?action=all
```
**Expected Response:**
```json
{
  "success": true,
  "products": [
    { "id": 1, "name": "Hammer", "price": 450.00, ... }
  ]
}
```

---

## Testing Add Customer Feature

### Step 1: Open Staff1.html
Navigate to: `http://localhost/Offline/Staff1.html`

### Step 2: Open Browser Console
- Press **F12** to open Developer Tools
- Click **Console** tab
- Look for these messages:
  ```
  Backend API URL: http://localhost/Offline/api
  Add Customer button should call: submitAddCustomer()
  Loading data from backend...
  Fetching customers from backend...
  Customers loaded from backend, count: 4
  ```

### Step 3: Verify Customers Table
- Go to **Customers** section
- Should see 4 customers from database:
  1. John Doe
  2. Jane Smith
  3. Michael Johnson
  4. Sarah Williams

### Step 4: Add New Customer
1. Click **"Add New Customer"** button
2. Fill in the form:
   - **Name:** Test Customer
   - **Email:** test@example.com
   - **Contact:** 09123456789
   - **Address:** 123 Test Street
3. Click **"Add Customer"** button
4. **Console should show:**
   ```
   submitAddCustomer called
   Form values: {name: 'Test Customer', email: 'test@example.com', contact: '09123456789', address: '123 Test Street'}
   Sending payload to API: {name: 'Test Customer', email: 'test@example.com', contact: '09123456789', address: '123 Test Street'}
   Response status: 200
   Backend response: {success: true, message: 'Customer added successfully', customer_id: '#CUST-005', id: 5}
   ```
5. **Alert should appear:** "Customer Test Customer has been added successfully!"
6. **Form should close and table should refresh** showing 5 customers now
7. New customer should appear with ID **#CUST-005**

### Step 5: Verify Database Persistence
1. Open phpMyAdmin
2. Go to **padua_hardware_crm** → **customers** table
3. Should see new customer "Test Customer" in the table
4. Refresh Staff1.html (F5)
5. Customer should still be there (persistence check)

---

## Testing Create Order Feature

### Step 1: Go to Orders Section
1. Click **Orders** in sidebar
2. Should see 5 sample orders from database

### Step 2: Create New Order
1. Click **"Create New Order"** button
2. Fill in the form:
   - **Customer:** Select "John Doe" (or any existing customer)
   - **Product:** Select "Hammer" (or any existing product)
   - **Quantity:** 2
   - **Payment Method:** Select "Cash"
3. Click **"Create Order"** button
4. **Console should show:**
   ```
   submitCreateOrder called
   Form values: {customer: 'John Doe', product: 'Hammer', quantity: 2, payment: 'Cash'}
   Sending payload to API: {customer: 'John Doe', product: 'Hammer', quantity: 2, paymentMethod: 'Cash'}
   Response status: 200
   Backend response: {success: true, message: 'Order created successfully', order_id: '#ORD-1006', id: 6}
   ```
5. **Alert should appear:** "Order #ORD-1006 created successfully!"
6. **Modal should close and table should refresh** showing 6 orders now
7. New order should appear in the table

### Step 3: Verify Order Details
Look for the new order in the table with:
- Order ID: #ORD-1006
- Customer: John Doe
- Product: Hammer
- Quantity: 2
- Amount: Should be calculated (Hammer price × 2)
- Status: Pending

### Step 4: Verify Database Persistence
1. Open phpMyAdmin
2. Go to **padua_hardware_crm** → **orders** table
3. Should see new order
4. Refresh Staff1.html
5. Order should still be there

### Step 5: Check Sales Metrics
Metrics at the top should update:
- **Total Sales** - should include new order amount
- **Total Orders** - should be 6 now
- **Completed Orders** - should still be 4 (new order is Pending)

---

## Troubleshooting

### Issue: "Cannot GET /api/customers.php"
**Problem:** API file not found
**Solution:**
1. Check file exists at `c:\Users\Admin\Documents\Offline\api\customers.php`
2. Check URL: Should be `http://localhost/Offline/api/customers.php`
3. Verify case sensitivity (file should be lowercase `.php`)

### Issue: Database Connection Error
**Problem:** Cannot connect to MySQL
**Solution:**
1. Ensure MySQL service is running
2. Open phpMyAdmin: `http://localhost/phpmyadmin`
3. Check database `padua_hardware_crm` exists
4. Verify credentials in `config/db_config.php`:
   - DB_USER should be 'root'
   - DB_PASS should be empty (or your password)

### Issue: "Product not found" or "Customer not found"
**Problem:** Selected customer/product doesn't exist
**Solution:**
1. Check browser console
2. Verify customer/product name matches exactly
3. Ensure dropdown is populated from database
4. Check phpMyAdmin to see available customers/products

### Issue: Form Won't Submit
**Problem:** Submit button not working
**Solution:**
1. Check browser console (F12) for JavaScript errors
2. Verify form fields have correct IDs:
   - `newCustomerName`, `newCustomerEmail`, `newCustomerContact`, `newCustomerAddress`
   - `orderCustomer`, `orderProduct`, `orderQuantity`, `orderPayment`
3. Check button has `type="button"` attribute

### Issue: API Returns Error
**Problem:** Server error 500 or connection refused
**Solution:**
1. Check browser Network tab (F12 → Network):
   - Click failed request
   - Check "Response" tab for error message
2. Check Apache error log
3. Verify database credentials in `config/db_config.php`
4. Check database connection status in phpMyAdmin

### Issue: Customer/Product Dropdown Empty
**Problem:** Products not showing in dropdown
**Solution:**
1. Check browser console for errors
2. Verify `fetchProductsForDropdown()` is called
3. Check products exist in database: `phpmyadmin → padua_hardware_crm → products`
4. Ensure API returns products correctly

---

## Console Debugging Checklist

When testing, check console (F12) shows these in order:

### On Page Load:
```
✓ Backend API URL: http://localhost/Offline/api
✓ Loading data from backend...
✓ Fetching customers from backend...
✓ Customers loaded from backend, count: 4
✓ Fetching orders from backend...
✓ Orders loaded from backend, count: 5
✓ Fetching products for dropdown...
✓ Products dropdown populated
```

### On Add Customer:
```
✓ submitAddCustomer called
✓ Form values: {...}
✓ Sending payload to API: {...}
✓ Response status: 200
✓ Backend response: {success: true, ...}
✓ Customers loaded from backend, count: 5
```

### On Create Order:
```
✓ submitCreateOrder called
✓ Form values: {...}
✓ Sending payload to API: {...}
✓ Response status: 200
✓ Backend response: {success: true, ...}
✓ Orders loaded from backend, count: 6
```

---

## Success Indicators

✅ **All Pass:** System is working correctly

- [ ] API endpoints return JSON with `"success": true`
- [ ] Customers table shows 4 sample customers on load
- [ ] Orders table shows 5 sample orders on load
- [ ] Can add new customer and see it appear in table
- [ ] Can create new order and see it appear in table
- [ ] New customer/order appear in database after page refresh
- [ ] Product dropdown populated when creating order
- [ ] Sales metrics update when new order created
- [ ] No red errors in browser console (F12)
- [ ] Modals close after successful submission
- [ ] Forms clear after submission

---

## Test Data Reference

### Sample Customers (in database):
1. **#CUST-001** - John Doe (john@example.com)
2. **#CUST-002** - Jane Smith (jane@example.com)
3. **#CUST-003** - Michael Johnson (michael@example.com)
4. **#CUST-004** - Sarah Williams (sarah@example.com)

### Sample Products (in database):
1. **Hammer** - ₱450.00
2. **Wrench** - ₱350.00
3. **Drill** - ₱2,500.00
4. **Saw** - ₱650.00
5. **Screwdriver** - ₱150.00
6. **Measuring Tape** - ₱250.00
7. **Power Drill** - ₱3,500.00
8. **Safety Helmet** - ₱300.00

### Sample Orders (in database):
1. **#ORD-1001** - John Doe → Hammer × 1
2. **#ORD-1002** - Jane Smith → Wrench × 2
3. **#ORD-1003** - Michael Johnson → Drill × 1
4. **#ORD-1004** - Sarah Williams → Saw × 3
5. **#ORD-1005** - John Doe → Power Drill × 1

---

## Next Steps After Testing

If all tests pass:
1. ✅ System is ready for production use
2. ✅ Staff can now add customers and create orders
3. ✅ Data persists in database
4. ✅ Consider adding more features (authentication, reporting, etc.)

If any tests fail:
1. Check the troubleshooting section above
2. Review the error message in browser console (F12)
3. Check the Network tab to see API response
4. Verify database has correct data in phpMyAdmin

---

**Last Updated:** February 6, 2026
**Version:** 1.0
