<?php
session_start();
require_once "./config/db.php";

if (!isset($_SESSION["user_id"])) {
  header("Location: ../auth/login.php");
  exit;
}

// Initialize cart
if (!isset($_SESSION["cart"])) {
  $_SESSION["cart"] = [];  // product_id => quantity
}

// Handle Add to Cart
if ($_SERVER["REQUEST_METHOD"] === "POST" && isset($_POST["add_to_cart"])) {
  $pid = (int)$_POST["product_id"];
  $qty = max(1, (int)$_POST["quantity"]);

  if (isset($_SESSION["cart"][$pid])) {
    $_SESSION["cart"][$pid] += $qty;
  } else {
    $_SESSION["cart"][$pid] = $qty;
  }

  header("Location: orderFood.php?added=1");
  exit;
}

// Fetch foods (only active + with stock)
$sql = "
  SELECT 
    p.product_id, p.product_name, p.description, p.price,
    c.category_name,
    i.stock_quantity
  FROM products p
  LEFT JOIN categories c ON p.category_id = c.category_id
  LEFT JOIN inventory i ON p.product_id = i.product_id
  WHERE p.deleted='0'
  ORDER BY p.product_id ASC
";
$result = $conn->query($sql);
?>
<!DOCTYPE html>
<html>
<head>
  <title>Order Food</title>
  <link rel="stylesheet" href="../assets/style.css">
  <style>
    .table-wrap{
      overflow-x:auto;
      background:#fff;
      border-radius:14px;
      box-shadow:0 8px 20px rgba(0,0,0,.08);
    }
    table{
      width:100%;
      border-collapse:collapse;
      min-width:900px;
    }
    thead{
      background:linear-gradient(135deg,#1d4ed8,#3b82f6);
      color:#fff;
    }
    th,td{
      padding:14px 16px;
      text-align:left;
      border-bottom:1px solid #e5e7eb;
      font-size:15px;
      vertical-align:middle;
    }
    tr:hover td{ background:#f8fafc; }
    .price{ font-weight:700; color:#16a34a; }
    .stock-ok{ color:#16a34a; font-weight:700; }
    .stock-low{ color:#f59e0b; font-weight:700; }
    .stock-out{ color:#dc2626; font-weight:700; }
    .qty-input{
      width:70px;
      padding:6px;
      border:1px solid #d1d5db;
      border-radius:8px;
    }
    .btn-sm{
      padding:8px 12px;
      border-radius:8px;
      font-size:14px;
      background:linear-gradient(135deg,#1d4ed8,#3b82f6);
      color:white;
      border:none;
      cursor:pointer;
      font-weight:600;
    }
    .btn-sm:disabled{
      opacity:.5; cursor:not-allowed;
    }
    .header-row{
      display:flex;
      justify-content:space-between;
      align-items:center;
      flex-wrap:wrap;
      gap:12px;
      margin-bottom:16px;
    }
    .cart-badge{
      background:#111827;
      color:#fff;
      padding:6px 10px;
      border-radius:999px;
      font-size:13px;
      font-weight:700;
    }
  </style>
</head>
<body>

<div class="container">

  <div class="header-row">
    <h2>🍽️ Order Food</h2>
    <div class="nav">
      <a class="btn" href="./user_home.php">Home</a>
      <a class="btn" href="viewCart.php">
        Cart 
        <span class="cart-badge">
          <?= array_sum($_SESSION["cart"]) ?>
        </span>
      </a>
    </div>
  </div>

  <?php if (isset($_GET["added"])): ?>
    <p class="success">✅ Added to cart!</p>
  <?php endif; ?>

  <div class="table-wrap">
    <table>
      <thead>
        <tr>
          <th>Food</th>
          <th>Category</th>
          <th>Description</th>
          <th>Price</th>
          <th>Stock</th>
          <th>Qty</th>
          <th>Add</th>
        </tr>
      </thead>
      <tbody>
        <?php if ($result && $result->num_rows > 0): ?>
          <?php while($row = $result->fetch_assoc()): 
            $stock = (int)($row["stock_quantity"] ?? 0);
            $stockClass = $stock <= 0 ? "stock-out" : ($stock <= 5 ? "stock-low" : "stock-ok");
          ?>
            <tr>
              <td><?= htmlspecialchars($row["product_name"]) ?></td>
              <td><?= htmlspecialchars($row["category_name"] ?? "N/A") ?></td>
              <td><?= htmlspecialchars($row["description"]) ?></td>
              <td class="price">৳<?= number_format($row["price"],2) ?></td>
              <td class="<?= $stockClass ?>">
                <?= $stock > 0 ? $stock . " available" : "Out of stock" ?>
              </td>
              <td>
                <form method="POST" style="display:flex;gap:8px;align-items:center;">
                  <input type="hidden" name="product_id" value="<?= $row["product_id"] ?>">
                  <input class="qty-input" type="number" name="quantity" value="1" min="1"
                         max="<?= max(1,$stock) ?>">
              </td>
              <td>
                  <button class="btn-sm" type="submit" name="add_to_cart"
                          <?= $stock <= 0 ? "disabled" : "" ?>>
                    Add to Cart
                  </button>
                </form>
              </td>
            </tr>
          <?php endwhile; ?>
        <?php else: ?>
          <tr><td colspan="7" style="text-align:center;padding:20px;">No foods found.</td></tr>
        <?php endif; ?>
      </tbody>
    </table>
  </div>

</div>
</body>
</html>
