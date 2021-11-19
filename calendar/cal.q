\d .cal

utl.toDo:`:calendar/toDo.csv
utl.loadToDo:{0(set;`toDo;)first("* ";",")0:x;}
utl.getToDo:", "sv
utl.addToDo:{x 0: y,enlist z;utl.loadToDo x;utl.loadToDo utl.toDo;}
utl.rmToDo:{x 0: y where not all each y like/:\:{"*",x,"*"}each" "vs z;utl.loadToDo utl.toDo;}

utl.reminders:`:calendar/reminders.csv
utl.loadRmds:{0(set;`reminders;)("ds*";enlist",")0:x;}
utl.verifyRmds:{
	t:any 0<count each first("   *";",")0:x;
	if[t;.log.err"Found trailing commas in reminders.csv, not loading"];
	t
	}
	

utl.comp:{[fc;f;dc;d](fc in f)&{(x@/:y)~\:x z}[;dc;d]$[f in`Y;`mm`dd$;f in`M;`dd$;f in`W;mod[;7];`date$]}
utl.yearlyComp:utl.comp[;`Y;;]
utl.weeklyComp:utl.comp[;`W;;]
utl.monthlyComp:utl.comp[;`M;;]
utl.onceOffComp:utl.comp[;`O;;]

utl.sel:{?[x;enlist(y;`freq;`date;.z.d);0b;()]}
utl.getYearly:utl.sel[;utl.yearlyComp]
utl.getWeekly:utl.sel[;utl.weeklyComp]
utl.getMonthly:utl.sel[;utl.monthlyComp]
utl.getOnceOff:utl.sel[;utl.onceOffComp]
utl.fmt:{enlist", "sv" "sv/:flip x}

utl.addRmd:{[p;d;f;n;r]
	p 0: csv 0:(0`reminders)upsert(d;f;n;r);
	utl.loadRmds p
	}

utl.delOnceOff:{
	x 0: csv 0:delete from(0`reminders) where freq in`O,date<.z.d;
	utl.loadRmds x
	}

utl.getRmds:{raze utl[`getOnceOff`getWeekly`getMonthly`getYearly]@\:x}
utl.fmtRmds:{
	yrs:update years:string(-/)`year$(.z.d;date)from select from x where freq in`Y;
	n:x except enlist[`years]_yrs;
	r:enlist"Reminder: ";
	if[count yrs;r:r,utl.fmt yrs`reminder`years];
	if[count n;r:r,enlist", "sv n`reminder];
	first[r],", "sv 1_r
	}

utl.rmds:{r:utl.getRmds x;if[not count r;:()];utl.fmtRmds r}
utl.sendRmd:{
	r:utl.rmds x;
	utl.delOnceOff utl.reminders;
	if[not count r;:"No reminders today"];
	.twl.pst.text r
	}

utl.init:{
	if[utl.verifyRmds utl.reminders;:()];
	utl.loadRmds utl.reminders;
	utl.loadToDo utl.toDo
	}
	
utl.init[];

\d .
