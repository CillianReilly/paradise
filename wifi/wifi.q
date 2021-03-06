\d .wifi
\l wifi/cfg.q

utl.parseMAC:{`$first" "vs(2+x?":")_x}
utl.parseBrkt:{2{reverse min[1+x?"()"]_x}/x}
utl.parseItem:{cfg.knownMAC utl.parseMAC x}

utl.nmap:{
	cmd:"sudo nmap -F ",x,".0/",string y;
	nmap:@[system;cmd;{enlist"Error running nmap: ",x}];
	if[first[nmap]like"Error*";.log.err nmap;:()]
	nmap
	}

utl.ifc:{
	cmd:"ifconfig | grep wlan0 -A 1 | grep netmask";
	ifc:@[system;cmd;{enlist"Error running ifconfig: ",x}];
	if[first[ifc]like"Error*";.log.err ifc;:()];
	(!). flip" "vs/:"  "vs trim first ifc
	}

utl.getDevices:{
	ifc:utl.ifc[];
	if[not count ifc;.log.err"Couldn't find inet and nmask";:()];

	mask:24*sum 0="J"$"."vs ifc"netmask";
	inet:"."sv(neg mask div 24)_"."vs ifc"inet";
	nmap:utl.nmap[inet;mask];
	if[not count nmap;.log.err"Couldn't find nmap results";:()];

	mac:nmap where nmap like"MAC Address*";
	if[not count mac;.log.err"Couldn't find any MAC addresses";:()];

	mac:utl[`parseMAC`parseBrkt`parseItem]@\:/:mac;
	mac:update lastActive:.z.p from flip`MAC`name`item!flip mac;
	`MAC xkey update item:name from mac where 0=count each item
	}

utl.logNew:{
	.log.out"New MAC registered: ",string x;
	.log.out $[""~i:cfg.knownMAC[x];"Unknown item";i]," has connected to the wifi";
	}

utl.logOld:{
	.log.out"MAC unregistered: ",string x;
	.log.out $[""~i:cfg.knownMAC[x];"Unknown item";i]," has disconnected from the wifi";
	}

utl.updDevices:{
	dcv:utl.getDevices[];

	new:exec MAC from dcv;
	old:exec MAC from cfg.devices where not MAC in new,9<`minute$.z.p-lastActive;	

	utl.logNew each new except exec MAC from cfg.devices;
	utl.logOld each old;

	cfg.devices:upsert[;dcv]delete from cfg.devices where MAC in old;
	}

\d .
