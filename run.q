-1"PARADISE:Personal Assistant - Rather Adept Interface Saving Effort";

ML:0^first"J"$.Q.opt[.z.x]`ml
MIC:0^first"J"$.Q.opt[.z.x]`mic

\l p.q
\l logs/log.q
\l utils/utl.q
\l spotify/spt.q
\l twilio/twl.q
\l weather/wx.q
\l wolfram/wlf.q
\l ml/ml.q
\l nlp/nlp.q
\l nlp/mic.q

.z.ts:.spt.utl.checkToken
system"t 60000"
system"S ",string 7h$.z.t

paradise:.nlp.utl.wrap
 
if[MIC;.log.out"Starting mic";init[]]
if[ML;.ml.par.init[2000;0.001]];
