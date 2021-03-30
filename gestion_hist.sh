#!/bin/bash

file=/home/elefrea/Uni/MonitoringSystem/monitoring.db
sqlite3 $file << EOF
PRAGMA busy_timeout=3000;
DELETE FROM cpu WHERE date_time < DATETIME('NOW', '-5 minutes');
DELETE FROM mem WHERE date_time < DATETIME('NOW', '-5 minutes');
DELETE FROM users WHERE date < DATETIME('NOW', '-5 minutes');
EOF

echo `cp /home/elefrea/Uni/MonitoringSystem/monitoring.db /home/elefrea/Uni/MonitoringSystem/Backup/$(date +\%Y-\%m-\%d_\%H:\%M:\%S).db`
echo `/usr/bin/find /home/elefrea/Uni/MonitoringSystem/Backup/ -name "*.db" -mmin +10 -exec rm -f {} \;`
echo `python3 /home/elefrea/Uni/MonitoringSystem/visualization.py`

