<?PHP
session_start();
$_SESSION['username'] = "james";
$_SESSION['id'] = "2222";

echo "username: " . $_SESSION['username'];
echo "sessionID: " . $_SESSION['id'];
