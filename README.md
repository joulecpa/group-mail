group-mail
==========

Send HTML-formatted email to SQLite database of addresses

Copy the Original text of the email and paste it in a file named `original` inside the directory containing the `group-mail` script.

Gmail:

![Show Original Image](https://cloud.githubusercontent.com/assets/3028095/16323463/0854183c-3979-11e6-811a-98be130fe7a6.jpg)

Similar procedure for Office 365.

Please note that pasting from your clipboard can take upwards of 1-2 minutes depending to the amount of graphics in the emails. It may seem like your editor is hanging/crashed, but if you wait long enough it should paste properly (tested with Vim).

The `group-mail` script needs to be modified if the original email comes from Gmail instead of Office 365. For example, the script looks for:

Gmail:      `Content-Type: multipart\/related`
Office 365: `Content-Type: multipart\/alternative`

You can determine the Content-Type by searching the `original` file.

Use `mkdb` to generate the SQLite3 database file used for storing and reading active/inactive email subscribers.

Use `csv2sqlite` to batch insert a list of emails (line-separated) into the database.

Place `unsubscribe.php` and `subscribe.php` in the same directory and host it using your favorite HTTP server (NGINX, Apache, etc).
