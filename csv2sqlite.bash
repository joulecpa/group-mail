#!/usr/bin/env bash

# Inserts emails with unique ID from specific CSV format into SQLite database
# Author: Christopher Markieta

# Usage: ./csv2sqlite contacts.csv database.sql TABLENAME

transaction="BEGIN;"

while read p; do
    transaction=$transaction"INSERT INTO $3 VALUES ($p);"
done <$1

transaction=$transaction"COMMIT;"

sqlite3 $2 "$transaction"
