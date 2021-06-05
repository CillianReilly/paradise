\d .par

gbl.date:.z.d
gbl.timer:{
	//Runs every minute
	.spt.utl.checkToken[];
	//Runs every 5 minutes
	if[0=(`minute$.z.p)mod 5;.wifi.utl.updDevices[]];
	//Runs once a day
	if[.z.d<>gbl.date;.cal.utl.sendRmd reminders;gbl.date:.z.d]
	}

\d .
