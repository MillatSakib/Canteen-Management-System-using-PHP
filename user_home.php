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
  <style>
    .home-header {
      display: flex;
      justify-content: space-between;
      align-items: center;
      gap: 12px;
      flex-wrap: wrap;
      margin-bottom: 18px;
    }

    .actions-grid{
      display: grid;
      grid-template-columns: repeat(auto-fit, minmax(240px, 1fr));
      gap: 16px;
      margin-top: 14px;
    }

    .action-card{
      background: white;
      padding: 18px;
      border-radius: 14px;
      box-shadow: 0 8px 20px rgba(0,0,0,.08);
      border: 1px solid #eef2f7;
      transition: transform .12s ease, box-shadow .2s ease;
    }

    .action-card:hover{
      transform: translateY(-2px);
      box-shadow: 0 12px 26px rgba(0,0,0,.12);
    }

    .action-title{
      font-size: 18px;
      font-weight: 700;
      margin: 0 0 6px;
      color: #111827;
    }

    .action-desc{
      font-size: 14px;
      color: #6b7280;
      margin-bottom: 12px;
      line-height: 1.5;
    }

    .action-icon{
      font-size: 28px;
      margin-bottom: 8px;
      display: inline-block;
    }
  </style>
</head>
<body>
<div class="container">

  <!-- Top nav / greeting -->
  <div class="home-header">
    <div>
      <h1 style="margin:0;">Hello, <?= htmlspecialchars($_SESSION["name"]) ?> 👋</h1>
      <p class="muted" style="margin:4px 0 0;">Welcome to your canteen portal.</p>
    </div>

    <div class="nav">
      <?php if ($_SESSION["role"] === "admin"): ?>
        <a class="btn" href="admin/dashboard.php">Dashboard</a>
      <?php endif; ?>
      <a class="btn" href="auth/logout.php">Logout</a>
    </div>
  </div>

  <!-- 3 Sections -->
  <div class="actions-grid">

    <!-- Submit Feedback -->
    <div class="action-card">
      <div class="action-icon">⭐</div>
      <h2 class="action-title">Submit Feedback</h2>
      <p class="action-desc">
        Share your experience about food quality, service, or anything you want us to improve.
      </p>
      <a class="btn" href="feedback.php">Give Feedback</a>
    </div>

    <!-- Make Food Order -->
    <div class="action-card">
      <div class="action-icon">🍔</div>
      <h2 class="action-title">Make Food Order</h2>
      <p class="action-desc">
        Browse today’s menu and place your order easily from here.
      </p>
      <a class="btn" href="./orderFood.php">Order Food</a>
    </div>

    <!-- Check Order Status -->
    <div class="action-card">
      <div class="action-icon">🧾</div>
      <h2 class="action-title">Check Order Status</h2>
      <p class="action-desc">
        Track your ordered foods and see if they are pending, preparing, or ready.
      </p>
      <a class="btn" href="./status.php">View Status</a>
    </div>

  </div>

</div>
</body>
</html>
