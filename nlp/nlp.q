\d .nlp

cfg.cmd:(!). flip(
	("bus";`.nlp.sgt.nextBus);
	("pause";`.spt.put.pause);
	("resume";`.spt.put.resume);
	("devices";`.nlp.spt.devices);
	("activate";`.nlp.spt.activate);
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
	("repeat";`.nlp.spt.repeat);
	("weather";(!). flip(
			("on";`.nlp.wx.getWxByDay);
			("tomorrow";`.nlp.wx.getWxTmrw);
			("weather";`.nlp.wx.getWx)
			));
	("connection";`.par.gbl.status);
	("connected";`.par.gbl.status);
	("status";`.par.gbl.status);
	("uptime";`.nlp.utl.uptime);
	("home";`.nlp.wifi.devices);
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
	("playing";`.nlp.spt.playing);
	("reminders";(!). flip(
			("get";`.nlp.cal.rmds);
			("load";`.nlp.cal.load);
			("reload";`.nlp.cal.load);
			("reminders";`.nlp.cal.rmds)
			));
	("todo";(!). flip(
			("add";`.nlp.cal.addToDo);
			("remove";`.nlp.cal.rmToDo);
			("delete";`.nlp.cal.rmToDo);
			("todo";`.nlp.cal.toDo)
			))
	)

utl.days:("saturday";"sunday";"monday";"tuesday";"wednesday";"thursday";"friday");
utl.getCmd:{(not in[;0 11 100h]abs type@){y first key[y]inter x}[x]/cfg.cmd}
utl.runCmd:{cmd:$[0`ML;.ml.par.getCmd raze x;utl.getCmd x];$[any cmd~/:`,"s*"$\:();"Unrecognized command ",raze x;cmd x]}
utl.main:@[utl.runCmd;;{"Error running command: ",x}] -4!lower trim(),
utl.remove:{-4!trim ssr/[raze x;y;count[y]#""]}

cal.load:{$[()~.cal.utl.init[];"Found trailing commas in reminders.csv, not loading";"Success"]}
cal.rmds:{r:.cal.utl.rmds 0`reminders;$[not count r;"No reminders today";r]}
cal.toDo:{r:.cal.utl.getToDo 0`toDo;$[not count r;"Nothing to do, go fishin!";r]}
cal.addToDo:{
	x:trim raze x where not x in\:("add";"todo");
	.cal.utl.addToDo[.cal.utl.toDo;0`toDo;x];
	cal.toDo[]
	}
cal.rmToDo:{
	x:trim raze x where not x in\:("remove";"delete";"todo");
	.cal.utl.rmToDo[.cal.utl.toDo;0`toDo;x];
	cal.toDo[]
	}

spt.restart:{.spt.put.seek 0}
spt.next:{r:.spt.pst.next[];if[not"Success"~r;:r];system"sleep 2";spt.playing[]}
spt.prev:{r:.spt.pst.prev[];if[not"Success"~r;:r];system"sleep 2";spt.playing[]}
spt.rand:{r:.spt.put.rand[];if[not"Success"~r;:r];system"sleep 2";spt.playing[]}
spt.shuffle:{
	if[x~enlist"shuffle";:"Shuffle is ",("off";"on").spt.get.shuffle[]];
	.spt.put.shuffle x 2+x?"shuffle"
	}

spt.repeat:{
	d:("song";"track";"album";"playlist";"off")!("track";"track";"context";"context";"off");
	.spt.put.repeat raze d x inter key d
	}

spt.getSearchTerms:{
	x:ssr/[raze x;("song";" by ";y," ");("track";" ";"")];
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
	if[-9h<>type vol;:vol];
	vol:$[any a:all each x in .Q.n;
		$[count c:first(l:("plus";"add";"minus";"take"))inter x;
		  vol+(l!1 1 -1 -1*"J"$first x where a)c;
		  "J"$first x where a];
	      count c:first("up";"down")inter x;
		100&7h$vol*(("up";"down")!2 0.5)c;		  
		vol];
	.spt.put.vol vol;
	"Volume is at ",string[vol]," percent"
	}

spt.transfer:{
	dvc:.spt.get.devices[];if[()~dvc;:"No available devices"];
	trg:x 2+x?"to";
	if[trg~"";:"No target device specified"];
	trg:2{reverse x,"*"}/trg;
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
	if[not"Success"~r;:r];system"sleep 2";
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

spt.activate:{
	dvc:.spt.get.devices[];if[()~dvc;:"No available devices"];
	id:exec first id from dvc;
	if[id~exec first id from dvc where is_active;:"Success"];
	.spt.put.transfer id
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

utl.uptime:{"Uptime: ",string .z.p-.par.gbl.startTime}

wlf.query:{.wlf.get.short raze x}

wifi.devices:{
	i:exec item from .wifi.cfg.devices where not item like"Wifi router";
	if[not count i;:"No devices connected"];
	"Connected devices: ",", "sv i
	}

sgt.nextBus:{
	bus:x first where all each x in .Q.n;if[bus~"";bus:"65"];
	stopID:(("65";"51")!("10519";"10241"))bus;if[stopID~"";:"No stopID found for bus ",bus];
	t:string`mm$neg[.z.p+0D08:00]+"P"$2 sublist .sgt.get.nextBus[stopID;bus]`EstimatedArrival;
	"The next ",bus," bus is due in ",t[0]," minutes",$[2=count t;", subsequent bus due in ",t[1]," minutes";""]
	}

\d .
