.p.set[`MIC;MIC]
\l nlp/mic.p

if[MIC;mic:@[.p.get`mic;;"Couldn't understand"]]
speak:.p.get`speak

run:{while[1b;text:mic[];$[10=type text;.log.out text;speak paradise text`]]}

init:{
	d:`s#0 12 17!("morning";"afternoon";"evening");
	speak"Good ",(d`hh$.z.t)," sir. The date is ",(10#first system"date")," and it is currently ",string`minute$ltime .z.p;
	run[]
	}
