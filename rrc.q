if[not all("-port";"-cmd")in .z.X;0N!"Usage:q rrc.q -port <port> -cmd <cmd> [-host <host> -sync <0|1>]";exit 1]

params:.Q.opt .z.x
cmd:first params`cmd
async:any cmd like/:("*\\\\*";"*exit *")
addr:`$":"sv enlist[""],first each params`host`port

handle:(1 -1 async)*@[hopen;addr;{-1"Couldn't connect to ",string[y],": ",x;exit 1}[;addr]];

show handle cmd;if[async;handle[]]
exit 0
