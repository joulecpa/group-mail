#!/usr/bin/env bash

# Send email to database list of addresses
# Author: Christopher Markieta

if [ -z "$1" ]; then
	echo 'Missing argument for database file'
	exit 1
fi

       IFS='|'                                     # Bash delimeter
    MY_DIR=$(/usr/bin/dirname $0)                  # Directory of script
      body=$(/usr/bin/cat     "$MY_DIR"/body.html) # Reduce disk access time
    footer=$(/usr/bin/cat     "$MY_DIR"/footer.html)
recipients=$(/usr/bin/sqlite3 "$1" "SELECT * FROM FSOSSCFP")

while read -r recipient; do
	read email id <<< "$recipient"

	/usr/sbin/sendmail $email <<-EOF
		to:$email
		subject:FSOSS 2014 Evite (UPDATED FINAL - READY FOR USE)
		from:FSOSS-CFP <fsoss-cfp@senecac.on.ca>
		$body
		<div align=3D"center">If you do not wish to receive further email regarding=
		 FSOSS, please <a href=3D"http://rome.proximity.on.ca/fsoss/unsubscribe.php=
		?email=3D$(perl -MURI::Escape -e 'print uri_escape($ARGV[0]);' "$email")&id=
		=3D$id">click here to unsubscribe</a></div>
		$footer
	EOF
done <<< "$recipients"
