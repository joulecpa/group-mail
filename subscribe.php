<!DOCTYPE html>
<html>
<head>
    <title>FSOSS Subscribe</title>
</head>
<body>

<?php
// #!/usr/bin/env php

// Add email address to database
// Author: Christopher Markieta

try
{
    $email = SQLite3::escapeString(urldecode($_GET['email']));
    $id    = SQLite3::escapeString($_GET['id']);
    $db    = new PDO('sqlite:/var/fsoss/fsoss.sqlite3') 
                 or die ('cannot open the database');

    $stmt = $db->prepare("INSERT OR IGNORE INTO SUBSCRIPTION 
                              (EMAIL) VALUES (:email);

                          UPDATE SUBSCRIPTION SET
                              SUBSCRIBED = 1, 
                              DATE       = CURRENT_TIMESTAMP
                          WHERE EMAIL=:email AND ID=:id;");

    $stmt->execute(array(":email" => $email, ":id" => $id));
    $db     = null;
?>
    <h3>Thank You</h3>
    <p>You are subscribed to the mailing list.</p>
<?php }
catch(Exception $e)
{ ?>
    <h3>Something went wrong</h3>
    <p>Please send us an email at <a href="mailto:ostep-team@senecac.on.ca?Subject=FSOSS%20Unsubscribe%20Failed">ostep-team@senecac.on.ca</a></p>
<?php } ?>

</body>
</html>
