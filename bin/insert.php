<?php

if (session_id() == "") session_start();
$sessionID = session_id();
$text = addslashes($_GET['text']);
$link = mysqli_connect("localhost", "USERNAME", "PASSWORD", "DBNAME");
$resultsUserID = mysqli_query($link, "SELECT id FROM talk_users WHERE sessionID = '$sessionID'");
$num = mysqli_num_rows($resultsUserID);
$line = mysqli_fetch_assoc($resultsUserID);
$id = $line["id"];

if ($num > 0) {
    $results = mysqli_query($link, "INSERT INTO talk_history (user, text) VALUES ($id,'$text')");
}
mysqli_close($link);
