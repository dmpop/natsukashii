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
	<link href="https://fonts.googleapis.com/css?family=Inconsolata" rel="stylesheet">
	<link href="https://fonts.googleapis.com/css?family=Bungee+Shade" rel="stylesheet">
	<link rel="shortcut icon" href="favicon.ico" />
	<link rel="stylesheet" href="sakura-dark.css" type="text/css">
	<title>懐かしい</title>
    </head>
    <body>
	<h1>Stroll down Memory Lane</h1>
	<p>/\/\/\/\/\/\/\/\/\</p>
	<?php
	require_once('protect.php');
	$files = glob("photos/*.*");
	for ($i = 0; $i < count($files); $i++) {
            $photo = $files[$i];
            $exif = exif_read_data($photo, 0, true);
            echo "<h3>".$exif['EXIF']['DateTimeOriginal']."</h3>";
            echo '<img src="' . $photo . '" alt="" width="800"/>' . "<br /><br />";
            echo '<small>'.$exif['COMMENT']['0'].'</small>';
            echo '<p></p>';
	}
	?>
	<p>= = = = = = = = =</p>
	<p>Made with <a href="https://gitlab.com/dmpop/natsukashii">Natsukashii</a>
    </body>
</html>
