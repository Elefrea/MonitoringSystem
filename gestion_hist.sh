#!/bin/bash

file=/home/green/MonitoringSystem/monitoring.db
sqlite3 $file << EOF
PRAGMA busy_timeout=3000;
DELETE FROM cpu WHERE date_time < DATETIME('NOW', '-5 minutes');
DELETE FROM mem WHERE date_time < DATETIME('NOW', '-5 minutes');
DELETE FROM users WHERE date < DATETIME('NOW', '-5 minutes');
EOF

echo `python3 /home/green/MonitoringSystem/visualization.py`
echo `cp /home/green/MonitoringSystem/monitoring.db /home/green/MonitoringSystem/Backup/$(date +\%Y-\%m-\%d_\%H:\%M:\%S).db`
echo `/usr/bin/find /home/green/MonitoringSystem/Backup/ -name "*.db" -mmin +1710 -exec rm -f {} \;`

