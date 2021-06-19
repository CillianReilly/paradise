\d .cal

utl.reminders:`:calendar/reminders.csv
utl.loadRmds:{0(set;`reminders;)("ds**";enlist",")0:x;}

utl.comp:{[fc;f;dc;d](fc in f)&{(x$/:y)~\:x$z}[;dc;d]$[f in`Y;`mm`dd;f in`M;`dd;`date]}
utl.yearlyComp:utl.comp[;`Y;;]
utl.monthlyComp:utl.comp[;`M;;]
utl.onceOffComp:utl.comp[;`O;;]

utl.sel:{?[x;enlist(y;`freq;`date;.z.d);0b;()]}
utl.getYearly:utl.sel[;utl.yearlyComp]
utl.getMonthly:utl.sel[;utl.monthlyComp]
utl.getOnceOff:utl.sel[;utl.onceOffComp]
utl.fmt:{enlist", "sv" "sv/:flip x}

utl.addRmd:{[p;d;f;n;r]
	p 0: csv 0:(0`reminders)upsert(d;f;n;r);
	utl.loadRmds p
	}

utl.delOnceOff:{
	x 0: csv 0:delete from x where freq in`O,date<.z.d;
	utl.loadRmds x
	}

utl.getRmds:{raze utl[`getOnceOff`getMonthly`getYearly]@\:x}
utl.fmtRmds:{
	yrs:update years:string(-/)`year$(.z.d;date)from select from x where freq in`Y;
	n:x except enlist[`years]_yrs;
	r:enlist"Reminder: ";
	if[count yrs;r:r,utl.fmt yrs`reminder`name`years];
	if[count n;r:r,utl.fmt n`name`reminder];
	first[r],", "sv 1_r
	}

utl.rmds:{r:utl.getRmds x;if[not count r;:()];utl.fmtRmds r}
utl.sendRmd:{r:utl.rmds x;if[not count r;:"No reminders today"];.twl.pst.text r}

utl.loadRmds utl.reminders

\d .
