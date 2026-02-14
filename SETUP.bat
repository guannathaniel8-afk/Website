@echo off
REM Padua Hardware CRM - Quick Setup Script for Windows

echo.
echo ====================================
echo Padua Hardware CRM - Backend Setup
echo ====================================
echo.

REM Check if running from correct directory
if not exist "config\db_config.php" (
    echo ERROR: Please run this script from the Offline folder
    echo Expected files: config\db_config.php, api\customers.php, etc.
    pause
    exit /b 1
)

echo [✓] Folder structure verified

echo.
echo ====================================
echo SETUP STEPS:
echo ====================================
echo.
echo 1. DATABASE SETUP
echo    - Open phpMyAdmin: http://localhost/phpmyadmin
echo    - Click "Import" tab
echo    - Choose file: padua_hardware_setup.sql
echo    - Click "Go"
echo.
echo 2. DATABASE CONFIGURATION
echo    - Edit: config\db_config.php
echo    - Update DB_HOST, DB_USER, DB_PASS if needed
echo    - Default: localhost, root, (empty password)
echo.
echo 3. START LOCAL SERVER
echo    - Start Apache and MySQL
echo    - For XAMPP: Open XAMPP Control Panel and click "Start"
echo    - For WAMP: Click WAMP tray icon → Start services
echo.
echo 4. ACCESS APPLICATION
echo    - Open browser: http://localhost/Offline/Staff1.html
echo    - Check Console (F12) for backend connection status
echo.
echo 5. TEST FEATURES
echo    - Click "Add New Customer" button
echo    - Fill form and submit
echo    - Check if customer appears in table
echo.
echo ====================================
echo TROUBLESHOOTING:
echo ====================================
echo.
echo - If "Connection failed": Check MySQL is running
echo - If "404 Not Found": Verify file paths in api\ folder
echo - If changes not showing: Clear browser cache (Ctrl+Shift+Delete)
echo - Check browser Console (F12) for error messages
echo.
echo ====================================
echo FILES CREATED:
echo ====================================
echo.
echo config/
echo   └── db_config.php          (Database connection)
echo api/
echo   ├── customers.php          (Customers API)
echo   ├── orders.php             (Orders API)
echo   └── products.php           (Products API)
echo.
echo ====================================
echo DOCUMENTATION:
echo ====================================
echo.
echo - Open BACKEND_SETUP.md for detailed guide
echo - Check API endpoints documentation
echo - See troubleshooting section for common issues
echo.
pause
