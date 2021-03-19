\d .wifi
\l wifi/cfg.q

utl.parseMAC:{`$first" "vs(2+x?":")_x}
utl.parseBrkt:{2{reverse min[1+x?"()"]_x}/x}
utl.parseItem:{cfg.knownMAC utl.parseMAC x}

utl.nmap:{
	/This doesn't pick up Pi
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
	flip`MAC`name`item!flip mac
	}

utl.logNew:{
	.log.out"New MAC registered: ",string x`MAC;
	.log.out x[`item]," has connected to the wifi";
	}

utl.logOld:{
	.log.out"MAC unregistered: ",string x`MAC;
	.log.out x[`item]," has disconnected from the wifi";
	}

utl.updDevices:{
        dcv:utl.getDevices[];

        utl.logNew each dcv except cfg.devices;
        utl.logOld each cfg.devices except dcv;

        cfg.devices:dcv
        }

cfg.devices:utl.getDevices[]

\d .
