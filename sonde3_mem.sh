#!/bin/bash

file=/home/elefrea/Uni/MonitoringSystem/monitoring.db
sqlite3 $file <<EOF
PRAGMA busy_timeout=3000;
CREATE TABLE IF NOT EXISTS mem(date_time date NOT NULL, user text NOT NULL, mem_usage integer);
CREATE TABLE IF NOT EXISTS cpu(date_time date NOT NULL, user text NOT NULL, cpu_usage integer);
EOF

typeset -i max_mem=$(cat /home/elefrea/Uni/MonitoringSystem/mem_crise.txt)

for user in $(who | sed 's/ .*//' | sort -u)
do 	
	sum=$(top -b -n 1 -u $user | awk 'NR>7 {sum += $10;} END {print sum;}')
       	sqlite3 $file "PRAGMA busy_timeout=3000; INSERT INTO mem (date_time, user, mem_usage) values (datetime(), '$user', '$sum');"
	if [ ${sum%%.*} -gt $max_mem ]; then
		echo `/usr/sbin/sendmail "khaoula.otmani@alumni.univ-avignon.fr" < /home/elefrea/Uni/MonitoringSystem/alerte_mem.txt`
	fi

done
sum=$(top -b -n 1 -u "root" | awk 'NR>7 {sum += $10;} END {print sum;}')
sqlite3 $file "PRAGMA busy_timeout=3000; INSERT INTO mem (date_time, user, mem_usage) values (datetime(), 'root', '$sum');"

