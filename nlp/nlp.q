\d .nlp

cfg.cmd:(!). flip(
	("pause";`.spt.put.pause);
	("resume";`.spt.put.resume);
	("devices";`.nlp.spt.devices);
	("volume";`.nlp.spt.vol);
	("random";`.nlp.spt.rand);
	("surprise";`.nlp.spt.rand);
	("next";`.nlp.spt.next);
	("previous";`.nlp.spt.prev);
	("play";`.nlp.spt.play);
	("restart";`.nlp.spt.restart);
	("transfer";`.nlp.spt.transfer);
	("shuffle";`.nlp.spt.shuffle);
	("queue";`.nlp.spt.queue);
	("radio";`.nlp.spt.radio);
	("weather";(!). flip(
			("on";`.nlp.wx.getWxByDay);
			("tomorrow";`.nlp.wx.getWxTmrw);
			("weather";`.nlp.wx.getWx)
			));
	("connection";`.nlp.utl.con);
	("connected";`.nlp.utl.con);
	("status";`.nlp.utl.con);
	("who";`.nlp.wlf.query);
	("what";`.nlp.wlf.query);
	("when";`.nlp.wlf.query);
	("where";`.nlp.wlf.query);
	("why";`.nlp.wlf.query);
	("playlist";(!). flip(
			("add";(!). flip(
					("new";`.nlp.spt.createPlaylist);
					("to";`.nlp.spt.addToPlaylist)
					));
			("make";`.nlp.spt.createPlaylist);
			("create";`.nlp.spt.createPlaylist)
			));
	("playing";`.nlp.spt.playing)
	)

utl.days:("saturday";"sunday";"monday";"tuesday";"wednesday";"thursday";"friday");
utl.getCmd:{(not in[;0 11 100h]abs type@){y first key[y]inter x}[x]/cfg.cmd}
utl.runCmd:{cmd:utl.getCmd x;$[any cmd~/:"s*"$\:();"Unrecognized command ",raze x;cmd x]}
utl.wrap:utl.runCmd each -4!/:" and "vs lower trim@
utl.remove:{-4!trim ssr/[raze x;y;count[y]#""]}

spt.restart:{.spt.put.seek 0}
spt.next:{r:.spt.pst.next[];if[not"Success"~r;:r];system"sleep 1";spt.playing[]}
spt.prev:{r:.spt.pst.prev[];if[not"Success"~r;:r];system"sleep 1";spt.playing[]}
spt.rand:{r:.spt.put.rand[];if[not"Success"~r;:r];system"sleep 1";spt.playing[]}
spt.shuffle:{
	if[x~enlist"shuffle";:"Shuffle is ",("off";"on").spt.get.shuffle[]];
	.spt.put.shuffle x 2+x?"shuffle"
	}

spt.getSearchTerms:{
	x:ssr/[raze x;(" by ";y," ");(" ";"")];
	t:("album";"artist";"playlist";"track");
	x:{@[x;count[y]+x ss y;:;":"]}/[x;t];
	t:(x?":")#x;
	(x;t)
	}

spt.playing:{
	r:.spt.get.playing[];
	if[10=type r;:r];
	"Playing ",r[`item;`name]," by ",first r[`item;`artists;`name]
	}

spt.vol:{
	vol:.spt.get.vol[];
	if[x~enlist"volume";:"Volume is at ",string[vol]," percent"];
	vol:$[any a:all each x in .Q.n;
		first x where a;
	      count c:first("up";"down")inter x;
		100&7h$vol*(("up";"down")!2 0.5)c;
		vol];
	.spt.put.vol vol
	}

spt.transfer:{
	dvc:.spt.get.devices[];if[()~dvc;:"No available devices"];
	trg:2{reverse x,"*"}/x 2+x?"to";
	id:?[dvc;enlist(like;(lower;`type);trg);();(first;`id)];
	if[not count id;:"Couldn't find device ID"];
	if[id~exec first id from dvc where is_active;:"Success"];
	.spt.put.transfer id
	}

spt.queue:{.spt.utl.queue first spt.getSearchTerms[x;"queue"]}
spt.radio:{.spt.utl.radio . spt.getSearchTerms[x;"radio"]}
spt.play:{
	if[x~enlist"play";:.spt.put.resume[]];
	r:.spt.utl.play . spt.getSearchTerms[x;"play"];
	if[not"Success"~r;:r];system"sleep 1";
	spt.playing[]
	}

spt.devices:{
	r:.spt.get.devices[];if[10=type r;:r];
	if[not count r;:"No devices currently available"];
	a:select from r where is_active;r:r except a;
	f:{$[x;" "sv(", "sv y`type;$[x=1;"is";"are"];"currently";z);""]};
	o:f'[count each(a;r);(a;r);("active";"available")];
	", "sv o where not 0=count each o
	}

spt.createPlaylist:{
	n:(2+max except[;count x]x?/:("playlist";"name"))_x;
	n:raze @'[n;0;:;upper first each n];
	r:.spt.pst.createPlaylist n;
	$[10=type r;r;"Success"]
	}

spt.addToPlaylist:{
	n:raze utl.remove[(2+max where x~\:"to")_x;enlist"playlist"];
	r:.spt.get.playlists[];if[10=type r;:r];
	pid:exec first id from r[`items]where lower[name]like n;
	uris:.spt.get.playlistTracks[pid][`items;`track]`uri;
	t:spt.getSearchTerms[;"add"]raze(-1+max where x~\:"to")#x;
	u:$[any first[t]like/:("*this*";"*playing*";"*currently*");
		[r:.spt.get.playing[];if[10=type r;:r];r[`item;`uri]];
		[r:.spt.utl.getUri . t;if[10=type r;:r];r`turi]];
	if[u in uris;:"Track already included in playlist ",n];
	r:.spt.pst.addToPlaylist[pid;u];
	$[10=type r;r;"Success"]
	}

wx.getWx:{
	r:.wx.utl.getWx raze(2+x?"in")_x;if[10=type r;:r];
	c:r`currently;h:r`hourly;
	"Currently ",ssr[lower c`summary;" and ";", "]," and temperatures of ",string[7h$c`temperature]," degrees. The forecast is ",(-1_h`summary),", temperatures between ",(" and "sv string 7h$(min;max)@\:h[`data;;`temperature])," degrees."
	}

wx.getForecast:{x,"'s forecast is ",(-1_y`summary),", temperatures between ",(" and "sv string 7h$y`temperatureLow`temperatureHigh)," degrees, and ",string[7h$100*y`precipProbability]," percent chance of rain."}

wx.getWxTmrw:{
        r:.wx.utl.getWx raze(2+x?"in")_utl.remove[x;"tomorrow"];if[10=type r;:r];
        wx.getForecast["Tomorrow";]r[`daily;`data;2]
        }

wx.getWxByDay:{
	d:first x inter utl.days;
	r:.wx.utl.getWx raze(2+x?"in")_utl.remove[x;("on";d)];if[10=type r;:r];
	wx.getForecast[d;]r[`daily;`data]1+((.z.d mod 7)rotate utl.days)?d
	}

utl.con:{c:.utl.con.chk[];$[c=200;"Internet connection ok";"Not connected, response code was ",string c]}

wlf.query:.wlf.get.short raze@

\d .
