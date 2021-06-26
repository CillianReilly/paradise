\l wifi/wifi.q

\d .tst

wifi.cfgVars:{utl.testVars[`.wifi.cfg;`devices`knownMAC]}
wifi.utlVars:{utl.testVars[`.wifi.utl;`parseMAC`parseBrkt`parseItem`nmap`ifc`getDevices`logNew`logOld`updDevices]}

\d .
