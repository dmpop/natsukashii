<?php
/* Your password */
$password = 'password';

/* Redirects here after login */
$redirect_after_login = 'index.php';

/* Set timezone to UTC */

date_default_timezone_set('UTC');

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
	<meta http-equiv="content-type" content="text/html; charset=UTF-8" />
	<meta name="viewport" content="width=device-width">
	<link rel="shortcut icon" href="favicon.png" />
	<link rel="stylesheet" href="lit.css" type="text/css">
	<title>懐かしい</title>
</head>

<body>
	<div class="c">
		<form method="POST">
			Password: <input type="password" name="password">
		</form>
	</div>
</body>

</html>