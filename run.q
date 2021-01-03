-1"PARADISE:Personal Assistant - Rather Adept Interface Saving Effort";

ML:1^first"J"$.Q.opt[.z.x]`ml
MIC:0^first"J"$.Q.opt[.z.x]`mic

\l p.q
\l logs/log.q
\l utils/utl.q
\l spotify/spt.q
\l twilio/twl.q
\l weather/wx.q
\l wolfram/wlf.q
\l calendar/cal.q
\l ml/ml.q
\l nlp/nlp.q
\l nlp/mic.q
\l init.q

.z.pp:.twl.pst.callback
.z.ts:.par.gbl.timer
system"t 60000"
system"S ",string 7h$.z.t

paradise:.nlp.utl.main

if[ML;.ml.par.init[2000;0.001]] 
if[MIC;.log.out"Starting mic";init[]]
