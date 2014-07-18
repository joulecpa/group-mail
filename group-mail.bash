#!/usr/bin/env bash

# Send email to CSV list of addresses
# Author: Christopher Markieta

                          # Default sendmail maximum recipients is 1000
/usr/sbin/sendmail $(/usr/bin/sqlite3 fsosscfp "SELECT EMAIL FROM FSOSSCFP") <<EOF
subject:Seneca FSOSS 2014 - Call for Presentation Proposals
from:FSOSS-CFP <fsoss-cfp@senecacollege.ca>
Content-Type: text/html
MIME-Version: 1.0"
$(/bin/cat body.txt)
EOF
