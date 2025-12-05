<?php
// admin/add_product.php
session_start();
require_once "../config/db.php";

// admin protection
if (!isset($_SESSION["user_id"]) || $_SESSION["role"] !== "admin") {
  header("Location: ../auth/login.php");
  exit;
}

// fetch categories
$catResult = $conn->query("SELECT category_id, category_name FROM categories ORDER BY category_name ASC");

$msg = "";

if ($_SERVER["REQUEST_METHOD"] === "POST") {
  $product_name   = trim($_POST["product_name"]);
  $description    = trim($_POST["description"]);
  $price          = trim($_POST["price"]);
  $category_id    = trim($_POST["category_id"]);
  $stock_quantity = trim($_POST["stock_quantity"]); // NEW STOCK INPUT

  if (!$product_name || !$description || !$price || !$category_id || !$stock_quantity) {
    $msg = "All fields are required.";
  } else {

    // Insert into products table
    $stmt = $conn->prepare("
      INSERT INTO products (product_name, description, price, category_id, deleted)
      VALUES (?, ?, ?, ?, '0')
    ");
    $stmt->bind_param("ssdi", $product_name, $description, $price, $category_id);

    if ($stmt->execute()) {

      // Get the newly inserted product ID
      $new_product_id = $conn->insert_id;

      // Insert initial stock into inventory table
      $stockStmt = $conn->prepare("
          INSERT INTO inventory (product_id, stock_quantity)
          VALUES (?, ?)
      ");
      $stockStmt->bind_param("ii", $new_product_id, $stock_quantity);

      if ($stockStmt->execute()) {
        echo "<script>
                alert('Food added successfully with stock!');
                window.location.href = 'addProduct.php';
              </script>";
        exit;
      } else {
        $msg = "Product added but stock insert failed!";
      }

      $stockStmt->close();

    } else {
      $msg = "Something went wrong!";
    }

    $stmt->close();
  }
}
?>
<!DOCTYPE html>
<html>
<head>
  <title>Add Food</title>
  <link rel="stylesheet" href="../assets/style.css">
  <style>
    .form-grid { display: grid; gap: 12px; }
    textarea, input, select {
      width: 100%;
      padding: 12px;
      border: 1px solid #d0d7e2;
      border-radius: 10px;
      font-size: 15px;
    }
    textarea { min-height: 90px; }
  </style>
</head>
<body>

<div class="container">
  <div class="card">

    <div class="nav" style="margin-bottom:14px;">
      <a class="btn" href="products.php">← Back</a>
    </div>

    <h2>➕ Add New Food</h2>

    <?php if ($msg): ?>
      <p class="error"><?= htmlspecialchars($msg) ?></p>
    <?php endif; ?>

    <form method="POST" class="form-grid">

      <label>Food Name</label>
      <input type="text" name="product_name" required>

      <label>Description</label>
      <textarea name="description" required></textarea>

      <label>Price (৳)</label>
      <input type="number" step="0.01" name="price" required>

      <label>Category</label>
      <select name="category_id" required>
        <option value="">-- Select Category --</option>
        <?php while($cat = $catResult->fetch_assoc()): ?>
          <option value="<?= $cat['category_id'] ?>">
            <?= htmlspecialchars($cat['category_name']) ?>
          </option>
        <?php endwhile; ?>
      </select>

      <!-- NEW STOCK FIELD -->
      <label>Initial Stock Quantity</label>
      <input type="number" name="stock_quantity" required>

      <button type="submit">Add Food</button>
    </form>

  </div>
</div>

</body>
</html>
