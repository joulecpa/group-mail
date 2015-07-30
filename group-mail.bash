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
		subject:Thank you for participating in FSOSS 2014
		from:FSOSS-CFP <fsoss-cfp@senecac.on.ca>
		$body
		<p class=3D"MsoNormal" align=3D"center" style=3D"text-align:center;backgrou=
		nd:white"><span style=3D"color:black">If you do not wish to receive further=
		 email regarding FSOSS, please
		<a href=3D"http://rome.proximity.on.ca/fsoss/unsubscribe.php
		?email=3D$(perl -MURI::Escape -e 'print uri_escape($ARGV[0]);' "$email")&id=
		=3D$id">click here to unsubscribe</a><o:p></o:p></span></p>
		<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
		</div>
		</body>
		</html>
		$footer
	EOF
done <<< "$recipients"
