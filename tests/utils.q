\l utils/utl.q

\d .tst

utils.cfgVars:{utl.testVars[`.utl.cfg;`enc`dec]}
utils.conVars:{utl.testVars[`.utl.con;`url`req`chk]}
utils.httpVars:{utl.testVars[`.utl.http;`get`post`pt`jk`map`dec`enc`genRH`parseRC`parseRH`parseRP`genParamStr`genEncParamStr]}

utils.pt:{utl.testOutput[`.utl.http.pt;("\r\n\r\n";"\r\n\r\ntext";"text";"\r\n\r\ntext\r\n\r\n";"\r\n \r\n");("";"text";"text";"text\r\n\r\n";"\r\n \r\n")]}

\d .
