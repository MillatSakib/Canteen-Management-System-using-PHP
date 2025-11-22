<?php
// feedback.php
session_start();
require_once "../config/db.php";

// Fetch feedback + customer names
$stmt = $conn->prepare("
  SELECT 
    f.feedback_id,
    f.rating,
    f.comment,
    f.feedback_date,
    c.customer_name
  FROM feedback f
  JOIN customers c ON f.customer_id = c.customer_id
  ORDER BY f.feedback_date DESC
");
$stmt->execute();
$result = $stmt->get_result();
?>
<!DOCTYPE html>
<html>
<head>
  <title>Customer Feedback</title>
  <link rel="stylesheet" href="assets/style.css">

  <style>
    .feedback-grid {
      display: grid;
      grid-template-columns: repeat(auto-fit, minmax(260px, 1fr));
      gap: 16px;
      margin-top: 16px;
    }

    .feedback-card {
      background: white;
      border-radius: 14px;
      padding: 16px;
      box-shadow: 0 6px 16px rgba(0,0,0,.08);
      border: 1px solid #eef2f7;
      transition: transform .12s ease, box-shadow .2s ease;
    }

    .feedback-card:hover {
      transform: translateY(-2px);
      box-shadow: 0 10px 22px rgba(0,0,0,.12);
    }

    .feedback-head {
      display: flex;
      justify-content: space-between;
      align-items: center;
      margin-bottom: 8px;
    }

    .user-name {
      font-weight: 700;
      font-size: 16px;
      color: #111827;
    }

    .rating {
      background: #2563eb;
      color: white;
      font-weight: 700;
      padding: 4px 10px;
      border-radius: 999px;
      font-size: 13px;
    }

    .comment {
      color: #374151;
      font-size: 15px;
      line-height: 1.5;
      margin: 8px 0 12px;
    }

    .date {
      font-size: 12px;
      color: #6b7280;
    }

    .page-title {
      display:flex;
      justify-content:space-between;
      align-items:center;
      gap:12px;
      flex-wrap:wrap;
    }
    .home-btn{
  display: inline-flex;
  align-items: center;
  gap: 10px;

  padding: 12px 18px;
  border-radius: 999px;

  background: linear-gradient(135deg, #1d4ed8, #3b82f6);
  color: #fff;
  font-weight: 700;
  font-size: 15px;
  letter-spacing: .2px;
  text-decoration: none;

  box-shadow: 0 8px 20px rgba(37, 99, 235, .35);
  border: 1px solid rgba(255,255,255,.25);

  transition: transform .12s ease, box-shadow .2s ease, filter .2s ease;
}

.home-btn__icon{
  font-size: 18px;
  line-height: 1;
  filter: drop-shadow(0 2px 4px rgba(0,0,0,.25));
}

.home-btn:hover{
  transform: translateY(-2px);
  box-shadow: 0 12px 28px rgba(37, 99, 235, .5);
  filter: saturate(1.1);
}

.home-btn:active{
  transform: translateY(1px) scale(.98);
  box-shadow: 0 6px 14px rgba(37, 99, 235, .35);
}

.home-btn:focus-visible{
  outline: none;
  box-shadow:
    0 0 0 4px rgba(59, 130, 246, .35),
    0 10px 24px rgba(37, 99, 235, .45);
}

  </style>
</head>
<body>

<div class="container">
  <div class="page-title">
    <h2>⭐ Customer Feedback</h2>
    <a href="../index.php" class="home-btn">
  <span class="home-btn__icon">🏠</span>
  <span class="home-btn__text">Home</span>
</a>

  </div>

  <div class="feedback-grid">
    <?php if ($result->num_rows > 0): ?>
      <?php while($row = $result->fetch_assoc()): ?>
        <div class="feedback-card">
          <div class="feedback-head">
            <div class="user-name">
              <?= htmlspecialchars($row["customer_name"]) ?>
            </div>
            <div class="rating">
              <?= (int)$row["rating"] ?>/5
            </div>
          </div>

          <div class="comment">
            “<?= htmlspecialchars($row["comment"]) ?>”
          </div>

          <div class="date">
            <?= htmlspecialchars($row["feedback_date"]) ?>
          </div>
        </div>
      <?php endwhile; ?>
    <?php else: ?>
      <p>No feedback found.</p>
    <?php endif; ?>
  </div>
</div>

</body>
</html>
