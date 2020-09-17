\d .wlf
\l wolfram/cfg.q

utl.genParamDict:(enlist["appid"]!enlist cfg.appID)upsert
utl.genFullParamDict:utl.genParamDict("output";"input")!("json";)@
utl.genShortParamDict:utl.genParamDict(2 enlist/"i")!enlist@
utl.genFullParamStr:.utl.http.genParamStr utl.genFullParamDict@
utl.genShortParamStr:.utl.http.genParamStr utl.genShortParamDict@
utl.parseResponse:{utl.codes[.utl.http.parseRC x]x}

get.sendReq:.utl.http.get[cfg.url;]
get.req:utl.parseResponse get.sendReq@
get.short:get.req"/v1/result",utl.genShortParamStr@
get.spoken:get.req"/v1/spoken",utl.genShortParamStr@
get.conversation:get.req"/v1/conversation.jsp",utl.genShortParamStr@
get.full:@[;`queryresult]get.req"/v2/query",utl.genFullParamStr@

//HTTP response actions to be filled in as encountered
utl.codes:`s#(!). flip(
	(100;{'"100 Error"});
	(200;{(.utl.http`pt`jk all"{}"in x)x});
	(201;{'"201 Error"});
	(300;{'"300 Error"});
	(400;.utl.http.pt);
	(401;{'"401 Error"});
	(500;{'"500 Error"});
	(501;.utl.http.pt);
	(502;{'"502 Error"})
	)

\d .
