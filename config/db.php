<?php
// Detect if running inside Docker
$isDocker = file_exists('/.dockerenv');

// Choose host dynamically
$host = $isDocker ? "db" : "127.0.0.1";

$user = "root";
$pass = "";
$dbname = "Canteen_Management_System";

// Connect
$conn = new mysqli($host, $user, $pass, $dbname);

if ($conn->connect_error) {
    die("DB Connection failed: " . $conn->connect_error);
}

$conn->set_charset("utf8mb4");
