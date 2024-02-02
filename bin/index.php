<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en" lang="en">
<head>
	<title>Comet</title>
	<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
	<meta name="revised" content="Gabriel Mariani, 3/20/2008" />
	
	<? $path="../../"; include $path.'lib/php/global_header.php'; ?>
	
	<link rel="stylesheet" type="text/css" href="style.css" />
	
	<script type="text/javascript">
		var flashvars = {};
		var params = {};
		params.bgcolor = "#000000";
		var attributes = {};
		attributes.id = "comet";
		swfobject.embedSWF("talk.swf", "flashcontent", "900", "700", "9.0.0", "../../lib/flash/expressInstall.swf", flashvars, params, attributes);
	</script>

</head>

<body>
	<div id="distance"></div>
	<div id="wrapper">
		<div id="flashcontent">
			<h1>Course Vector Web Design</h1>
			<br>
			<p>
				<strong>You need to upgrade your Flash Player</strong><br>
				This site requires atleast version 9.
			</p>
		</div>
		
		<div align="center">
			<br/>
			<a href="http://www.adobe.com/go/getflashplayer" target="_blank" title="Get Adobe Flash Player"><img src="../../images/shared/get_flash_player.gif" alt="Get Adobe Flash Player" width="112" height="33" border="0"></a>
			<br/>
			<span class="style1">
				<a href="http://www.coursevector.com/" target="_blank">Comet by Course Vector</a>
			</span>
		</div>
	</div>

	<? include $path.'lib/php/global_footer.php'; ?>

</body>
</html>
