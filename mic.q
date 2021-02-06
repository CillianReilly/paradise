\l p.q
\l mic.p
\l logs/log.q

h:@[hopen;5000;{.log.err"Couldn't connect to Paradise, exiting...";exit 1}];

mic:@[.p.get`mic;;"Couldn't understand"]
speak:.p.get`speak

run:{
	text:mic[];
	$[10=type text;
		.log.out text;
		speak first x(`.nlp.utl.main;text`)]
	}

init:{
	d:`s#0 12 17!("morning";"afternoon";"evening");
	speak"Good ",(d`hh$t)," sir. The date is ",(10#first system"date")," and it is currently ",(string`minute$t:ltime .z.p)," GMT";
	while[1b;@[run;x;{.log.err"Error running: ",x}]]
	}

.log.out"Starting mic"
init h
