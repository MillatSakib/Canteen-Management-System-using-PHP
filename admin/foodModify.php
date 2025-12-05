<?php
// admin/products.php
session_start();
require_once "../config/db.php";

// admin protection
if (!isset($_SESSION["user_id"]) || $_SESSION["role"] !== "admin") {
  header("Location: ../auth/login.php");
  exit;
}

// fetch all active products + stock from inventory
$stmt = $conn->prepare("
    SELECT p.*, i.stock_quantity 
    FROM products p
    LEFT JOIN inventory i ON p.product_id = i.product_id
    WHERE p.deleted = '0'
    ORDER BY p.product_id ASC
");
$stmt->execute();
$result = $stmt->get_result();
?>
<!DOCTYPE html>
<html>
<head>
  <title>Manage Foods</title>
  <link rel="stylesheet" href="../assets/style.css">
  <style>
    .table-wrap {
      overflow-x: auto;
      border-radius: 14px;
      box-shadow: 0 8px 20px rgba(0,0,0,.08);
      background: white;
    }
    table {
      width: 100%;
      border-collapse: collapse;
      min-width: 700px;
    }
    thead {
      background: linear-gradient(135deg, #1d4ed8, #3b82f6);
      color: white;
    }
    th, td {
      padding: 14px 16px;
      text-align: left;
      border-bottom: 1px solid #e5e7eb;
      font-size: 15px;
    }
    tr:hover td { background: #f8fafc; }

    .price { font-weight: 700; color: #16a34a; }

    /* NEW CONSISTENT BUTTON STYLES */
    .action-buttons {
      display: flex;
      gap: 8px;
    }

    .btn-update,
    .btn-danger {
      display: inline-flex;
      align-items: center;
      justify-content: center;
      min-width: 80px;
      padding: 0px 0;
      height: 36px;
      border-radius: 8px;
      color: #fff;
      font-size: 14px;
      font-weight: 600;
      text-decoration: none;
      transition: 0.2s ease-in-out;
    }

    .btn-update {
      background: #2563eb;
    }
    .btn-update:hover {
      background: #1e40af;
    }

    .btn-danger {
      background: #dc2626;
    }
    .btn-danger:hover {
      background: #b91c1c;
    }

    .header-row {
      display: flex;
      justify-content: space-between;
      align-items: center;
      margin-bottom: 16px;
      gap: 12px;
      flex-wrap: wrap;
    }
  </style>
</head>
<body>

<div class="container">

  <div class="header-row">
    <h2>🍔 Manage Foods</h2>
    <div class="nav">
      <a class="btn" href="addProduct.php">+ Add Food</a>
      <a class="btn" href="../auth/logout.php">Logout</a>
    </div>
  </div>

  <div class="table-wrap">
    <table>
      <thead>
        <tr>
          <th>ID</th>
          <th>Food Name</th>
          <th>Description</th>
          <th>Price</th>
          <th>Stock</th>
          <th>Created</th>
          <th>Action</th>
        </tr>
      </thead>
      <tbody>

        <?php if ($result->num_rows > 0): ?>
          <?php while($row = $result->fetch_assoc()): ?>
            <tr>
              <td><?= $row["product_id"] ?></td>
              <td><?= htmlspecialchars($row["product_name"]) ?></td>
              <td><?= htmlspecialchars($row["description"]) ?></td>
              <td class="price">৳<?= number_format($row["price"], 2) ?></td>
              
              <td style="font-weight:700;"><?= $row["stock_quantity"] ?? 0 ?></td>

              <td><?= $row["created_at"] ?></td>

              <td>
                <div class="action-buttons">
                  
                  <!-- UPDATE BUTTON -->
                  <a class="btn-update"
                     href="update_product.php?id=<?= $row["product_id"] ?>">
                     Update
                  </a>

                  <!-- DELETE BUTTON -->
                  <a class="btn-danger"
                     href="deleteProduct.php?id=<?= $row["product_id"] ?>"
                     onclick="return confirm('Soft delete this food? It will be hidden.');">
                     Delete
                  </a>

                </div>
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
