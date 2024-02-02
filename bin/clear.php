<?PHP
$link = mysql_connect("HOST", "USER", "PASSWORD");
mysql_select_db("DB");

$query = "TRUNCATE TABLE `talk_history`";
$results = mysql_query($query);

$query2 = "INSERT INTO talk_history (user, text) VALUES (1,'Welcome!')";
$results2 = mysql_query($query2);

mysql_close($link);
