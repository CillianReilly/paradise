\l calendar/cal.q

\d .tst

cal.setUp:{
	cal.testRmds:([]date:.z.d;freq:`Y`M`W`O;reminders:("yearly";"monthly";"weekly";"once off"));
	.cal.utl.reminders:`:tests/reminders.csv;
	.cal.utl.reminders 0: csv 0: cal.testRmds;
	}

cal.tearDown:{hdel .cal.utl.reminders;}

cal.rootVars:{utl.testRootVars`reminders`toDo}
cal.utlVars:{utl.testVars[`.cal.utl;`toDo`loadToDo`getToDo`addToDo`rmToDo`reminders`loadRmds`comp`yearlyComp`monthlyComp`weeklyComp`onceOffComp`sel`getYearly`getMonthly`getWeekly`getOnceOff`fmt`addRmd`delOnceOff`getRmds`fmtRmds`rmds`sendRmd`init`verifyRmds]}

cal.toDoCsv:{utl.testFile`:calendar/toDo.csv}
cal.remindersCsv:{utl.testFile`:calendar/reminders.csv}

cal.loadToDo:{utl.testOutput[`.cal.utl.loadToDo;.cal.utl.toDo;(::)]}
cal.loadRmds:{utl.testOutput[`.cal.utl.loadRmds;.cal.utl.reminders;(::)]}

\d .
