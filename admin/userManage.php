<?php
session_start();
require_once "../config/db.php";

// admin protection
if (!isset($_SESSION["user_id"]) || $_SESSION["role"] !== "admin") {
  header("Location: ../auth/login.php");
  exit;
}

// only active users (not soft-deleted)
$stmt = $conn->prepare("SELECT * FROM customers WHERE deleted='0' ORDER BY customer_id ASC");
$stmt->execute();
$result = $stmt->get_result();
?>
<!DOCTYPE html>
<html>
<head>
  <title>Modify Users</title>
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
      min-width: 900px;
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
      vertical-align: middle;
    }
    tr:hover td { background:#f8fafc; }

    .badge {
      padding: 4px 10px;
      border-radius: 999px;
      font-size: 12px;
      font-weight: 700;
      display: inline-block;
    }
    .badge-admin { background:#16a34a; color:white; }
    .badge-user  { background:#f59e0b; color:white; }

    .btn-danger {
      background: #dc2626;
      color:white;
      padding: 8px 12px;
      border-radius: 8px;
      font-size: 14px;
      text-decoration:none;
      display:inline-block;
    }
    .btn-danger:hover { opacity:.9; }

    .btn-admin {
      background:#111827;
      color:white;
      padding: 8px 12px;
      border-radius: 8px;
      font-size: 14px;
      text-decoration:none;
      display:inline-block;
    }
    .btn-admin:hover { opacity:.9; }

    .btn-disabled {
      opacity: .5;
      pointer-events: none;
      cursor: not-allowed;
    }

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
    <h2>👥 Modify Users</h2>
    <div class="nav">
      <a class="btn" href="dashboard.php">Dashboard</a>
      <a class="btn" href="../auth/logout.php">Logout</a>
    </div>
  </div>

  <?php if (isset($_GET["deleted"])): ?>
    <p class="success">🗑️ User deleted (soft delete) successfully!</p>
  <?php endif; ?>

  <?php if (isset($_GET["promoted"])): ?>
    <p class="success">⭐ User promoted to admin successfully!</p>
  <?php endif; ?>

  <div class="table-wrap">
    <table>
      <thead>
        <tr>
          <th>ID</th>
          <th>Name</th>
          <th>Email</th>
          <th>Role</th>
          <th>Phone</th>
          <th>Address</th>
          <th>Created</th>
          <th>Delete</th>
          <th>Make Admin</th>
        </tr>
      </thead>
      <tbody>
        <?php if ($result->num_rows > 0): ?>
          <?php while($row = $result->fetch_assoc()): ?>
            <?php $isAdmin = ($row["role"] === "admin"); ?>
            <tr>
              <td><?= $row["customer_id"] ?></td>
              <td><?= htmlspecialchars($row["customer_name"]) ?></td>
              <td><?= htmlspecialchars($row["email"]) ?></td>
              <td>
                <?php if ($isAdmin): ?>
                  <span class="badge badge-admin">ADMIN</span>
                <?php else: ?>
                  <span class="badge badge-user">USER</span>
                <?php endif; ?>
              </td>
              <td><?= htmlspecialchars($row["phone_number"]) ?></td>
              <td><?= htmlspecialchars($row["address"]) ?></td>
              <td><?= htmlspecialchars($row["created_at"]) ?></td>

              <!-- DELETE BUTTON -->
              <td>
                <?php if ($isAdmin): ?>
                  <span class="btn-danger btn-disabled">Delete Disabled</span>
                <?php else: ?>
                  <a class="btn-danger"
                     href="deleteUser.php?id=<?= $row["customer_id"] ?>"
                     onclick="return confirm('Soft delete this user?');">
                     Delete
                  </a>
                <?php endif; ?>
              </td>

              <!-- MAKE ADMIN BUTTON -->
              <td>
                <?php if ($isAdmin): ?>
                  <span class="btn-admin btn-disabled">Already Admin</span>
                <?php else: ?>
                  <a class="btn-admin"
                     href="makeAdmin.php?id=<?= $row["customer_id"] ?>"
                     onclick="return confirm('Make this user admin?');">
                     Make Admin
                  </a>
                <?php endif; ?>
              </td>
            </tr>
          <?php endwhile; ?>
        <?php else: ?>
          <tr>
            <td colspan="9" style="text-align:center;padding:20px;">
              No active users found.
            </td>
          </tr>
        <?php endif; ?>
      </tbody>
    </table>
  </div>

</div>
</body>
</html>
