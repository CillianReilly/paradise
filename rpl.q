//Replication - point at target process to emulate CLI 

if[not"-port"in .z.X;0N!"Usage:q rpl.q -port <port> [-host <host>]";exit 1]

handle:hopen`$":"sv enlist[""],first each .Q.opt[.z.x]`host`port
.z.pi:{	y:-1_y;
	if[(y~"\\\\")or y like"exit *";value y];
	show @[x;y;{"'",x}]
	}handle
