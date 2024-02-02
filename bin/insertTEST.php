<?PHP
if (session_id() == "") session_start();
$sessionID = session_id();

$text = addslashes($_GET[text]);

$link = mysql_connect("HOST", "USER", "PASSWORD");
mysql_select_db("DB");


$queryUserID = "SELECT id FROM talk_users WHERE sessionID = '$sessionID'";
$resultsUserID = mysql_query($queryUserID);
$num = mysql_numrows($resultsUserID);
$line = mysql_fetch_assoc($resultsUserID);
$id = $line["id"];


if ($num > 0) {
    $query = "INSERT INTO talk_historyTEST (user, text) VALUES ('$id','$text')";
    $results = mysql_query($query);
}
mysql_close($link);
