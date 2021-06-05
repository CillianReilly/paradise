\d .cal

utl.loadRmds:{0(set;`reminders;)("ds**";enlist",")0:`:calendar/reminders.csv;}

utl.comp:{[fc;f;dc;d](fc in f)&{(x$/:y)~\:x$z}[;dc;d]$[f in`Y;`mm`dd;f in`M;`dd;`date]}
utl.yearlyComp:utl.comp[;`Y;;]
utl.monthlyComp:utl.comp[;`M;;]
utl.onceOffComp:utl.comp[;`O;;]

utl.sel:{?[x;enlist(y;`freq;`date;.z.d);0b;()]}
utl.getYearly:utl.sel[;utl.yearlyComp]
utl.getMonthly:utl.sel[;utl.monthlyComp]
utl.getOnceOff:utl.sel[;utl.onceOffComp]
utl.fmt:{enlist", "sv" "sv/:flip x}

utl.getRmds:{raze utl[`getOnceOff`getMonthly`getYearly]@\:x}
utl.fmtRmds:{
	yrs:update years:string(-/)`year$(.z.d;date)from select from x where freq in`Y;
	n:x except enlist[`years]_yrs;
	r:enlist"Reminder: ";
	if[count yrs;r:r,utl.fmt yrs`reminder`name`years];
	if[count n;r:r,utl.fmt n`name`reminder];
	first[r],", "sv 1_r
	}

utl.sendRmd:{
	r:utl.getRmds x;
	if[not count r;:"No reminders today"];
	.twl.pst.txt utl.fmtRmds r
	}	

utl.loadRmds[]

\d .
