#!/usr/bin/env python

# Send email to database list of addresses
# Author: Christopher Markieta

import smtplib
from email.mime.text import MIMEText

s = smtplib.SMTP('smtp.uk.xensource.com')
s.set_debuglevel(1)
msg = MIMEText("""body""")
sender = 'me@example.com'
recipients = ['john.doe@example.com', 'john.smith@example.co.uk']
msg['Subject'] = "subject line"
msg['From'] = sender
msg['To'] = ", ".join(recipients)
s.sendmail(sender, recipients, msg.as_string())

if [ -z "$1" ]; then
	echo 'Missing argument for database file.'
	exit 1
elif [ -z "$2" ]; then
	echo 'Missing argument for email subject.'
	exit 2
elif [ -n "$3" ]; then
	echo 'Too many arguments specified.'
	echo 'Ensure argument 2 (email subject) is surrounded in quotes.'
	exit 3
fi

        IFS='|'                                     # Bash delimeter
     MY_DIR=$(/usr/bin/dirname $0)                  # Directory of script
       body=$(/usr/bin/cat     "$MY_DIR"/body.html) # Reduce disk access time
     footer=$(/usr/bin/cat     "$MY_DIR"/footer.html)
 recipients=$(/usr/bin/sqlite3 "$1" "SELECT * FROM FSOSSCFP")
       from='FSOSS-CFP <fsoss-cfp@senecac.on.ca>'
unsubscribe='http://rome.proximity.on.ca/fsoss/unsubscribe.php' # Inaccessible

while /usr/bin/read -r recipient; do
	/usr/bin/read email id <<< "$recipient"

	/usr/sbin/sendmail $email <<-EOF
		to:$email
		subject:$2
		from:$from
		$body
		<p class=3D"MsoNormal" align=3D"center" style=3D"text-align:center;backgrou=
		nd:white"><span style=3D"color:black">If you do not wish to receive further=
		 email regarding FSOSS, please
		<a href=3D"$unsubscribe
		?email=3D$(perl -MURI::Escape -e 'print uri_escape($ARGV[0]);' "$email")&id=
		=3D$id">click here to unsubscribe</a><o:p></o:p></span></p>
		<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
		</div>
		</body>
		</html>
		$footer
	EOF
done <<< "$recipients"
