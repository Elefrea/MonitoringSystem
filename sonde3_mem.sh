#!/bin/bash

file=/home/green/MonitoringSys/MonitoringSystem/monitoring.db
sqlite3 $file <<EOF
CREATE TABLE mem(date_time date NOT NULL, user text NOT NULL, mem_usage integer);
CREATE TABLE cpu(date_time date NOT NULL, user text NOT NULL, cpu_usage integer);
EOF
sum=0

for user in $(who | sed 's/ .*//' | sort -u)
do 
	(top -b -n 1 -u $user | awk -v user=$user 'NR>7 {sum += $10;} END {print user, $sum=sum;}')
       	sqlite3 $file "INSERT INTO mem (date_time, user, mem_usage) values (datetime(), '$user', '$sum');"
done
(top -b -n 1 -u "root" | awk -v user="root" 'NR>7 {sum += $10;} END {print user, sum;}')
