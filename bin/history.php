<?php
if (session_id() == "") session_start();
$link = mysqli_connect("localhost", "USERNAME", "PASSWORD", "DBNAME");
$sessionID = session_id();
$query11 = "SELECT * FROM talk_users WHERE sessionID = '$sessionID'";
$sessionCheck = mysqli_query($link, $query11);
$sessionNum = mysqli_num_rows($sessionCheck);

if ($sessionNum < 1) {
    echo "login";
} else {

    if (isset($_GET['lastID'])) {
        $where = "WHERE id > " . $_GET['lastID'];
    } else {
        $where = "";
    }

    $results = mysqli_query($link, "SELECT * FROM talk_history $where ORDER BY time ASC");

    $query2 = 'SELECT id, name FROM talk_users';
    $results2 = mysqli_query($link, $query2);
    while ($line2 = mysqli_fetch_assoc($results2)) {
        $users[$line2["id"]] = $line2["name"];
    }

    $num = mysqli_num_rows($results);

    if ($num < 1) {
        echo $num;
    } else {
        echo "<?xml version=\"1.0\"?>\n";
        echo "<messages>\n";
        while ($line = mysqli_fetch_assoc($results)) {
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
mysqli_close($link);
