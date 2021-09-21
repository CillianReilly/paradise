\l p.q
\l audio/mic.p
\l logs/log.q

paradise:first"J"$.Q.opt[.z.x]`port
loadMic:.p.get`loadMic
mic:@[.p.get`mic;;"Couldn't understand"]
speak:.p.get`speak

run:{
	text:mic[];
	if[10=type text;.log.out text;:()];
	.log.out text`;
	.log.out r:x(`.nlp.utl.main;text`);
	speak r
	}

init:{
	.log.out"Starting mic";
	h:@[hopen;x;{.log.err"Couldn't connect to Paradise, exiting...";exit 1}];
	if[1=loadMic[]`;.log.err"Mic not available: either not connected or already in use";exit 1];	
	
	d:`s#0 12 17!("morning";"afternoon";"evening");
	speak"Good ",(d`hh$t)," sir. The date is ",(10#first system"date")," and it is currently ",(string`minute$t:ltime .z.p)," GMT";
	while[1b;@[run;h;{.log.err"Error running: ",x}]]
	}

init[paradise]
