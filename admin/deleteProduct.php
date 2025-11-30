<?php
// admin/delete_product.php (SOFT DELETE)
session_start();
require_once "../config/db.php";

// admin protection
if (!isset($_SESSION["user_id"]) || $_SESSION["role"] !== "admin") {
  header("Location: ../auth/login.php");
  exit;
}

if (!isset($_GET["id"])) {
  header("Location: products.php");
  exit;
}

$id = (int)$_GET["id"];

// soft delete -> set deleted = '1'
$stmt = $conn->prepare("UPDATE products SET deleted='1' WHERE product_id=?");
$stmt->bind_param("i", $id);
$stmt->execute();
$stmt->close();

header("Location: foodModify.php?deleted=1");
exit;
