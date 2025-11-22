<?php
// Show all errors
error_reporting(E_ALL);
ini_set('display_errors', 1);
?>

<!DOCTYPE html>
<html>
<head>
    <title>SQL Query Executor</title>
    
  <link rel="stylesheet" href="style.css">
  <script src="script.js"></script>
</head>
<body>
<button id="theme-switcher" class="btn-blue">Toggle Theme</button>
<div class="card">
    <h2>Run SQL Query on Canteen_Management_System</h2>

    <form method="POST">
        <textarea name="query" rows="4" placeholder="Enter your SQL query here"></textarea>
        <br>
        <button type="submit">Run</button>
        <button type="submit"><a href="./">Go To Home</a></button>

    </form>

<?php
if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    $query = trim($_POST['query']);

    if (empty($query)) {
        echo "<p style='color:red;'>Please enter a query.</p>";
    } else {
        $servername = "127.0.0.1";
        $username   = "root";
        $password   = "";
        $dbname     = "Canteen_Management_System";

        $conn = new mysqli($servername, $username, $password, $dbname, 3306);

        if ($conn->connect_error) {
            die("Connection failed: " . $conn->connect_error);
        }

        $result = $conn->query($query);

        if ($result === true) {
            echo "<p style='color:green;'>✅ Query executed successfully.</p>";
        } elseif ($result && $result->num_rows > 0) {
            echo "<table>";
            echo "<tr>";
            while ($field = $result->fetch_field()) {
                echo "<th>" . htmlspecialchars($field->name) . "</th>";
            }
            echo "</tr>";

            while ($row = $result->fetch_assoc()) {
                echo "<tr>";
                foreach ($row as $col) {
                    echo "<td>" . htmlspecialchars($col) . "</td>";
                }
                echo "</tr>";
            }
            echo "</table>";
        } elseif ($result && $result->num_rows == 0) {
            echo "<p>0 rows returned.</p>";
        } else {
            echo "<p style='color:red;'>❌ Error: " . $conn->error . "</p>";
        }
        $conn->close();
    }
}
?>
</div>

</body>
</html>