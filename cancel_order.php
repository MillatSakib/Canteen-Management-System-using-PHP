<?php
session_start();
require_once "./config/db.php";

if (!isset($_SESSION["user_id"])) {
    header("Location: ../auth/login.php");
    exit;
}

if ($_SERVER["REQUEST_METHOD"] === "POST") {

    $order_id = intval($_POST["order_id"]);
    $customer_id = $_SESSION["user_id"];

    // Check if order belongs to this user & is pending
    $stmt = $conn->prepare("
        SELECT order_status FROM orders 
        WHERE order_id = ? AND customer_id = ? AND status = 'active'
    ");
    $stmt->bind_param("ii", $order_id, $customer_id);
    $stmt->execute();
    $result = $stmt->get_result();
    $order = $result->fetch_assoc();
    $stmt->close();

    if (!$order) {
        die("Invalid Order");
    }

    if (strtolower($order["order_status"]) !== "pending") {
        die("Only pending orders can be cancelled.");
    }

    // Update order status
    $update = $conn->prepare("
        UPDATE orders SET order_status = 'Rejected'
        WHERE order_id = ? AND customer_id = ?
    ");
    $update->bind_param("ii", $order_id, $customer_id);
    $update->execute();
    $update->close();

    header("Location: status.php?cancel_success=1");
    exit;
}
?>
