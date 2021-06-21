\l utils/utl.q

\d .tst

utils.cfgVars:{utl.testVars[`.utl.cfg;`enc`dec]}
utils.conVars:{utl.testVars[`.utl.con;`url`req`chk]}
utils.httpVars:{utl.testVars[`.utl.http;`get`post`pt`jk`map`dec`enc`genRH`parseRC`parseRH`parseRP`genParamStr`genEncParamStr]}

utils.pt:{
	input:("\r\n\r\n";"\r\n\r\ntext";"text";"\r\n\r\ntext\r\n\r\n";"\r\n \r\n");
	output:("";"text";"text";"text\r\n\r\n";"\r\n \r\n");
	actual:.utl.http.pt each input;
	utl.true[output~actual;
		{".utl.http.pt does not have expected output(s): expected: [",x,"], got: [",y,"]"}.", "sv/:(output;actual)@\:where not output~'actual]
	}

\d .
