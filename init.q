\d .par

gbl.date:.z.d
gbl.timer:{
	//Runs every minute
	.spt.utl.checkToken[];
	.wifi.utl.updDevices[];
	//Runs every 5 minutes
	if[0=(`minute$x)mod 5;.wifi.utl.getNmap[]];
	//Runs once a day
	if[.z.d<>gbl.date;.cal.utl.sendRmd 0`reminders;gbl.date:.z.d]
	}

gbl.getStatus:{.utl.http.parseRC .utl.http.get[`:https://www.howsmyssl.com;"/a/check";""]}
gbl.status:{
	c:@[gbl.getStatus;[];0];
	s:"Internet connection",$[200=c;"";" not"]," ok: response code was ",string c;
	.log.out s;s
	}

gbl.fromAddr:"paradise@cillianreilly.com"
gbl.startTime:.z.p

\d .

.par.gbl.status[];
.wifi.cfg.devices:.wifi.utl.getDevices[]

if[ML;.ml.par.init[2000;0.001]]

.z.ph:{}
.z.pp:.twl.pst.callback
.z.ts:.par.gbl.timer
system"S ",string 7h$.z.t
system"t 60000"
