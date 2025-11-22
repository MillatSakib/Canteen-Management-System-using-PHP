<?php
session_start();
require_once "../config/db.php";

$msg = "";

if ($_SERVER["REQUEST_METHOD"] === "POST") {

  $customer_name = trim($_POST["customer_name"]);
  $email        = trim($_POST["email"]);
  $phone_number = trim($_POST["phone_number"]);
  $address      = trim($_POST["address"]);
  $password     = trim($_POST["password"]);

  if (!$customer_name || !$email || !$phone_number || !$address || !$password) {
    $msg = "All fields are required.";
  } else {

    // NO hashing here
    $role = "user";

    $stmt = $conn->prepare("
      INSERT INTO customers (customer_name, email, password, role, phone_number, address)
      VALUES (?, ?, ?, ?, ?, ?)
    ");

    $stmt->bind_param(
      "ssssss",
      $customer_name,
      $email,
      $password,
      $role,
      $phone_number,
      $address
    );

    if ($stmt->execute()) {
      $msg = "Registration successful! You can login now.";
    } else {
      $msg = "Email already exists or something went wrong.";
    }

    $stmt->close();
  }
}
?>

<!DOCTYPE html>
<html>
<head>
  <title>Register</title>
  <link rel="stylesheet" href="../assets/style.css">
</head>
<body>
<div class="container">
  <div class="card">
    <h2>Create Account</h2>

    <?php if ($msg): ?>
      <p class="<?= str_contains($msg, "successful") ? "success" : "error" ?>">
        <?= htmlspecialchars($msg) ?>
      </p>
    <?php endif; ?>

    <form method="POST">
      <label>Full Name</label>
      <input type="text" name="customer_name" required>

      <label>Email</label>
      <input type="email" name="email" required>

      <label>Phone Number</label>
      <input type="text" name="phone_number" required>

      <label>Address</label>
      <input type="text" name="address" required>

      <label>Password</label>
      <input type="password" name="password" required>

      <button type="submit">Register</button>
    </form>

    <p style="margin-top:12px;">
      Already have an account? <a href="login.php">Login</a>
    </p>
  </div>
</div>
</body>
</html>
