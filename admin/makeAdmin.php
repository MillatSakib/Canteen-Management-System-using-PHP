<?php
session_start();
require_once "../config/db.php";

if (!isset($_SESSION["user_id"]) || $_SESSION["role"] !== "admin") {
  header("Location: ../auth/login.php");
  exit;
}

if (!isset($_GET["id"])) {
  echo "<script>alert('Cannot make admin from user.'); window.location.href = 'userManage.php';</script>";
 
  exit;
}

$id = (int)$_GET["id"];

// promote only non-admin users
$stmt = $conn->prepare("UPDATE customers SET role='admin' WHERE customer_id=? AND role='user'");
$stmt->bind_param("i", $id);
$stmt->execute();
$stmt->close();
echo "<script>
        alert('User promoted to admin successfully!');
        window.location.href = 'userManage.php?promoted=1';
      </script>";
exit;
