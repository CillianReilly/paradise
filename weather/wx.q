\d .wx
\l weather/cfg.q

//DarkSky
ds.req:{utl.parseResponse ds.sendReq x}
ds.sendReq:{ds.cfg.url"GET /forecast/",ds.cfg.key,"/",(","sv string x`lat`lng)," HTTP/1.1\r\nHost: ",(9_string ds.cfg.url),"\r\n\r\n"}

//OpenCage
oc.req:{utl.parseResponse oc.sendReq x}
oc.sendReq:{oc.cfg.url"GET /geocode/v1/json?q=",x,"&key=",oc.cfg.key,"&limit=1&no_annotations=1 HTTP/1.1\r\nHost: ",(9_string oc.cfg.url),"\r\n\r\n"}
oc.getGeo:{r:oc.req["+"^x];if[10=type r;:r];exec first geometry from`confidence xdesc r`results}

//Weather utilities
utl.F2C:{7h$(5%9)*x-32}
utl.parseResponse:{utl.codes[.utl.http.parseResponseCode x]x}
utl.getWx:{r:oc.getGeo x;if[10=type r;:r];ds.req r}

//HTTP response actions to be filled in as encountered
utl.codes:`s#(!). flip(
	(100;{'"100 Error"});
	(200;.utl.http.jk);
	(204;{'"204 Error"});
	(300;{'"300 Error"});
	(400;{(1+r?" ")_r:.utl.http.parseResponseHeaders[x]`response});
	(402;{'"402 Error"});
	(500;{'"500 Error"})
	)

\d .
