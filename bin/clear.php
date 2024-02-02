<?php
$link = mysqli_connect("localhost", "USERNAME", "PASSWORD", "DBNAME");
$results = mysqli_query($link, "TRUNCATE TABLE `talk_history`");
$results2 = mysqli_query($link, "INSERT INTO talk_history (user, text) VALUES (1,'Welcome!')");
mysqli_close($link);
echo 'Chat cleared';
