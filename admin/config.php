<?php
/* 
   Dynamic Database Configuration
   - Uses host = "db" inside Docker
   - Uses host = "localhost" in local XAMPP/WAMP
*/

// Detect if script is running inside a Docker container
$isDocker = file_exists('/.dockerenv');

// Dynamic Host
$dynamicHost = $isDocker ? 'db' : 'localhost';

// CONSTANTS
define('DB_SERVER', $dynamicHost);
define('DB_USERNAME', 'root');
define('DB_PASSWORD', '');
define('DB_NAME', 'Canteen_Management_System');

// Attempt to connect to MySQL database
$link = mysqli_connect(DB_SERVER, DB_USERNAME, DB_PASSWORD, DB_NAME);

// Check connection
if ($link === false) {
    die("ERROR: Could not connect. " . mysqli_connect_error());
}
?>
