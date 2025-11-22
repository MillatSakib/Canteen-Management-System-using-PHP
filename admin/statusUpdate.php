<?php
session_start();
require_once "../config/db.php";

// admin protection
if (!isset($_SESSION["user_id"]) || $_SESSION["role"] !== "admin") {
  header("Location: ../auth/login.php");
  exit;
}

// fetch all active orders + customer name
$stmt = $conn->prepare("
  SELECT 
    o.order_id,
    o.order_date,
    o.total_amount,
    o.order_status,
    o.customer_id,
    c.customer_name
  FROM orders o
  JOIN customers c ON o.customer_id = c.customer_id
  WHERE o.status = 'active'
  ORDER BY o.order_id DESC
");
$stmt->execute();
$orders = $stmt->get_result();
$stmt->close();
?>
<!DOCTYPE html>
<html>
<head>
  <title>Admin Order Status Update</title>
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
      min-width:1000px;
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
    .badge-rejected{ background:#dc2626; color:white; }

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

    select{
      padding:8px 10px;
      border-radius:8px;
      border:1px solid #d1d5db;
    }
    .btn-sm{
      padding:8px 12px;
      border-radius:8px;
      font-size:14px;
      background:#111827;
      color:white;
      border:none;
      cursor:pointer;
      font-weight:700;
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
    <h2>🛠️ Update Order Status</h2>
    <div class="nav">
      <a class="btn" href="dashboard.php">Dashboard</a>
      <a class="btn" href="../auth/logout.php">Logout</a>
    </div>
  </div>

  <?php if (isset($_GET["updated"])): ?>
    <p class="success">✅ Order status updated!</p>
  <?php endif; ?>

  <div class="table-wrap">
    <table>
      <thead>
        <tr>
          <th>Order ID</th>
          <th>Customer</th>
          <th>Date</th>
          <th>Total</th>
          <th>Current Status</th>
          <th>Update Status</th>
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
              if ($status === "rejected") $badgeClass = "badge-rejected";

              // fetch items for order
              $itemStmt = $conn->prepare("
                SELECT oi.quantity, oi.unit_price, p.product_name
                FROM order_items oi
                JOIN products p ON oi.product_id = p.product_id
                WHERE oi.order_id = ?
              ");
              $itemStmt->bind_param("i", $order["order_id"]);
              $itemStmt->execute();
              $items = $itemStmt->get_result();
              $itemCount = $items->num_rows;
              $itemStmt->close();
            ?>
            <tr>
              <td>#<?= $order["order_id"] ?></td>
              <td><?= htmlspecialchars($order["customer_name"]) ?></td>
              <td><?= htmlspecialchars($order["order_date"]) ?></td>
              <td class="price">৳<?= number_format($order["total_amount"],2) ?></td>

              <td>
                <span class="badge <?= $badgeClass ?>">
                  <?= htmlspecialchars($order["order_status"]) ?>
                </span>
              </td>

              <td>
                <form method="POST" action="update_order_status.php" style="display:flex;gap:8px;align-items:center;">
                  <input type="hidden" name="order_id" value="<?= $order["order_id"] ?>">
                  <select name="order_status" required>
                    <option value="Pending"   <?= $status==="pending"?"selected":"" ?>>Pending</option>
                    <option value="Delivered" <?= $status==="delivered"?"selected":"" ?>>Delivered</option>
                    <option value="Rejected"  <?= $status==="rejected"?"selected":"" ?>>Rejected</option>
                  </select>
                  <button class="btn-sm" type="submit">Update</button>
                </form>
              </td>

              <td>
                <details>
                  <summary>View Items (<?= $itemCount ?>)</summary>

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
            <td colspan="7" style="text-align:center;padding:20px;">
              No orders found.
            </td>
          </tr>
        <?php endif; ?>
      </tbody>
    </table>
  </div>

</div>
</body>
</html>
