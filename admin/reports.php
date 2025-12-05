<?php
// report.php
$host = "127.0.0.1";
$user = "root";       // change if needed
$pass = "";           // change if needed
$db   = "Canteen_Management_System"; // change if needed

$conn = new mysqli($host, $user, $pass, $db);
if ($conn->connect_error) {
    die("Connection failed: " . $conn->connect_error);
}

// ====== KPIs ======

// Total Revenue (from Sales)
$revenue = $conn->query("SELECT COALESCE(SUM(total_amount),0) as rev FROM sales")->fetch_assoc()['rev'];

// Total Expenses
$expenses = $conn->query("SELECT COALESCE(SUM(amount),0) as exp FROM expenses")->fetch_assoc()['exp'];

// Profit = Revenue - Expenses
$profit = $revenue - $expenses;

// Growth (last month vs this month revenue)
$growth = 0;
$currMonth = $conn->query("SELECT COALESCE(SUM(total_amount),0) as rev FROM sales WHERE MONTH(sales_date)=MONTH(CURDATE())")->fetch_assoc()['rev'];
$prevMonth = $conn->query("SELECT COALESCE(SUM(total_amount),0) as rev FROM sales WHERE MONTH(sales_date)=MONTH(CURDATE()-INTERVAL 1 MONTH)")->fetch_assoc()['rev'];
if ($prevMonth > 0) {
    $growth = (($currMonth - $prevMonth) / $prevMonth) * 100;
}

// ====== Chart Data ======

// Revenue vs Expenses by Day
$financeData = [];
$res = $conn->query("
    SELECT DATE(s.sales_date) as date, 
           COALESCE(SUM(s.total_amount),0) as revenue,
           (SELECT COALESCE(SUM(amount),0) FROM expenses e WHERE e.expense_date = DATE(s.sales_date)) as expenses
    FROM sales s
    GROUP BY DATE(s.sales_date)
    ORDER BY DATE(s.sales_date)
");
while ($row = $res->fetch_assoc()) {
    $financeData[] = $row;
}

// Sales Breakdown by Category
$salesBreakdown = [];
$salesBreakdown = [];
$res2 = $conn->query("
    SELECT c.category_name,
           COALESCE(SUM(oi.quantity * oi.unit_price), 0) AS total
    FROM categories c
    LEFT JOIN products p 
           ON p.category_id = c.category_id
    LEFT JOIN order_items oi 
           ON oi.product_id = p.product_id
    LEFT JOIN orders o 
           ON o.order_id = oi.order_id
           AND o.order_status = 'completed'
    GROUP BY c.category_id
    ORDER BY total DESC
");

if(!$res2){
    die("Sales breakdown query failed: " . $conn->error);
}

while ($row = $res2->fetch_assoc()) {
    $salesBreakdown[] = $row;
}

$conn->close();
?>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <title>Reports Dashboard</title>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
  <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
  
  <link rel="stylesheet" href="./style.css">
  <script src="./script.js"></script>
</head>
<body>
<div class="container my-4">
  <h2 class="dashboard-header">📊 Reports Dashboard</h2>
<button id="theme-switcher" class="btn-blue">Toggle Theme</button>
  <!-- KPI Cards -->
  <div class="row g-4 mb-4">
    <div class="col-md-3"><div class="card p-3 text-center"><h5>Total Revenue</h5><h2>৳<?= number_format($revenue, 2) ?></h2></div></div>
    <div class="col-md-3"><div class="card p-3 text-center"><h5>Profit</h5><h2>৳<?= number_format($profit, 2) ?></h2></div></div>
    <div class="col-md-3"><div class="card p-3 text-center"><h5>Expenses</h5><h2>৳<?= number_format($expenses, 2) ?></h2></div></div>
    <div class="col-md-3"><div class="card p-3 text-center"><h5>Growth</h5><h2><?= number_format($growth, 2) ?>%</h2></div></div>
  </div>

  <!-- Charts -->
  <div class="row g-4">
    <div class="col-md-6">
      <div class="card p-3">
        <h5>Revenue vs Expenses</h5>
        <canvas id="financeChart"></canvas>
      </div>
    </div>
    <div class="col-md-6">
      <div class="card p-3">
        <h5>Sales Breakdown</h5>
        <canvas id="salesChart"></canvas>
      </div>
    </div>
  </div>
</div>

<script>
const financeLabels = <?= json_encode(array_column($financeData, 'date')) ?>;
const revenueData = <?= json_encode(array_column($financeData, 'revenue')) ?>;
const expensesData = <?= json_encode(array_column($financeData, 'expenses')) ?>;

new Chart(document.getElementById('financeChart'), {
  type: 'line',
  data: {
    labels: financeLabels,
    datasets: [
      { label: 'Revenue', data: revenueData, borderColor: '#28a745', fill: false },
      { label: 'Expenses', data: expensesData, borderColor: '#dc3545', fill: false }
    ]
  }
});

const salesLabels = <?= json_encode(array_column($salesBreakdown, 'category_name')) ?>;
const salesData = <?= json_encode(array_column($salesBreakdown, 'total')) ?>;

new Chart(document.getElementById('salesChart'), {
  type: 'doughnut',
  data: {
    labels: salesLabels,
    datasets: [{ data: salesData, backgroundColor:['#007bff','#28a745','#ffc107','#dc3545','#6f42c1'] }]
  }
});
</script>
</body>
</html>
