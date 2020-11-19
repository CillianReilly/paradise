reminders:("ds**";enlist",")0:`:calendar/reminders.csv

\l utils/utl.q
\l twilio/twl.q

\d .cal

//Could probably be refactored
utl.comp:{[fc;f;dc;d](fc in f)&{(x$/:y)~\:x$z}[;dc;d]$[f in`Y;`mm`dd;`dd]}
utl.yearlyComp:utl.comp[;`Y;;.z.d]
utl.monthlyComp:utl.comp[;`M;;.z.d]

utl.get:{?[x;enlist(y;`freq;`date);0b;()]}
utl.getYearly:utl.get[;utl.yearlyComp]
utl.getMonthly:utl.get[;utl.monthlyComp]

utl.getRmds:{raze utl[`getMonthly`getYearly]@\:0`reminders}
utl.fmtRmds:{"Reminder: ",(", "sv"'s "sv/:flip x`name`reminder)," today"}

utl.sendRmd:.twl.pst.text utl.fmtRmds utl.getRmds@

\d .
