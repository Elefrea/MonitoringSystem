#!/bin/bash

file=/home/green/MonitoringSys/MonitoringSystem/monitoring.db
sqlite3 $file <<EOF
CREATE TABLE mem(date_time date NOT NULL, user text NOT NULL, mem_usage integer);
CREATE TABLE cpu(date_time date NOT NULL, user text NOT NULL, cpu_usage integer);
EOF

for user in $(who | sed 's/ .*//' | sort -u)
do 
	sum=$(top -b -n 1 -u $user | awk 'NR>7 {sum += $9;} END {print sum}')
       	sqlite3 $file "PRAGMA busy_timeout=3000; INSERT INTO cpu (date_time, user, cpu_usage) values (datetime(), '$user', '$sum');"
done
sum=$(top -b -n 1 -u "root" | awk 'NR>7 {sum += $9;} END {print sum;}')
sqlite3 $file "PRAGMA busy_timeout=3000; INSERT INTO cpu (date_time, user, cpu_usage) values (datetime(), 'root', '$sum');"

