<?php
// admin/products.php
session_start();
require_once "../config/db.php";

// admin protection
if (!isset($_SESSION["user_id"]) || $_SESSION["role"] !== "admin") {
  header("Location: ../auth/login.php");
  exit;
}

// only not-deleted foods
$stmt = $conn->prepare("SELECT * FROM products WHERE deleted='0' ORDER BY product_id ASC");
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

    .btn-danger {
      background: #dc2626;
      padding: 8px 12px;
      border-radius: 8px;
      color: white;
      font-size: 14px;
      text-decoration: none;
    }
    .btn-danger:hover { opacity: .9; }

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
          <th>Category ID</th>
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
              <td><?= $row["category_id"] ?></td>
              <td><?= $row["created_at"] ?></td>
              <td>
                <a class="btn-danger"
                   href="deleteProduct.php?id=<?= $row["product_id"] ?>"
                   onclick="return confirm('Soft delete this food? It will be hidden.');">
                   Delete
                </a>
              </td>
            </tr>
          <?php endwhile; ?>
        <?php else: ?>
          <tr>
            <td colspan="7" style="text-align:center;padding:20px;">
              No active foods found.
            </td>
          </tr>
        <?php endif; ?>
      </tbody>
    </table>
  </div>

</div>

</body>
</html>
