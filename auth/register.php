<?php
session_start();
require_once "../config/db.php";

$msg = "";
$isSuccess = false;

if ($_SERVER["REQUEST_METHOD"] === "POST") {

  $customer_name = trim($_POST["customer_name"]);
  $email        = trim($_POST["email"]);
  $phone_number = trim($_POST["phone_number"]);
  $address      = trim($_POST["address"]);
  $password     = trim($_POST["password"]);

  if (!$customer_name || !$email || !$phone_number || !$address || !$password) {
    $msg = "All fields are required.";
  } else {

    $role = "user";

    try {
        $stmt = $conn->prepare("
          INSERT INTO customers (customer_name, email, password, role, phone_number, address)
          VALUES (?, ?, ?, ?, ?, ?)
        ");

        $stmt->bind_param("ssssss",
          $customer_name,
          $email,
          $password,
          $role,
          $phone_number,
          $address
        );

        $stmt->execute();
        $stmt->close();

        $msg = "Registration successful! You can login now.";
        $isSuccess = true;

    } catch (mysqli_sql_exception $e) {

        if ($e->getCode() == 1062) {
            // Duplicate email or phone number
            if (strpos($e->getMessage(), "email") !== false)
                $msg = "Email already exists.";
            else if (strpos($e->getMessage(), "phone_number") !== false)
                $msg = "Phone number already exists.";
            else
                $msg = "Duplicate entry found.";
        } else {
            // Other SQL errors
            $msg = "Something went wrong: " . $e->getMessage();
        }
    }
  }
}
?>
<!DOCTYPE html>
<html>
<head>
  <title>Register</title>
  <link rel="stylesheet" href="../assets/style.css">

  <style>
    .success {
      background: #d1fae5;
      color: #065f46;
      padding: 10px;
      border-radius: 6px;
      border: 1px solid #6ee7b7;
      margin-bottom: 10px;
    }
    .error {
      background: #fee2e2;
      color: #b91c1c;
      padding: 10px;
      border-radius: 6px;
      border: 1px solid #fca5a5;
      margin-bottom: 10px;
    }
  </style>

</head>
<body>
<div class="container">
  <div class="card">
    <h2>Create Account</h2>

    <?php if ($msg): ?>
      <p class="<?= $isSuccess ? 'success' : 'error' ?>">
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
