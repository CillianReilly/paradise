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
        ("playing";`.nlp.spt.playing);
        ("shuffle";`.nlp.spt.shuffle);
        ("queue";`.nlp.spt.queue);
        ("radio";`.nlp.spt.radio);
        ("weather";`.nlp.wx.getWx)
        )

wrap:{$[count x ss" and ";
		.z.s each" and "vs x;
	()~c:first(x:lower -4!x)inter key cfg.cmd;
		"Unrecognized command ",raze x;
		cfg.cmd[c]x]
	}

spt.shuffle:{.spt.put.shuffle x 2+x?"shuffle"}
spt.restart:{.spt.put.seek 0}
spt.next:{r:.spt.pst.next[];if[not"Success"~r;:r];system"sleep 1";spt.playing[]}
spt.prev:{r:.spt.pst.prev[];if[not"Success"~r;:r];system"sleep 1";spt.playing[]}
spt.rand:{r:.spt.put.rand[];if[not"Success"~r;:r];system"sleep 1";spt.playing[]}

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
        $[c:count r;
                "Device",$[1=c;"";"s"]," ",(","sv r`type)," ",$[1=c;"is";"are"]," currently available";
                "No devices currently available"]
        }

wx.getWx:{
        r:.wx.utl.getWx raze(2+x?"in")_x;if[10=type r;:r];
        c:r`currently;h:r`hourly;
        "Currently ",ssr[lower c`summary;" and ";", "]," and temperatures of ",string[.wx.utl.F2C c`temperature]," degrees. The forecast is ",(-1_h`summary),", temperatures between ",(" and "sv string .wx.utl.F2C(min;max)@\:h[`data;;`temperature])," degrees."
        }

\d .
