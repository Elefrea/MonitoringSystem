<h1>Monitoring System for my Ubuntu Server</h1>

This monitoring system displays users memory and cpu usage in a graphical way, every 5 minutes.

3 scripts gather all the informations needed (sonde1_users.py, sonde2_cpu.sh, sonde3_mem.sh), the data is then send to a sqlite3 database.
Another script (visualisation.py) does the transcription of the database data to a graph, using the python pygal library.

For each user there are 2 charts rendered (one for the memory and one for the cpu usage), such as this one:

![elefrea_mem_chart](https://user-images.githubusercontent.com/62560237/113290432-ec0d4b80-92f1-11eb-822e-b6d175d27dc1.png)

You can find all the data of my server on : <a src="https://monitoring-ubuntu.herokuapp.com/"> <strong> Monitoring Screen </strong> </a>
The data is updated every 5 minutes, you must refresh the webpage in order to see it.
