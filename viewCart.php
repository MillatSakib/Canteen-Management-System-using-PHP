<?php
session_start();
require_once "./config/db.php";

// user must be logged in
if (!isset($_SESSION["user_id"])) {
  header("Location: auth/login.php");
  exit;
}

$cart = $_SESSION["cart"] ?? [];

// Load cart items
$items = [];
if (!empty($cart)) {
  $ids = implode(",", array_keys($cart));
  $items = $conn->query("SELECT product_id, product_name, price FROM products WHERE product_id IN ($ids)");
}

// Remove item
if (isset($_GET["remove"])) {
  $rid = (int)$_GET["remove"];
  unset($_SESSION["cart"][$rid]);
  header("Location: viewCart.php");
  exit;
}

// Place order
if ($_SERVER["REQUEST_METHOD"] === "POST" && isset($_POST["place_order"])) {

  if (empty($cart)) {
    header("Location: viewCart.php");
    exit;
  }

  $customer_id  = $_SESSION["user_id"];
  $order_status = "Pending";
  $total_amount = 0;

  // calculate total
  $ids = implode(",", array_keys($cart));
  $res = $conn->query("SELECT product_id, price FROM products WHERE product_id IN ($ids)");

  $prices = [];
  while($r = $res->fetch_assoc()){
    $prices[$r["product_id"]] = (float)$r["price"];
  }

  foreach($cart as $pid => $qty){
    $total_amount += $prices[$pid] * $qty;
  }

  // random employee ID 1–12
  $big_random  = random_int(100000, 999999999);
  $employee_id = ($big_random % 12) + 1;

  // Insert order
  $stmt = $conn->prepare("
    INSERT INTO orders (customer_id, employee_id, order_date, total_amount, order_status, status)
    VALUES (?, ?, NOW(), ?, ?, 'active')
  ");
  $stmt->bind_param("iids", $customer_id, $employee_id, $total_amount, $order_status);
  $stmt->execute();

  $order_id = $stmt->insert_id;
  $stmt->close();

  // Insert order items
  $stmtItem = $conn->prepare("
    INSERT INTO order_items (order_id, product_id, quantity, unit_price)
    VALUES (?, ?, ?, ?)
  ");

  // FIXED: correct stock update (NO double decrement)
  $stmtStock = $conn->prepare("
    UPDATE inventory 
    SET stock_quantity = stock_quantity - ?
    WHERE product_id = ?
  ");

  foreach($cart as $pid => $qty){

    // Insert order item
    $unit_price = $prices[$pid];
    $stmtItem->bind_param("iiid", $order_id, $pid, $qty, $unit_price);
    $stmtItem->execute();

    // FIXED: reduce stock ONCE ONLY
    $stmtStock->bind_param("ii", $qty, $pid);
    $stmtStock->execute();
  }

  $stmtItem->close();
  $stmtStock->close();

  // clear cart
  $_SESSION["cart"] = [];

  echo "<script>
          alert('Order placed successfully!');
          window.location.href = './status.php';
        </script>";
  exit;
}
?>

<!DOCTYPE html>
<html>
<head>
  <title>Your Cart</title>
  <link rel="stylesheet" href="assets/style.css">
  <style>
    .cart-card{
      background:#fff;
      border-radius:14px;
      padding:18px;
      box-shadow:0 8px 20px rgba(0,0,0,.08);
    }
    table{ width:100%; border-collapse: collapse; }
    th,td{ padding:12px; border-bottom:1px solid #e5e7eb; text-align:left; }
    .price{ font-weight:700; color:#16a34a; }
    .remove{ color:#dc2626; font-weight:700; text-decoration:none; }
  </style>
</head>
<body>
<div class="container">

  <div class="cart-card">
    <h2>🛒 Your Cart</h2>

    <?php if (empty($cart)): ?>
      <p>No items in cart.</p>
    <?php else: ?>
      <table>
        <thead>
          <tr>
            <th>Food</th>
            <th>Price</th>
            <th>Qty</th>
            <th>Subtotal</th>
            <th>Remove</th>
          </tr>
        </thead>
        <tbody>
          <?php 
            $grand = 0; 
            while($row = $items->fetch_assoc()): 
              $pid = $row["product_id"];
              $qty = $cart[$pid];
              $sub = $row["price"] * $qty;
              $grand += $sub;
          ?>
            <tr>
              <td><?= htmlspecialchars($row["product_name"]) ?></td>
              <td class="price">৳<?= number_format($row["price"],2) ?></td>
              <td><?= $qty ?></td>
              <td class="price">৳<?= number_format($sub,2) ?></td>
              <td><a class="remove" href="viewCart.php?remove=<?= $pid ?>">Remove</a></td>
            </tr>
          <?php endwhile; ?>
        </tbody>
      </table>

      <h3 style="margin-top:12px;">Total: ৳<?= number_format($grand,2) ?></h3>

      <form method="POST">
        <button name="place_order" class="btn" type="submit">Place Order</button>
      </form>

    <?php endif; ?>
  </div>

</div>
</body>
</html>
