-1"PARADISE:Personal Assistant - Rather Adept Interface Saving Effort";

MIC:0^first"J"$.Q.opt[.z.x]`mic

\l p.q
\l logs/log.q
\l utils/utl.q
\l spotify/spt.q
\l weather/wx.q
\l nlp/nlp.q
\l nlp/mic.q

.z.ts:.spt.utl.checkToken
system"t 60000"
system"S ",string 7h$.z.t

paradise:.nlp.utl.wrap
 
if[MIC;.log.out"Starting mic";init[]]
