\d .spt
\l spotify/cfg.q

//HTTP response actions to be filled in as encountered
cfg.codes:`s#(!). flip(
	(100;{'"100 Error"});
	(200;.utl.http.jk);
	(204;{"Success"});
	(205;{'"205+ Response"});
	(300;{'"300 Error"});
	(400;{$["J"$(h:.utl.http.parseRH x)`ContentLength;.utl.http.jk[x][`error;`message];(1+h?" ")_h:h`response]});
	(500;{.utl.http.jk[x][`error;`message]})
	)

// DELETE Requests
del.req2:{utl.parseResponse del.sendReq2[x;y]}
del.sendReq2:{[ep;req]
	cfg.url"DELETE ",(1_string[cfg.url],ep)," HTTP/1.0\r\nHost: ",(9_string cfg.url),"\r\nAccept: application/json\r\nContent-Type: application/json\r\nAuthorization: Bearer ",cfg.accessToken,"\r\nContent-Length: ",string[count r],"\r\n\r\n",(r:.j.j req),"\r\n\r\n"
	}

del.deleteFromPlaylist:{del.req2["/v1/playlists/",x,"/tracks";]enlist[`uris]!(1|type[y]div 5)enlist/y}


// GET Requests
get.req:{utl.parseResponse get.sendReq x}
get.sendReq:{[ep]cfg.url"GET ",(1_string[cfg.url],ep)," HTTP/1.0\r\nAuthorization: Bearer ",cfg.accessToken,"\r\n\r\n"}

get.info:{get.req"/v1/me/player"}
get.vol:{@[get.info[].;`device`volume_percent;"No active device found"]}
get.shuffle:{@[get.info[]@;`shuffle_state;"Error, could not find active device"]}
get.devices:{r:get.req"/v1/me/player/devices";$[10=type r;r;r`devices]}
get.playing:{get.req"/v1/me/player/currently-playing"}
get.recent:{get.req"/v1/me/player/recently-played"}
get.me:{get.req"/v1/me"}
get.playlists:{get.req"/v1/me/playlists"}
get.playlistTracks:{get.req"/v1/playlists/",x,"/tracks"}
get.recommendations:{get.req"/v1/recommendations?",x}
get.followedArtists:{r:get.req"/v1/me/following?type=artist";$[10=type r;r;r`artists]}
get.artistDetails:{get.req"/v1/artists/","/"sv(x;y)}
get.top:{get.req"/v1/me/top/",x}	// 1st param is "tracks" or "artists", also accepts artists?time_range=long_term&limit=30 etc
get.search:{r:get.req"/v1/search?q=",("+"^x),"&type=","+"^y;if[10=type r;:r];r[`$y,"s";`items]}


// POST Requests
pst.req:{utl.parseResponse pst.sendReq x}
pst.sendReq:{[ep]
	cfg.url"POST ",ep," HTTP/1.0\r\nHost: ",(9_string cfg.url),"\r\nAccept: application/json\r\nContent-Type: application/json\r\nContent-Length: 0\r\nAuthorization: Bearer ",cfg.accessToken,"\r\n\r\n"
	}

pst.req2:{utl.parseResponse pst.sendReq2[x;y]}
pst.sendReq2:{[ep;req]
	cfg.url"POST ",ep," HTTP/1.0\r\nHost: ",(9_string cfg.url),"\r\nAccept: application/json\r\nContent-Type: application/json\r\nAuthorization: Bearer ",cfg.accessToken,"\r\nContent-Length: ",string[count r],"\r\n\r\n",(r:.j.j req),"\r\n\r\n"
	}

pst.sendTokenReq:{
	cfg.tokenUrl"POST /api/token HTTP/1.0\r\nHost: ",(9_string cfg.tokenUrl),"\r\nAuthorization: Basic ",cfg.auth64,"\r\nContent-Length: 170\r\nContent-Type: application/x-www-form-urlencoded\r\n\r\ngrant_type=refresh_token&refresh_token=",cfg.refreshToken,"\r\n\r\n"
	}

pst.getToken:{[]
	r:utl.parseResponse pst.sendTokenReq[];
	if[10=type r;'r];
	cfg.accessTime:.z.p;
	r`access_token
	}

pst.queue:{pst.req"/v1/me/player/queue?uri=",x}
pst.next:{pst.req"/v1/me/player/next"}
pst.prev:{pst.req"/v1/me/player/previous"}
pst.addToPlaylist:{pst.req2["/v1/playlists/",x,"/tracks";]enlist[`uris]!(1|type[y]div 5)enlist/y}
pst.createPlaylist:{pst.req2["/v1/users/",cfg.userID,"/playlists";enlist[`name]!enlist x]}


// PUT Requests
put.req:{utl.parseResponse put.sendReq x}
put.sendReq:{[ep]
	cfg.url"PUT ",(1_string[cfg.url],ep)," HTTP/1.0\r\nHost: ",(9_string cfg.url),"\r\nAccept: application/json\r\nContent-Type: application/json\r\nContent-Length: 0\r\nAuthorization: Bearer ",cfg.accessToken,"\r\n\r\n"
	}

put.req2:{utl.parseResponse put.sendReq2[x;y]}
put.sendReq2:{[ep;req]
	cfg.url"PUT ",(1_string[cfg.url],ep)," HTTP/1.0\r\nHost: ",(9_string cfg.url),"\r\nAccept: application/json\r\nContent-Type: application/json\r\nAuthorization: Bearer ",cfg.accessToken,"\r\nContent-Length: ",string[count r],"\r\n\r\n",(r:.j.j req),"\r\n\r\n"
	}

put.pause:{put.req"/v1/me/player/pause"}
put.resume:{put.req"/v1/me/player/play"}
put.vol:{put.req"/v1/me/player/volume?volume_percent=",$[10=abs type x;x;string x]}
put.shuffle:{put.req"/v1/me/player/shuffle?state=",("false";"true")$[-1h=type x;x;x in("true";"on");1b;x in("false";"off");0b;not get.info[]`shuffle_state]}
put.repeat:{put.req"/v1/me/player/repeat?state=",x}
put.transfer:{put.req2["/v1/me/player";enlist[`device_ids]!2 enlist/x]}
put.seek:{put.req"/v1/me/player/seek?position_ms=",string 1000*$[10=abs type x;"J"$x;x]}
put.playPhilCollins:{put.play["spotify:artist:4lxfqrEsLX6N1N4OCSkILp";0]}
put.playJamesBlunt:{put.play["spotify:artist:7KMqksf0UMdyA0UCf4R3ux";0]}
put.replacePlaylist:{put.req2["/v1/playlists/",x,"/tracks";]enlist[`uris]!(1|type[y]div 5)enlist/y}

put.rand:{
	r:put.shuffle rand 0b;if[not"Success"~r;:r];
	r:get.top $[x~"tracks";x;"artists"],"?time_range=",rand[("short";"medium";"long")],"_term&limit=50";
	if[10=type r;:r];
	uri:rand r[`items;`uri];
	put.play[uri;0]
	}

//Offset is position to play from i.e. track number (starts from 0)
put.play:{[uri;offset]
	t:(":"vs uri)1;
	k:$[t~"track";enlist`uris;t~"artist";enlist`context_uri;`context_uri`offset];
	d:`context_uri`uris`offset!(uri;enlist uri;enlist[`position]!enlist offset);
	put.req2["/v1/me/player/play";]k#d
	}


//Spotify specific utilities
utl.parseResponse:{cfg.codes[.utl.http.parseRC x]x}
utl.checkToken:{if[.z.p>00:59+cfg.accessTime;cfg.accessToken:pst.getToken[]]}
utl.getPlaylistUri:{r:get.playlists[];if[10=type r;:r];exec first uri from r[`items]where name like x}
utl.getRadioID:{
	r:utl.getPlaylistUri"radio";if[10=type r;:r];
	r:pst.createPlaylist"radio";if[10=type r;:r];
	r`id
	}
utl.getUri:{
	r:get.search[x;y];if[10=type r;:r];if[()~r;:"No search results"];
	r:$[`popularity in cols r;`popularity xdesc r;r];
	first $[not y~"track";
		select uri,offset:0 from r;
		select uri:album[;`uri],offset:7h$track_number-1,turi:uri from r]
	}
utl.radio:{
	r:utl.getUri[x;y];if[10=type r;:r];
	t:0<count tid:r`turi;
	p:("seed_artists";"seed_tracks")!last each":"vs/:r`uri`turi;
	p:.utl.http.genEncParamStr @[p;"limit";:;]string 100-t;
	r:get.recommendations p;if[10=type r;:r];
	u:$[t;enlist tid;()],exec uri from`popularity xdesc r`tracks;
	rid:utl.getRadioID"radio";if[not rid like"sp*";:rid];
	r:put.replacePlaylist[last":"vs rid;u];if[10=type r;:r];system"sleep 1";
	put.play[rid;0]
	}
utl.queue:{
	r:utl.getUri[x;"track"];
	if[10=type r;:r];if[()~first r;:"Couldn't get uri"];
	pst.queue r`turi
	}
utl.play:{
	r:utl.getUri[x;y];
	if[10=type r;:r];if[()~first r;:"Couldn't get uri"];
	put.play . r`uri`offset
	}

// Init
cfg.accessToken:@[pst.getToken;[];{-1"Error getting access token: ",x,"\nHave the relevant IDs been configured?";exit 1}]

s:$[not count get.devices[];
	"no devices found";
    not sum get.devices[]`is_active;
	"no active devices found";
	"playing on ",": "sv(exec from get.devices[]where is_active)`type`name]

-1"Initialised Spotify successfully, ",s;

\d .
