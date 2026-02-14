# Quick Reference Card

## 🚀 Get Started in 3 Steps

### Step 1: Setup Database
```bash
# Option A: Command Line
mysql -u root -p < padua_hardware_setup.sql

# Option B: phpMyAdmin
# 1. Open http://localhost/phpmyadmin
# 2. Click "Import"
# 3. Select padua_hardware_setup.sql
# 4. Click "Go"
```

### Step 2: Verify API Works
Open in browser:
```
http://localhost/Offline/health-check.html
```
All items should show GREEN ✓

### Step 3: Test Features
Open in browser:
```
http://localhost/Offline/Staff1.html
```

---

## 🧪 Quick Tests

### Add Customer
| Step | Action | Expected |
|------|--------|----------|
| 1 | Click "Add New Customer" | Modal opens |
| 2 | Fill form with data | Form shows values |
| 3 | Click "Add Customer" | Success alert |
| 4 | Look at table | New customer appears |

### Create Order
| Step | Action | Expected |
|------|--------|----------|
| 1 | Click "Create New Order" | Modal opens |
| 2 | Select customer, product, qty, payment | Dropdown shows options |
| 3 | Click "Create Order" | Success alert |
| 4 | Look at table | New order appears |

---

## 🔍 Debugging

### Open Console (Essential!)
```
Press F12 → Click Console tab
```

### Look for These Logs
✅ Should see:
```
Fetching customers from backend...
Customers loaded from backend, count: 4
Fetching orders from backend...
Orders loaded from backend, count: 5
```

❌ If you see errors:
```
Backend fetch error
Cannot connect to API
```
→ Check: Is Apache running? Is MySQL running?

---

## 📋 Checklist

- [ ] Apache service running
- [ ] MySQL service running
- [ ] Database `padua_hardware_crm` exists in phpMyAdmin
- [ ] `customers` table has 4 records
- [ ] `products` table has 8 records
- [ ] `orders` table has 5 records
- [ ] `health-check.html` shows all GREEN ✓
- [ ] Can add customer successfully
- [ ] Can create order successfully
- [ ] New data appears after refresh

---

## 🆘 Common Errors

| Error | Solution |
|-------|----------|
| Cannot GET /api/customers.php | Start Apache, check file exists |
| Database connection failed | Start MySQL, check credentials in config/db_config.php |
| Product not found | Ensure product exists in database |
| Customer not found | Ensure customer exists in database |
| No data displays | Check browser console (F12) for errors |

---

## 📂 Important Files

| File | Purpose | Status |
|------|---------|--------|
| `Staff1.html` | Main dashboard | ✅ Ready |
| `api/customers.php` | Customer API | ✅ Fixed |
| `api/orders.php` | Orders API | ✅ Fixed |
| `config/db_config.php` | DB config | ✅ Fixed |
| `padua_hardware_setup.sql` | Database schema | ✅ Ready |
| `health-check.html` | Verify system | ✅ New |
| `TESTING_GUIDE.md` | Full testing guide | ✅ New |
| `FIXES_SUMMARY.md` | What was fixed | ✅ New |

---

## 🔗 URLs

| URL | Purpose |
|-----|---------|
| http://localhost/phpmyadmin | Database manager |
| http://localhost/Offline/Staff1.html | Main dashboard |
| http://localhost/Offline/health-check.html | System check |
| http://localhost/Offline/api/customers.php?action=all | Get all customers |
| http://localhost/Offline/api/orders.php?action=all | Get all orders |
| http://localhost/Offline/api/products.php?action=all | Get all products |

---

## 💡 Tips

1. **Use health-check.html first** - It tells you what's working
2. **Check console (F12)** - Most issues are logged there
3. **Use phpMyAdmin** - Verify data is actually in database
4. **Refresh page (F5)** - After big changes
5. **Clear cache (Ctrl+Shift+Del)** - If something seems stuck

---

## ✅ Success Indicators

- Dashboard loads without errors
- 4 customers visible in Customers section
- 5 orders visible in Orders section
- Can add new customer and see it immediately
- Can create new order and see it immediately
- New data persists after page refresh
- No red errors in console (F12)

---

## 📞 Still Stuck?

1. **Read TESTING_GUIDE.md** - Has detailed troubleshooting
2. **Check health-check.html** - Identifies the exact issue
3. **Open Console (F12)** - Look for error messages
4. **Use Network tab (F12)** - See what API is returning
5. **Check phpMyAdmin** - Verify data in database

---

**Last Updated:** February 6, 2026
**Status:** ✅ All Systems Ready

