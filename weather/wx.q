\d .wx
\l weather/cfg.q

//Weather utilities
utl.parseResponse:{utl.codes[.utl.http.parseRC x]x}
utl.getWx:{r:oc.getGeo x;if[10=type r;:r];ds.req r}

//DarkSky
ds.genParamDict:enlist["units"]!enlist"si"
ds.genParamStr:.utl.http.genParamStr ds.genParamDict
ds.genEndPoint:"/"sv("";"forecast";ds.cfg.key;)","sv string@[;`lat`lng]@
ds.sendReq:.utl.http.get[ds.cfg.url;] ,[;ds.genParamStr[]]ds.genEndPoint@
ds.req:utl.parseResponse ds.sendReq@

//OpenCage
oc.genParamDict:("q";"key";"limit";"no_annotations")!(;oc.cfg.key;"1";"1")@
oc.genParamStr:.utl.http.genParamStr oc.genParamDict@
oc.genEndPoint:"/geocode/v1/json"
oc.sendReq:.utl.http.get[oc.cfg.url;]oc.genEndPoint[],oc.genParamStr@
oc.req:utl.parseResponse oc.sendReq@
oc.getGeo:{
	r:oc.req x;
	if[10=type r;:r];if[()~r`results;:"No results found for ",x];
	exec first geometry from`confidence xdesc r`results
	}

//HTTP response actions to be filled in as encountered
utl.codes:`s#(!). flip(
	(100;{'"100 Error"});
	(200;.utl.http.jk);
	(204;{'"204 Error"});
	(300;{'"300 Error"});
	(400;{(1+r?" ")_r:.utl.http.parseRH[x]`response});
	(401;{'"401 Error"});
	(500;{'"500 Error"})
	)

\d .
