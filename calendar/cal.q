reminders:("ds**";enlist",")0:`:calendar/reminders.csv

\d .cal

utl.comp:{[fc;f;dc;d](fc in f)&{(x$/:y)~\:x$z}[;dc;d]$[f in`Y;`mm`dd;f in`M;`dd;`date]}
utl.yearlyComp:utl.comp[;`Y;;]
utl.monthlyComp:utl.comp[;`M;;]
utl.onceOffComp:utl.comp[;`O;;]

utl.sel:{?[x;enlist(y;`freq;`date;.z.d);0b;()]}
utl.getYearly:utl.sel[;utl.yearlyComp]
utl.getMonthly:utl.sel[;utl.monthlyComp]
utl.getOnceOff:utl.sel[;utl.onceOffComp]

utl.getRmds:{raze utl[`getOnceOff`getMonthly`getYearly]@\:0`reminders}
utl.fmtRmds:{"Reminder: ",(", "sv"'s "sv/:flip x`name`reminder)," today"}

utl.rmds:{r:utl.getRmds[];if[not count r;:()];utl.fmtRmds r}
utl.sendRmd:{r:utl.rmds[];if[not count r;:"No reminders today"];.twl.pst.text r}

\d .
