-1"PARADISE:Personal Assistant - Rather Adept Interface Saving Effort";

\l logs/log.q
\l utils/utl.q
\l nlp/nlp.q
\l spotify/spt.q
\l weather/wx.q

.z.ts:.spt.utl.checkToken
system"t 60000"
system"S ",string 7h$.z.t

paradise:.nlp.wrap
