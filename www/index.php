<?php
require_once('protect.php');
?>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01//EN" "http://www.w3.org/TR/html4/strict.dtd">

<html>

<!--
    Author: Dmitri Popov, dmpop@linux.com
    License: GPLv3 https://www.gnu.org/licenses/gpl-3.0.txt
    Source code: https://gitlab.com/dmpop/natsukashii
-->

<head>
	<meta http-equiv="content-type" content="text/html; charset=UTF-8" />
	<meta name="viewport" content="width=device-width">
	<link rel="shortcut icon" href="favicon.png" />
	<link rel="stylesheet" href="lit.css" type="text/css">
	<title>懐かしい</title>
</head>

<body>
	<div class="c">
		<h1>Stroll down memory lane</h1>
		<hr style="margin-bottom: 1.5em;">
		<?php
		$files = glob("photos/*.*");
		for ($i = 0; $i < count($files); $i++) {
			$photo = $files[$i];
			$exif = @exif_read_data($photo, 0, true);
			echo "<h2>" . $exif['EXIF']['DateTimeOriginal'] . "</h2>";
			echo '<p><img src="' . $photo . '" alt="" width="800"/></p>';
			echo '<p>' . $exif['COMMENT']['0'] . '</p>';
			echo '<p></p>';
		}
		?>
		<hr style="margin-top: 1em;">
		<p>This is <a href="https://gitlab.com/dmpop/natsukashii">Natsukashii</a>
	</div>
</body>

</html>