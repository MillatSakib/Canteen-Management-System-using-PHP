<?php
session_start();
require_once "../config/db.php";

if (!isset($_SESSION["user_id"]) || $_SESSION["role"] !== "admin") {
  header("Location: ../auth/login.php");
  exit;
}

if (!isset($_GET["id"])) {
  header("Location: modifyUser.php");
  exit;
}

$id = (int)$_GET["id"];

// prevent deleting admins just in case
$stmt = $conn->prepare("SELECT role FROM customers WHERE customer_id=?");
$stmt->bind_param("i", $id);
$stmt->execute();
$res = $stmt->get_result();
$user = $res->fetch_assoc();
$stmt->close();

if ($user && $user["role"] === "admin") {
  echo "<script>alert('Cannot delete an admin user.'); window.location.href = 'userManage.php';</script>";
  exit;
}

// soft delete
$stmt = $conn->prepare("UPDATE customers SET deleted='1' WHERE customer_id=?");
$stmt->bind_param("i", $id);
$stmt->execute();
$stmt->close();

echo "<script>
        alert('User deleted successfully!');
        window.location.href = 'userManage.php?deleted=1';
      </script>";
exit;
