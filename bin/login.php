<?php
if (session_id() == "") session_start();

//include 'login_functions.php';

//$lp = $_POST['lastpage'];

$username = $_POST['u'];
$password = $_POST['p'];
$sessionID = session_id();

$con = mysqli_connect("localhost", "USERNAME", "PASSWORD", "DBNAME");
$result = mysqli_query($con, "SELECT timeDiff, password FROM talk_users WHERE name = '$username' ");
$row = mysqli_fetch_row($result);

$timeDiff =  $row[0];
$serverPassword = $row[1];

$pass = md5($serverPassword . $timeDiff);

if ($password == $pass) {
    $result2 = mysqli_query($con, "UPDATE talk_users SET sessionID = '$sessionID' WHERE name = '$username' ");
    $_SESSION['username'] = $username;
    error_log("success=true UPDATE talk_users SET sessionID = '$sessionID' WHERE name = '$username'");
    echo "success=true";
} else {
    echo "success=false";
    error_log("success=false UPDATE talk_users SET sessionID = '$sessionID' WHERE name = '$username'");
}

mysqli_close($con);
