if[not all("-port";"-cmd")in .z.X;0N!"Usage:q rrc.q -port <port> -cmd <cmd> [-host <host> -async ]";exit 1]

params:.Q.opt .z.x
cmd:first params`cmd
addr:`$":"sv enlist[""],first each params`host`port
async:(`async in key params)or any cmd like/:("*\\\\*";"*exit *")

handle:(1 -1 async)*@[hopen;addr;{-1"Couldn't connect to ",string[y],": ",x;exit 1}[;addr]];

show handle cmd;if[async;handle[]]
exit 0
