<?php if (session_id() == "") session_start(); ?>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en" lang="en">

<head>
    <title>BlackBox</title>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <meta name="description" content="BlackBox is a Adobe Flash based secure login" />
    <meta name="revised" content="Gabriel Mariani, 3/20/2008" />

    <style>
        *,
        *:before,
        *:after {
            box-sizing: border-box;
        }

        html,
        body {
            height: 100%;
            background-color: #000000;
        }

        body {
            margin: 0 auto;
            max-width: 1000px;
            width: 100%;
            padding: 25px;
        }

        main {
            padding: 30px;
            text-align: center;
        }
    </style>
</head>

<body>
    <main>
        <div id="flashcontent">
            <p>
                <strong>You need to upgrade your Flash Player</strong><br>
                This site requires atleast version 9.
            </p>
        </div>
    </main>

    <script src="../shared/swfobject.js"></script>
    <script type="text/javascript">
        var flashvars = {};
        var params = {};
        params.bgcolor = "#000000";
        var attributes = {};
        attributes.id = "blackbox";
        swfobject.embedSWF("./assets/swf/login.swf", "flashcontent", "200", "100", "9.0.0", "../shared/expressInstall.swf", flashvars, params, attributes);
    </script>
</body>

</html>