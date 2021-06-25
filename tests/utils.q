\l utils/utl.q

\d .tst

utils.cfgVars:{utl.testVars[`.utl.cfg;`enc`dec]}
utils.conVars:{utl.testVars[`.utl.con;`url`req`chk]}
utils.httpVars:{utl.testVars[`.utl.http;`get`post`pt`jk`map`dec`enc`genRH`parseRC`parseRH`parseRP`genParamStr`genEncParamStr]}

utils.enc:{
	utl.testOutput[`.utl.http.enc;
		("text";key .utl.cfg.enc);
		("text";raze value .utl.cfg.enc)
	]}
utils.dec:{
	utl.testOutput[`.utl.http.dec;
		("text";raze value .utl.cfg.enc);
		("text";key .utl.cfg.enc)
	]}
utils.pt:{
	utl.testOutput[`.utl.http.pt;
		("\r\n\r\n";"\r\n\r\ntext";"text";"\r\n\r\ntext\r\n\r\n";"\r\n \r\n");
		("";"text";"text";"text\r\n\r\n";"\r\n \r\n")
	]}

\d .
