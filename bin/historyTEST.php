<?PHP
if (session_id() == "") session_start();
$link = mysql_connect("HOST", "USER", "PASSWORD");
mysql_select_db("DB");
$sessionID = session_id();
$query11 = "SELECT * FROM talk_users WHERE sessionID = '$sessionID'";
$sessionCheck = mysql_query($query11);
$sessionNum = mysql_numrows($sessionCheck);

if ($sessionNum < 1) {
    echo "login";
} else {

    if (isset($_GET[lastID])) {
        $where = "WHERE id > " . $_GET[lastID];
    } else {
        $where = "";
    }


    $query = "SELECT * FROM talk_historyTEST $where ORDER BY time ASC";
    $results = mysql_query($query);

    $query2 = 'SELECT id, name FROM talk_users';
    $results2 = mysql_query($query2);
    while ($line2 = mysql_fetch_assoc($results2)) {
        $users[$line2["id"]] = $line2["name"];
    }

    $num = mysql_numrows($results);

    if ($num < 1) {
        echo $num;
    } else {
        echo "<?xml version=\"1.0\"?>\n";
        echo "<messages>\n";
        while ($line = mysql_fetch_assoc($results)) {
            $id = $line['id'];
            $time = $line['time'];
            $time = date("m/d g:ia", strtotime($time));
            $user = $line['user'];
            $userText = stripslashes($line['text']);
            echo "	<message id='$id' time='$time' name='$users[$user]'>
			<![CDATA[$userText]]>
		</message>\n";
        }
        echo "</messages>\n";
    }
}
mysql_close($link);
