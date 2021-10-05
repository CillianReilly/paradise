\l calendar/cal.q

\d .tst

cal.rootVars:{utl.testRootVars`reminders`toDo}
cal.utlVars:{utl.testVars[`.cal.utl;`toDo`loadToDo`getToDo`addToDo`rmToDo`reminders`loadRmds`comp`yearlyComp`monthlyComp`weeklyComp`onceOffComp`sel`getYearly`getMonthly`getWeekly`getOnceOff`fmt`addRmd`delOnceOff`getRmds`fmtRmds`rmds`sendRmd`init]}

cal.toDoCsv:{utl.testFile`:calendar/toDo.csv}
cal.remindersCsv:{utl.testFile`:calendar/reminders.csv}

cal.loadToDo:{utl.testOutput[`.cal.utl.loadToDo;.cal.utl.toDo;(::)]}
cal.loadRmds:{utl.testOutput[`.cal.utl.loadRmds;.cal.utl.reminders;(::)]}

\d .
