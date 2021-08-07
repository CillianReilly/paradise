-1"PARADISE: Personal Assistant - Rather ADept Interface Saving Effort";

ML:1^first"J"$.Q.opt[.z.x]`ml

\l logs/log.q
\l utils/utl.q
\l spotify/spt.q
\l twilio/twl.q
\l weather/wx.q
\l wolfram/wlf.q
\l calendar/cal.q
\l wifi/wifi.q
\l ml/ml.q
\l nlp/nlp.q
\l init.q

paradise:.nlp.utl.main

if[ML;.ml.par.init[2000;0.001]]
.log.out"Paradise start up complete" 
