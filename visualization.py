import pygal
import sqlite3;
from datetime import datetime;

def main():
    db_file = "/home/green/MonitoringSystem/monitoring.db"
    con = create_connection(db_file)
    cur = con.cursor()
    
    create_chart("cpu", cur)
    create_chart("mem", cur)

def create_chart(table, cur):
    chart_val = []
    if(table == "cpu"):
        values = cur.execute("SELECT cpu_usage FROM cpu")
    if(table == "mem"):
        values = cur.execute("SELECT mem_usage FROM mem")

    for value in values:
        chart_val.append(value[0])

    print(chart_val)
    ofile = table + "_chart.svg"
    bar_chart = pygal.Bar()
    bar_chart.add(table, chart_val)
    bar_chart.render_to_file(ofile)

def create_connection(db_file):
    return sqlite3.connect(db_file)

main()
