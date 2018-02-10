<?php
// DB connection
$db_host = "your database host";
$db_user = "your database username";
$db_passwd = "your database password";

// DB database and table
$db_name = "your database name";
$db_table = "your database table";

// connect to MySQL
$conn = new mysqli($db_host, $db_user, $db_passwd, $db_name);
// Check connection
if ($conn->connect_error) {
    die("Connection failed: " . $conn->connect_error);
} 

$sql = "SELECT timestamp, ping, download, upload, server FROM $db_table ORDER BY timestamp desc";
$result = $conn->query($sql);

if ($result->num_rows > 0) {
    // output data of each row
    while($row = $result->fetch_assoc()) {
        echo "
			<tr>
				<td>".$row["timestamp"]."</td>
				<td class=\"shortnumber\">".$row["ping"]."</td>
				<td class=\"shortnumber\">".$row["download"]."</td>
				<td class=\"shortnumber\">".$row["upload"]."</td>
				<td>".$row["server"]."</td>
			</tr>
		";
    }
} else {
    echo "0 results";
}
$conn->close();
?>