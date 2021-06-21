\l utils/utl.q

\d .tst

utils.cfgVars:{utl.testVars[`.utl.cfg;`enc`dec]}
utils.conVars:{utl.testVars[`.utl.con;`url`req`chk]}
utils.httpVars:{utl.testVars[`.utl.http;`get`post`pt`jk`map`dec`enc`genRH`parseRC`parseRH`parseRP`genParamStr`genEncParamStr]}

\d .
