#!/bin/bash

file=/home/green/MonitoringSys/MonitoringSystem/monitoring.db
sqlite3 $file << EOF
DELETE FROM cpu WHERE date_time < DATETIME('NOW', '-5 minutes');
DELETE FROM mem WHERE date_time < DATETIME('NOW', '-5 minutes');
DELETE FROM users WHERE date < DATETIME('NOW', '-5 minutes');
EOF

echo `/usr/bin/find /home/green/MonitoringSys/MonitoringSystem/Backup/ -name "*.db" -mmin +1710 -exec rm -f {} \;`

