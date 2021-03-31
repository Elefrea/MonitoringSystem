import pygal;
import sqlite3;
from datetime import datetime;

def main():
    db_file = "/home/elefrea/Uni/MonitoringSystem/monitoring.db"
    con = create_connection(db_file)
    cur = con.cursor()
    
    output_data(cur)
    create_chart("cpu", cur)
    create_chart("mem", cur)

def create_chart(table, cur):
    chart_val = []
    chart_date = []
    cpu_data = []
    mem_data = []
    users = cur.execute("SELECT user FROM users")
    for user in set(users):
        if(table == "cpu"):
            values = cur.execute("SELECT date_time, cpu_usage FROM cpu WHERE user=?", (user[0],))
        if(table == "mem"):
            values = cur.execute("SELECT date_time, mem_usage FROM mem WHERE user=?", (user[0],))

        for value in values:
            chart_date.append(value[0])
            chart_val.append(value[1])


        ofile = "/home/elefrea/Uni/MonitoringSystem/Visu/" + user[0] + "_" + table + "_chart.svg"
        line_chart = pygal.Line()
        line_chart.x_labels = map(str, chart_date)
        line_chart.add(user[0] +" "+ table +" usage", chart_val) 
        line_chart.render_to_file(ofile)

def output_data(cur):
    print("user      date      cpu      mem")
    output = cur.execute("SELECT cpu.user, cpu.date_time, cpu_usage, mem_usage FROM cpu INNER JOIN mem ON mem.user=cpu.user")
    for out in set(output):
        data = '%12s %24s %12s %12s' % (str(out[0]), str(out[1]), str(out[2]), str(out[3]))
        print(data)


def create_connection(db_file):
    return sqlite3.connect(db_file)

main()
