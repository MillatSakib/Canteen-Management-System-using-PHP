<?php
// products.php

// ===== KPI Cards =====
$totalProductsQ = $conn->query("SELECT COUNT(*) as total FROM products");
if(!$totalProductsQ) die("KPI totalProducts failed: " . $conn->error);
$totalProducts = $totalProductsQ->fetch_assoc()['total'];

$inStockQ = $conn->query("SELECT COUNT(*) as instock FROM inventory WHERE stock_quantity > 0");
if(!$inStockQ) die("KPI inStock failed: " . $conn->error);
$inStock = $inStockQ->fetch_assoc()['instock'];

$outStockQ = $conn->query("SELECT COUNT(*) as outstock FROM inventory WHERE stock_quantity = 0");
if(!$outStockQ) die("KPI outStock failed: " . $conn->error);
$outStock = $outStockQ->fetch_assoc()['outstock'];

$totalCategoriesQ = $conn->query("SELECT COUNT(*) as total FROM categories");
if(!$totalCategoriesQ) die("KPI categories failed: " . $conn->error);
$totalCategories = $totalCategoriesQ->fetch_assoc()['total'];


// ===== Stock Distribution (Query for Chart) =====
$stockLabels = [];
$stockValues = [];

$res = $conn->query("
    SELECT c.category_name, COALESCE(SUM(i.stock_quantity),0) as stock
    FROM categories c
    LEFT JOIN products p ON c.category_id = p.category_id
    LEFT JOIN inventory i ON p.product_id = i.product_id
    GROUP BY c.category_id
");
if(!$res) die("Stock distribution query failed: " . $conn->error);

while ($row = $res->fetch_assoc()) {
    $stockLabels[] = $row['category_name'];
    $stockValues[] = (int)$row['stock'];
}


// ===== Top Products (Query for Table) =====
// Safer version: shows products even if no completed orders yet
$topProducts = [];
$res2 = $conn->query("
    SELECT p.product_name, COALESCE(SUM(oi.quantity),0) AS sales
    FROM products p
    LEFT JOIN order_items oi ON oi.product_id = p.product_id
    LEFT JOIN orders o ON oi.order_id = o.order_id 
        AND o.order_status = 'completed'
    GROUP BY p.product_id
    ORDER BY sales DESC
    LIMIT 5
");
if(!$res2) die("Top products query failed: " . $conn->error);

while ($row = $res2->fetch_assoc()) {
    $topProducts[] = $row;
}

?>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <title>Products Dashboard</title>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
  <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>

  <link rel="stylesheet" href="style.css">
  <script src="script.js"></script>
</head>
<body>
<div class="container my-4">
  <h2 class="dashboard-header">📦 Products Dashboard</h2>
  <button id="theme-switcher" class="btn-blue">Toggle Theme</button>

  <!-- KPI Cards -->
  <div class="row g-4 mb-4">
    <div class="col-md-3">
      <div class="card p-3 text-center">
        <h5>Total Products</h5>
        <h2><?= $totalProducts ?></h2>
      </div>
    </div>

    <div class="col-md-3">
      <div class="card p-3 text-center">
        <h5>In Stock</h5>
        <h2><?= $inStock ?></h2>
      </div>
    </div>

    <div class="col-md-3">
      <div class="card p-3 text-center">
        <h5>Out of Stock</h5>
        <h2><?= $outStock ?></h2>
      </div>
    </div>

    <div class="col-md-3">
      <div class="card p-3 text-center">
        <h5>Categories</h5>
        <h2><?= $totalCategories ?></h2>
      </div>
    </div>
  </div>

  <!-- Charts + Table -->
  <div class="row g-4">
    <div class="col-md-6">
      <div class="card p-3">
        <h5>Stock Distribution</h5>
        <canvas id="stockChart"></canvas>
      </div>
    </div>

    <div class="col-md-6">
      <div class="card p-3">
        <h5>Top Products (Completed Orders)</h5>
        <table class="table table-striped">
          <thead>
            <tr><th>Product</th><th>Sales</th></tr>
          </thead>
          <tbody>
            <?php if(count($topProducts) === 0): ?>
              <tr><td colspan="2" class="text-center text-muted">No sales yet</td></tr>
            <?php else: ?>
              <?php foreach ($topProducts as $tp): ?>
                <tr>
                  <td><?= htmlspecialchars($tp['product_name']) ?></td>
                  <td><?= (int)$tp['sales'] ?></td>
                </tr>
              <?php endforeach; ?>
            <?php endif; ?>
          </tbody>
        </table>
      </div>
    </div>
  </div>
</div>

<script>
new Chart(document.getElementById('stockChart'), {
  type:'pie',
  data:{
    labels: <?= json_encode($stockLabels) ?>,
    datasets:[{
      data: <?= json_encode($stockValues) ?>,
      backgroundColor:['#007bff','#28a745','#ffc107','#dc3545','#6f42c1','#20c997','#fd7e14']
    }]
  }
});
</script>
</body>
</html>
