\d .twl
\l twilio/cfg.q

cfg.auth:.utl.enc.base64 ":" sv cfg`sID`token

utl.genBodyDict:("Body";"From";"To")!(;cfg.from;cfg.to)@
utl.genBody:.utl.http.genEncParamStr utl.genBodyDict@
utl.genReqDict:("Authorization: Basic ";"Content-Length: ";"Content-Type: ")!(cfg.auth;;"application/x-www-form-urlencoded")@
utl.genResDict:{("HTTP/1.1 ";"content-type: ";"content-length: ";"";"")!("200";"application/xml";string count x;"";x)}
utl.genReq:.utl.http.genRH utl.genReqDict@
utl.genRes:.utl.http.genRH utl.genResDict@
utl.parseResponse:{utl.codes[.utl.http.parseRC x]x}
utl.genTwiML:{"<?xml version=\"1.0\" encoding=\"UTF-8\"?><Response><Message>",x,"</Message></Response>"}

pst.sendReq:{.utl.http.post[cfg.url;x;utl.genReq string count y;]y:utl.genBody y}
pst.req:{utl.parseResponse pst.sendReq[x;y]}
pst.text:pst.req["/2010-04-01/Accounts/",cfg.sID,"/Messages.json";]
pst.callback:{
	b:.utl.http.dec .utl.http.parseRP[x 0]`Body;
	r:$["q)"~2#b;.Q.s1 value b;.nlp.utl.main b];
	r:utl.genTwiML ssr[r;" & ";" and "];
	utl.genRes r
	}

//HTTP response actions to be filled in as encountered
utl.codes:`s#(!). flip(
	(100;{'"100 Error"});
	(200;{'"200 Error"});
	(201;{"Success"});
	(202;{'"202 Error"});
	(300;{'"300 Error"});
 	(400;{.utl.http.jk[x]`message});
	(401;{'"401 Error"});
	(500;{'"500 Error"})
        )

\d .
