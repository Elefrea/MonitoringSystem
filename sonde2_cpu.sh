#!/bin/bash


for user in $(who | sed 's/ .*//' | sort -u)
do 
	(top -b -n 1 -u $user | awk -v user=$user 'NR>7 {sum += $9;} END {print user, sum;}')
done
(top -b -n 1 -u "root" | awk -v user="root" 'NR>7 {sum += $9;} END {print user, sum;}')
