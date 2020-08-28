.p.set[`MIC;MIC]
\l nlp/mic.p

if[MIC;mic:@[.p.get`mic;;"Couldn't understand"]]
speak:.p.get`speak

run:{while[1b;text:mic[];$[10=type text;.log.out text;speak paradise text`]]}
