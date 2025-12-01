<?php
// config/db.php
$host = getenv('DB_HOST') ?: '127.0.0.1';
$user = getenv('DB_USER') ?: 'root';
$pass = getenv('DB_PASSWORD') ?: '';
$dbname = getenv('DB_NAME') ?: 'Canteen_Management_System';

$conn = new mysqli($host, $user, $pass, $dbname);

if ($conn->connect_error) {
  die("DB Connection failed: " . $conn->connect_error);
}

$conn->set_charset("utf8mb4");
