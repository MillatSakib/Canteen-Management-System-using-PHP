<?php
session_start();
if (!isset($_SESSION["user_id"])) {
  header("Location: auth/login.php");
  exit;
}
?>
<!DOCTYPE html>
<html>
<head>
  <title>User Home</title>
  <link rel="stylesheet" href="assets/style.css">
</head>
<body>
<div class="container">
  <div class="nav">
    <?php if ($_SESSION["role"] === "admin"): ?>
      <a class="btn" href="admin/dashboard.php">Dashboard</a>
    <?php endif; ?>
    <a class="btn" href="auth/logout.php">Logout</a>
  </div>

  <div class="card">
    <h1>Hello, <?= htmlspecialchars($_SESSION["name"]) ?></h1>
    <p>This is the normal website for users.</p>
  </div>
</div>
</body>
</html>
