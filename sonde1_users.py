import psutil;
import sqlite3;
from datetime import datetime;

def main():
    db_file = "/home/elefrea/Uni/MonitoringSystem/monitoring.db"
    con = create_connection(db_file)
    cur = con.cursor()
    cur.execute("CREATE TABLE IF NOT EXISTS users(date date NOT NULL, user text NOT NULL);")
    
    users = psutil.users()
    users_name = set([ user[0] for user in users ])
    for user in users_name:
        now = datetime.now()
        cur.execute("INSERT INTO users (date, user) VALUES ($1,$2)", (now, user))
    
    cur.execute("INSERT INTO users (date, user) VALUES ($1,$2)", (now, "root"))
    con.commit()

def create_connection(db_file):
    return sqlite3.connect(db_file)

main()

