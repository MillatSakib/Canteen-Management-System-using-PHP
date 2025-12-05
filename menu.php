<?php
session_start();
require_once "./config/db.php";

// user must be logged in
if (!isset($_SESSION["user_id"])) {
  header("Location: auth/login.php");
  exit;
}

// Fetch products from the database
$result = $conn->query("SELECT * FROM products WHERE deleted = '0' ORDER BY created_at DESC");
$products = $result->fetch_all(MYSQLI_ASSOC);
?>
<!DOCTYPE html>
<html>
<head>
  <title>Menu</title>
  <link rel="stylesheet" href="assets/style.css">
  <style>
    .menu-header {
      display: flex;
      justify-content: space-between;
      align-items: center;
      margin-bottom: 18px;
    }
    .products-grid {
      display: grid;
      grid-template-columns: repeat(auto-fill, minmax(250px, 1fr));
      gap: 20px;
    }
    .product-card {
      background: white;
      border: 1px solid #eef2f7;
      border-radius: 14px;
      padding: 16px;
      box-shadow: 0 8px 20px rgba(0,0,0,.08);
      display: flex;
      flex-direction: column;
    }
    .product-card h3 {
      margin: 0 0 8px;
      font-size: 18px;
    }
    .product-card p {
      flex-grow: 1;
      font-size: 14px;
      color: #6b7280;
      margin-bottom: 12px;
    }
    .product-card .price {
      font-weight: bold;
      font-size: 16px;
      margin-bottom: 12px;
    }
  </style>
</head>
<body>
<div class="container">
  <div class="menu-header">
    <h1>Menu</h1>
    <a href="user_home.php" class="btn">Back to Home</a>
  </div>

  <input type="text" id="search-bar" placeholder="Search for food..." style="width: 100%; padding: 12px; margin-bottom: 20px; border-radius: 8px; border: 1px solid #d0d7e2;">

  <div class="products-grid">
    <?php if (count($products) > 0): ?>
      <?php foreach ($products as $product): ?>
        <div class="product-card">
          <h3 class="product-name"><?= htmlspecialchars($product['product_name']) ?></h3>
          <p><?= htmlspecialchars($product['description']) ?></p>
          <div class="price">BDT <?= htmlspecialchars($product['price']) ?></div>
          <form action="viewCart.php" method="post">
              <input type="hidden" name="product_id" value="<?= $product['product_id'] ?>">
              <button type="submit" name="add_to_cart" class="btn">Add to Cart</button>
          </form>
        </div>
      <?php endforeach; ?>
      <p id="no-results" style="display: none;">No food items match your search.</p>
    <?php else: ?>
      <p>No menu items available at the moment.</p>
    <?php endif; ?>
  </div>
</div>

<script>
document.addEventListener('DOMContentLoaded', function () {
    const searchBar = document.getElementById('search-bar');
    const productCards = document.querySelectorAll('.product-card');
    const noResultsMessage = document.getElementById('no-results');

    searchBar.addEventListener('keyup', function () {
        const searchTerm = searchBar.value.toLowerCase();
        let visibleProducts = 0;

        productCards.forEach(function (card) {
            const productName = card.querySelector('.product-name').textContent.toLowerCase();
            if (productName.includes(searchTerm)) {
                card.style.display = 'flex';
                visibleProducts++;
            } else {
                card.style.display = 'none';
            }
        });

        if (visibleProducts === 0) {
            noResultsMessage.style.display = 'block';
        } else {
            noResultsMessage.style.display = 'none';
        }
    });
});
</script>
</body>
</html>
