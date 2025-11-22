<?php
session_start();
if (!isset($_SESSION["user_id"]) || $_SESSION["role"] !== "admin") {
  header("Location: ../auth/login.php");
  exit;
}
?>
<!DOCTYPE html>
<html>
<head>
  <title>Admin Dashboard</title>
  <link rel="stylesheet" href="../assets/style.css">
</head>
<body>


  <div class="card">
    <h1>Welcome Admin, <?= htmlspecialchars($_SESSION["name"]) ?></h1>
    <p>This is your dashboard.</p>

    <ul class="stack">
      <li class="card">✅ Manage Users (next step)</li>
      <li class="card">✅ Site Settings (next step)</li>
      <li class="card">✅ Reports (next step)</li>
    </ul>
  </div>
</div>
</body>
</html>
