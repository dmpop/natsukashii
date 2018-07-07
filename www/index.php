<?php
$files = glob("photos/*.*");
for ($i = 0; $i < count($files); $i++) {
    $photo = $files[$i];
    echo '<img src="' . $photo . '" alt="" width="800"/>' . "<br /><br />";
}
?>
