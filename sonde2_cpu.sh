#!/bin/bash


for user in $(who | sed 's/ .*//' | sort -u)
do 
	(top -b -n 1 -u $user | awk -v user=$user 'NR>7 {sum += $9;} END {print user, sum;}')
	sleep 0.05
done
wait
