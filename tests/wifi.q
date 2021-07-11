\l wifi/wifi.q

\d .tst

wifi.cfgVars:{utl.testVars[`.wifi.cfg;`devices`knownMAC]}
wifi.utlVars:{utl.testVars[`.wifi.utl;`parseMAC`parseBrkt`parseItem`nmap`ifc`getDevices`logNew`logOld`updDevices]}

wifi.parseMAC:{
	utl.testOutput[`.wifi.utl.parseMAC;
		("text";"text: mac";"text: mac mac");
		``mac`mac
	]}

wifi.parseBrkt:{
	utl.testOutput[`.wifi.utl.parseBrkt;
		("text";"(text)";"foo(text)bar";"(text";"text)";"()");
		("";"text";"text";"";"";"")
	]}

\d .
