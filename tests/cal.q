\l calendar/cal.q

\d .tst

cal.utlVars:{utl.testVars[`.cal.utl;`toDo`loadToDo`getToDo`addToDo`rmToDo`reminders`loadRmds`comp`yearlyComp`monthlyComp`onceOffComp`sel`getYearly`getMonthly`getOnceOff`fmt`addRmd`delOnceOff`getRmds`fmtRmds`rmds`sendRmd`init]}

cal.loadToDo:{
	utl.testOutput[`.cal.utl.loadToDo;
		.cal.utl.toDo;
		(::)
	]}

\d .
