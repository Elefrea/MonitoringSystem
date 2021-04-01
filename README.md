<h1>Monitoring System for my Ubuntu Server</h1>

This monitoring system displays users memory and cpu usage in a graphical way, every 5 minutes.

3 scripts gather all the informations needed (sonde1_users.py, sonde2_cpu.sh, sonde3_mem.sh), the data is then send to a sqlite3 database.
Another script (visualisation.py) does the transcription of the database data to a graph, using the python pygal library.

For each user there are 2 charts rendered (one for the memory and one for the cpu usage), such as this one:

![root_mem_chart](https://user-images.githubusercontent.com/62560237/113291021-b4eb6a00-92f2-11eb-812b-d83d7553a896.png)

You can find all the data of my server on the [Monitoring Screen](https://monitoring-ubuntu.herokuapp.com/).
Data are updated every 5 minutes, refresh the webpage to have the latest infos.
