<!DOCTYPE html>
<html lang="de">
  <head>
	<meta charset="utf-8" />
	<meta name="viewport" content="width=device-width, initial-scale=1.0" />
	<title>Speedtest</title>
	<link rel="stylesheet" href="styles.css">
  </head>
  <body>
	<table>
		<tbody>
			<tr>
				<th>Timestamp</th>
				<th>Ping (ms)</th>
				<th>Download<br />(MBit/s)</th>
				<th>Upload<br />(MBit/s)</th>
				<th>Server</th>
			</tr>
			<?php
				include "data.php";
			?>
		</tbody>
	</table>
  </body>
</html>