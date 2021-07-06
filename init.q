\d .par

gbl.date:.z.d
gbl.timer:{
	//Runs every minute
	.spt.utl.checkToken[];
	//Runs every 5 minutes
	if[0=(`minute$x)mod 5;.wifi.utl.updDevices[]];
	//Runs once a day
	if[.z.d<>gbl.date;.cal.utl.sendRmd y;gbl.date:.z.d]
	}

\d .

.z.pp:.twl.pst.callback
.z.ts:.par.gbl.timer[;reminders]
system"t 60000"
system"S ",string 7h$.z.t
\x .z.ph

c:@[.utl.con.chk;[];0]
-1"Internet connection",$[200=c;"";" not"]," ok: response code was ",string c;

.wifi.cfg.devices:.wifi.utl.getDevices[]
