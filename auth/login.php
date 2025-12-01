<?php
session_start();

$error = "";

if ($_SERVER["REQUEST_METHOD"] === "POST") {
  $email    = trim($_POST["email"]);
  $password = trim($_POST["password"]);

  $stmt = $conn->prepare("
    SELECT customer_id, customer_name, password, role
    FROM customers
    WHERE email = ?
  ");
  $stmt->bind_param("s", $email);
  $stmt->execute();
  $result = $stmt->get_result();

  if ($result->num_rows === 1) {
    $user = $result->fetch_assoc();

    // NO password_verify, direct match
    if ($password === $user["password"]) {
      $_SESSION["user_id"] = $user["customer_id"];
      $_SESSION["name"]    = $user["customer_name"];
      $_SESSION["role"]    = $user["role"];

      if ($user["role"] === "admin") {
        header("Location: ../admin/dashboard.php");
      } else {
        header("Location: ../user_home.php");
      }
      exit;
    }
  }

  $error = "Invalid email or password.";
  $stmt->close();
}
?>

<!DOCTYPE html>
<html>
<head>
  <title>Login</title>
  <link rel="stylesheet" href="../assets/style.css">
</head>
<body>
<div class="container">
  <div class="card">
    <h2>Login</h2>

    <?php if ($error): ?>
      <p class="error"><?= htmlspecialchars($error) ?></p>
    <?php endif; ?>

    <form method="POST">
      <label>Email</label>
      <input type="email" name="email" required>

      <label>Password</label>
      <input type="password" name="password" required>

      <button type="submit">Login</button>
    </form>

    <p style="margin-top:12px;">
      New here? <a href="register.php">Register</a>
    </p>
  </div>
</div>
</body>
</html>
