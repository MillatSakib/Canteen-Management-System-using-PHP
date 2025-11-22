<?php
session_start();
require_once "../config/db.php";

// admin protection
if (!isset($_SESSION["user_id"]) || $_SESSION["role"] !== "admin") {
  header("Location: ../auth/login.php");
  exit;
}

if ($_SERVER["REQUEST_METHOD"] !== "POST") {
  header("Location: statusUpdate.php");
  exit;
}

$order_id = (int)($_POST["order_id"] ?? 0);
$order_status = trim($_POST["order_status"] ?? "");

$allowed = ["Pending", "Delivered", "Rejected"];
if ($order_id <= 0 || !in_array($order_status, $allowed)) {
  header("Location: statusUpdate.php");
  exit;
}

$stmt = $conn->prepare("UPDATE orders SET order_status=? WHERE order_id=?");
$stmt->bind_param("si", $order_status, $order_id);
$stmt->execute();
$stmt->close();

header("Location: statusUpdate.php?updated=1");
exit;
