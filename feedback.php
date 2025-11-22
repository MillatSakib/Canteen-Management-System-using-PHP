<?php
session_start();
require_once "./config/db.php";

// user must be logged in
if (!isset($_SESSION["user_id"])) {
  header("Location: ../auth/login.php");
  exit;
}

$msg = "";
$success = "";

// when form submitted
if ($_SERVER["REQUEST_METHOD"] === "POST") {

  $customer_id = $_SESSION["user_id"];
  $rating      = (int)$_POST["rating"];
  $comment     = trim($_POST["comment"]);

  if ($rating < 1 || $rating > 5 || !$comment) {
    $msg = "Please give rating (1-5) and write a comment.";
  } else {
    $stmt = $conn->prepare("
      INSERT INTO feedback (customer_id, rating, comment)
      VALUES (?, ?, ?)
    ");
    $stmt->bind_param("iis", $customer_id, $rating, $comment);

    if ($stmt->execute()) {
      $success = "✅ Thank you! Your feedback has been submitted.";
      echo "<script>
              alert('Thank you! Your feedback has been submitted.');
            </script>";
    } else {
      $msg = "Something went wrong. Try again!";
    }

    $stmt->close();
  }
}
?>
<!DOCTYPE html>
<html>
<head>
  <title>Submit Feedback</title>
  <link rel="stylesheet" href="../assets/style.css">
  <style>
    .feedback-card {
      max-width: 520px;
      margin: 30px auto;
      background: white;
      padding: 22px;
      border-radius: 14px;
      box-shadow: 0 8px 20px rgba(0,0,0,.08);
      border: 1px solid #eef2f7;
    }
    .stars-select {
      display: flex;
      gap: 10px;
      margin: 8px 0 16px;
    }
    .stars-select label {
      background: #f3f4f6;
      padding: 8px 12px;
      border-radius: 10px;
      cursor: pointer;
      font-weight: 700;
    }
    .stars-select input {
      display: none;
    }
    .stars-select input:checked + span {
      background: linear-gradient(135deg,#1d4ed8,#3b82f6);
      color: white;
      padding: 8px 12px;
      border-radius: 10px;
      display: inline-block;
    }
    textarea {
      width: 100%;
      min-height: 110px;
      padding: 12px;
      font-size: 15px;
      border: 1px solid #d0d7e2;
      border-radius: 10px;
      resize: vertical;
    }
  </style>
</head>
<body>

<div class="container">
  <div class="feedback-card">


    <h2>⭐ Submit Your Feedback</h2>
    <p class="muted">Hi <?= htmlspecialchars($_SESSION["name"]) ?>, tell us how we did!</p>

    <?php if ($msg): ?>
      <p class="error"><?= htmlspecialchars($msg) ?></p>
    <?php endif; ?>

    <?php if ($success): ?>
      <p class="success"><?= htmlspecialchars($success) ?></p>
    <?php endif; ?>

    <form method="POST">
      
      <label>Rating</label>
      <div class="stars-select">
        <?php for($i=1;$i<=5;$i++): ?>
          <label>
            <input type="radio" name="rating" value="<?= $i ?>" required>
            <span><?= $i ?> ★</span>
          </label>
        <?php endfor; ?>
      </div>

      <label>Comment</label>
      <textarea name="comment" placeholder="Write your feedback..." required></textarea>

      <button type="submit" style="margin-top:12px;">Submit Feedback</button>
    </form>

  </div>
</div>

</body>
</html>
