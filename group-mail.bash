#!/usr/bin/env bash

# Send email to CSV list of addresses
# Author: Christopher Markieta

IFS='|'
body=$(/bin/cat body.txt) # Reduce disk access time
recipients=$(/usr/bin/sqlite3 fsosscfp.sqlite3 "SELECT * FROM FSOSSCFP")

while read -r recipient; do
	read email id <<< "$recipient"

	/usr/sbin/sendmail $email <<-EOF
		to:$email
		subject:Seneca FSOSS 2014 - Call for Presentation Proposals
		from:FSOSS-CFP <fsoss-cfp@senecac.on.ca>
		Content-Type: text/html
		MIME-Version: 1.0"
		$body
		<p>If you do not wish to receive further email regarding FSOSS, please <a href="http://rome.proximity.on.ca/fsoss/unsubscribe.php?email=$(perl -MURI::Escape -e 'print uri_escape($ARGV[0]);' "$email")&id=$id">click here to unsubscribe</a>.</p>
	EOF
done <<< "$recipients"
