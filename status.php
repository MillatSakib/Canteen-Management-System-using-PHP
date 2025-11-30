<?php
session_start();
require_once "./config/db.php";

if (!isset($_SESSION["user_id"])) {
  header("Location: ../auth/login.php");
  exit;
}

$customer_id = $_SESSION["user_id"];

// get all orders for this user
$stmt = $conn->prepare("
  SELECT order_id, order_date, total_amount, order_status
  FROM orders
  WHERE customer_id = ? AND status = 'active'
  ORDER BY order_id ASC
");
$stmt->bind_param("i", $customer_id);
$stmt->execute();
$orders = $stmt->get_result();
$stmt->close();
?>
<!DOCTYPE html>
<html>
<head>
  <title>Order Status</title>
  <link rel="stylesheet" href="./assets/style.css">
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
      min-width:800px;
    }
    thead{
      background:linear-gradient(135deg,#1d4ed8,#3b82f6);
      color:#fff;
    }
    th, td{
      padding:14px 16px;
      text-align:left;
      border-bottom:1px solid #e5e7eb;
      font-size:15px;
      vertical-align:middle;
    }
    tr:hover td{ background:#f8fafc; }

    .badge{
      padding:5px 10px;
      border-radius:999px;
      font-size:12px;
      font-weight:800;
      display:inline-block;
      letter-spacing:.2px;
    }
    .badge-pending{ background:#f59e0b; color:white; }
    .badge-delivered{ background:#16a34a; color:white; }
    .badge-cancelled{ background:#dc2626; color:white; }

    details{
      background:#f8fafc;
      border-radius:10px;
      padding:10px 12px;
      margin:8px 0 0;
      border:1px solid #e5e7eb;
    }
    summary{
      cursor:pointer;
      font-weight:700;
    }
    .items-table{
      width:100%;
      border-collapse:collapse;
      margin-top:8px;
    }
    .items-table th, .items-table td{
      padding:8px;
      border-bottom:1px solid #e5e7eb;
      font-size:14px;
    }
    .price{ font-weight:700; color:#16a34a; }

    .header-row{
      display:flex;
      justify-content:space-between;
      align-items:center;
      flex-wrap:wrap;
      gap:12px;
      margin-bottom:16px;
    }


    
  </style>
</head>
<body>

<div class="container">

  <div class="header-row">
    <h2>🧾 My Order Status</h2>
    <div class="nav">
      <a class="home-btn__text" href="./user_home.php">Home</a>
      <a class="home-btn__text" href="orderFood.php">Order More</a>
    </div>
  </div>

  <?php if (isset($_GET["success"])): ?>
    <p class="success">✅ Your order has been placed!</p>
  <?php endif; ?>

  <div class="table-wrap">
    <table>
      <thead>
        <tr>
          <th>Order ID</th>
          <th>Date</th>
          <th>Total Amount</th>
          <th>Status</th>
          <th>Items</th>
        </tr>
      </thead>
      <tbody>
        <?php if ($orders->num_rows > 0): ?>
          <?php while($order = $orders->fetch_assoc()): ?>
            <?php
              $status = strtolower($order["order_status"]);
              $badgeClass = "badge-pending";
              if ($status === "delivered") $badgeClass = "badge-delivered";
              if ($status === "cancelled") $badgeClass = "badge-cancelled";

              // fetch items for this order
              $itemStmt = $conn->prepare("
                SELECT oi.quantity, oi.unit_price, p.product_name
                FROM order_items oi
                JOIN products p ON oi.product_id = p.product_id
                WHERE oi.order_id = ?
              ");
              $itemStmt->bind_param("i", $order["order_id"]);
              $itemStmt->execute();
              $items = $itemStmt->get_result();
              $itemStmt->close();
            ?>
            <tr>
              <td>#<?= $order["order_id"] ?></td>
              <td><?= htmlspecialchars($order["order_date"]) ?></td>
              <td class="price">৳<?= number_format($order["total_amount"],2) ?></td>
              <td>
                <span class="badge <?= $badgeClass ?>">
                  <?= htmlspecialchars($order["order_status"]) ?>
                </span>
              </td>
              <td>
                <details>
                  <summary>View Items (<?= $items->num_rows ?>)</summary>

                  <table class="items-table">
                    <thead>
                      <tr>
                        <th>Food</th>
                        <th>Qty</th>
                        <th>Unit Price</th>
                        <th>Subtotal</th>
                      </tr>
                    </thead>
                    <tbody>
                      <?php while($it = $items->fetch_assoc()): 
                        $sub = $it["quantity"] * $it["unit_price"];
                      ?>
                        <tr>
                          <td><?= htmlspecialchars($it["product_name"]) ?></td>
                          <td><?= (int)$it["quantity"] ?></td>
                          <td class="price">৳<?= number_format($it["unit_price"],2) ?></td>
                          <td class="price">৳<?= number_format($sub,2) ?></td>
                        </tr>
                      <?php endwhile; ?>
                    </tbody>
                  </table>
                </details>
              </td>
            </tr>
          <?php endwhile; ?>
        <?php else: ?>
          <tr>
            <td colspan="5" style="text-align:center;padding:20px;">
              You have no orders yet.
            </td>
          </tr>
        <?php endif; ?>
      </tbody>
    </table>
  </div>

</div>
</body>
</html>
