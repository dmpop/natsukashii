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
	<link href='http://fonts.googleapis.com/css?family=Lato' rel='stylesheet' type='text/css'>
	<link rel="shortcut icon" href="favicon.ico" />
	<link rel="stylesheet" href="https://unpkg.com/sakura.css/css/sakura-earthly.css" type="text/css">
    </head>
    <body>
	<h1>Stroll down the Memory Lane</h1>
	<p>You took these photos exactly one year ago.</p>
	<?php
	$files = glob("photos/*.*");
	for ($i = 0; $i < count($files); $i++) {
            $photo = $files[$i];
            echo '<img style="border-radius:9px;" src="' . $photo . '" alt="" width="800"/>' . "<br /><br />";
	}
	?>
	<p>Made with <a href="https://gitlab.com/dmpop/natsukashii">Natsukashii</a>.
    </body>
</html>
