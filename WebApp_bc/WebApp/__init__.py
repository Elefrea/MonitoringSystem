from flask import Flask, url_for, render_template
import os
import sqlite3
import time
from datetime import datetime
import pygal

app = Flask(__name__)

@app.route("/")
def home():
    con = sqlite3.connect('/home/elefrea/Uni/MonitoringSystem/monitoring.db', timeout=15)
    cur = con.cursor()

    title = ["user", "date", "cpu", "mem"]
    output = cur.execute("SELECT cpu.user, cpu.date_time, cpu_usage, mem_usage FROM cpu NATURAL JOIN mem")

    data = []
    for out in output :
       data.append(out)

    chart_cpu = create_chart('cpu',cur)
    chart_mem = create_chart('mem', cur)
    return render_template('index.html', title=title, data=data, chart_cpu=chart_cpu, chart_mem=chart_mem)


def create_chart(table, cur):
    line_chart = pygal.Line()
    users = cur.execute("SELECT user FROM users")
    for user in set(users):
        chart_val = [0,0,0,0,0,0]
        chart_date = ['','','','','','']
        
        if(table == "cpu"):
            values = cur.execute("SELECT date_time, cpu_usage FROM cpu WHERE user=?", (user[0],))
        if(table == "mem"):
            values = cur.execute("SELECT date_time, mem_usage FROM mem WHERE user=?", (user[0],))

        for value in values:
            chart_date.append(value[0])
            chart_val.append(value[1])
            chart_date.pop(0)
            chart_val.pop(0)


        line_chart.add(user[0] +" "+ table +" usage", chart_val)
    
    line_chart.x_labels = map(str, chart_date)
    
    return line_chart.render_data_uri()

if __name__ == "__main__":
    app.run()
 
