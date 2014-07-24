<!DOCTYPE html>
<html>
<head>
    <title>FSOSS Unsubscribe</title>
</head>
<body>

<?php
// #!/usr/bin/env php

// Remove email address entry from a CSV file
// Author: Christopher Markieta

try
{
    $email = SQLite3::escapeString(urldecode($_GET['email']));
    $id    = SQLite3::escapeString($_GET['id']);
    $db    = new PDO('sqlite:/var/fsoss/fsosscfp.sqlite3') or die ('cannot open the database');

    $stmt = $db->prepare("DELETE FROM FSOSSCFP WHERE EMAIL=:email AND ID=:id");
    $stmt->execute(array(":email" => $email, ":id" => $id));
    $db     = null;
?>
    <h3>Thank You</h3>
    <p>You have been unsubscribed from the mailing list.</p>
<?php }
catch(Exception $e)
{ ?>
    <h3>Something went wrong</h3>
    <p>Please send us an email at <a href="mailto:ostep-team@senecac.on.ca?Subject=FSOSS%20Unsubscribe%20Failed">ostep-team@senecac.on.ca</a> .</p>
<?php } ?>

</body>
</html>
