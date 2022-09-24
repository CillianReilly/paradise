\d .sgt
\l transport/cfg.q


utl.parseResponse:{utl.codes[.utl.http.parseRC x]x}

get.sendReq:.utl.http.get[cfg.url;;.utl.http.genRH enlist["accountKey: "]!enlist cfg.key]
get.req:utl.parseResponse get.sendReq@
get.nextBus:{
	r:get.req[cfg.endpoint,"?BusStopCode=",x,"&ServiceNo=",y]`Services;
	raze r{x where x like"NextBus*"}cols r
	}

//HTTP response actions to be filled in as encountered
utl.codes:`s#(!). flip(
        (100;{'"100 Error"});
        (200;.utl.http.jk);
	(201;{'"200 Error"});
        (300;{'"300 Error"});
        (400;{'"400 Error"});
        (401;{'"401 Error"});
        (500;{'"500 Error"})
        )

\d .
