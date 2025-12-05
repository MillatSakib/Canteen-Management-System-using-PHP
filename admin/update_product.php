<?php
// admin/update_product.php
session_start();
require_once "../config/db.php";

// Admin protection
if (!isset($_SESSION["user_id"]) || $_SESSION["role"] !== "admin") {
  header("Location: ../auth/login.php");
  exit;
}

// Validate product ID
if (!isset($_GET["id"])) {
  header("Location: foodModify.php");
  exit;
}

$product_id = intval($_GET["id"]);

// Fetch product info
$stmt = $conn->prepare("
  SELECT p.product_name, p.description, p.price, p.category_id,
         i.stock_quantity
  FROM products p
  LEFT JOIN inventory i ON p.product_id = i.product_id
  WHERE p.product_id = ?
");
$stmt->bind_param("i", $product_id);
$stmt->execute();
$result = $stmt->get_result();
$product = $result->fetch_assoc();

if (!$product) {
  die("Product not found!");
}

// Fetch categories
$catResult = $conn->query("SELECT category_id, category_name FROM categories ORDER BY category_name ASC");

$msg = "";

// Handle form submission
if ($_SERVER["REQUEST_METHOD"] === "POST") {

  $product_name   = trim($_POST["product_name"]);
  $description    = trim($_POST["description"]);
  $price          = trim($_POST["price"]);
  $category_id    = trim($_POST["category_id"]);
  $stock_quantity = trim($_POST["stock_quantity"]);

  if (!$product_name || !$description || !$price || !$category_id || $stock_quantity === "") {
    $msg = "All fields are required.";
  } else {

    // Update products table
    $updateStmt = $conn->prepare("
      UPDATE products
      SET product_name = ?, description = ?, price = ?, category_id = ?
      WHERE product_id = ?
    ");
    $updateStmt->bind_param("ssdii", $product_name, $description, $price, $category_id, $product_id);

    if ($updateStmt->execute()) {

      // Update inventory
      $invStmt = $conn->prepare("
        UPDATE inventory
        SET stock_quantity = ?
        WHERE product_id = ?
      ");
      $invStmt->bind_param("ii", $stock_quantity, $product_id);

      if ($invStmt->execute()) {
        echo "<script>
                alert('Product updated successfully!');
                window.location.href = 'foodModify.php';
              </script>";
        exit;
      } else {
        $msg = "Product updated but stock update failed!";
      }

      $invStmt->close();
    } else {
      $msg = "Something went wrong!";
    }

    $updateStmt->close();
  }
}

?>
<!DOCTYPE html>
<html>
<head>
  <title>Edit Food</title>
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
      <a class="btn" href="foodModify.php">← Back</a>
    </div>

    <h2>✏️ Edit Food Item</h2>

    <?php if ($msg): ?>
      <p class="error"><?= htmlspecialchars($msg) ?></p>
    <?php endif; ?>

    <form method="POST" class="form-grid">

      <label>Food Name</label>
      <input type="text" name="product_name"
             value="<?= htmlspecialchars($product['product_name']) ?>" required>

      <label>Description</label>
      <textarea name="description" required><?= htmlspecialchars($product["description"]) ?></textarea>

      <label>Price (৳)</label>
      <input type="number" step="0.01" name="price"
             value="<?= htmlspecialchars($product['price']) ?>" required>

      <label>Category</label>
      <select name="category_id" required>
        <option value="">-- Select Category --</option>
        <?php while($cat = $catResult->fetch_assoc()): ?>
          <option value="<?= $cat['category_id'] ?>"
            <?= ($cat['category_id'] == $product['category_id']) ? 'selected' : '' ?>>
            <?= htmlspecialchars($cat['category_name']) ?>
          </option>
        <?php endwhile; ?>
      </select>

      <label>Stock Quantity</label>
      <input type="number" name="stock_quantity"
             value="<?= htmlspecialchars($product['stock_quantity']) ?>" required>

      <button type="submit">Update Food</button>
    </form>

  </div>
</div>

</body>
</html>
