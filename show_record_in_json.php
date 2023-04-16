<?php
// MySQL database credentials
$host = 'localhost';
$username = 'root';
$password = '';
$database = 'test1';

// Create connection
$conn = mysqli_connect($host, $username, $password, $database);

// Check connection
if (!$conn) {
    die("Connection failed: " . mysqli_connect_error());
}

// Query to retrieve data from the table
$sql = "SELECT * FROM empp";
$result = mysqli_query($conn, $sql);

// Create an array to store the data
$data = array();

// Loop through the results and add them to the array
while ($row = mysqli_fetch_assoc($result)) {
    $data[] = $row;
}

// Close the database connection
mysqli_close($conn);

// Convert the array to JSON format
$json_data = json_encode($data);

// Output the JSON data
echo $json_data;
?>