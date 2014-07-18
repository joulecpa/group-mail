#!/usr/bin/env bash

# Inserts emails with unique ID from specific CSV format into SQLite database
# Author: Christopher Markieta

# Usage: ./csv2sqlite.bash contacts.csv

transaction="BEGIN;"

while read p; do
    transaction=$transaction"INSERT INTO FSOSSCFP VALUES ($p);"
done <$1

transaction=$transaction"COMMIT;"

sqlite3 fsosscfp "$transaction"
