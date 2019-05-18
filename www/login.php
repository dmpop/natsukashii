<?php
/* Your password */
$password = 'cowpat';

/* Redirects here after login */
$redirect_after_login = 'index.php';

/* Will not ask password again for */
$remember_password = strtotime('+30 days'); // 30 days

if (isset($_POST['password']) && $_POST['password'] == $password) {
    setcookie("password", $password, $remember_password);
    header('Location: ' . $redirect_after_login);
    exit;
}
?>
<!DOCTYPE html>
<html>
    <head>
	<head>
	    <meta http-equiv="content-type" content="text/html; charset=UTF-8" />
	    <meta name="viewport" content="width=device-width">
	    <link rel="shortcut icon" href="favicon.ico" />
	    <link rel="stylesheet" href="sakura-dark.css" type="text/css">
	    <title>懐かしい</title>
	</head>
    </head>
    <body>
	<div style="text-align:center;margin-top:50px;">
            <form method="POST">
		Password:  <input type="password" name="password">
            </form>
	</div>
    </body>
</html>
