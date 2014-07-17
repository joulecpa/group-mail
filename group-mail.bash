#!/usr/bin/env bash

# Send email to CSV list of addresses
# Author: Christopher Markieta

# Usage: ./groupMail contacts.csv body.txt

/usr/sbin/sendmail $(cat "$1") <<EOF
subject:Seneca FSOSS 2014 - Call for Presentation Proposals
from:FSOSS-CFP <fsoss-cfp@senecacollege.ca>
$(cat "$2")
EOF
