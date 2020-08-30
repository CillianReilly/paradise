.p.set[`MIC;MIC]
\l nlp/mic.p

if[MIC;mic:@[.p.get`mic;;"Couldn't understand"]]
speak:.p.get`speak

run:{text:mic[];$[10=type text;.log.out text;speak paradise text`]}

init:{
	d:`s#0 12 17!("morning";"afternoon";"evening");
	speak"Good ",(d`hh$t)," sir. The date is ",(10#first system"date")," and it is currently ",string`minute$t:ltime .z.p;
	while[1b;@[run;[];{.log.err"Error running: ",x}]]
	}
