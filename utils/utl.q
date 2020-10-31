\d .utl

cfg.enc:("+";" ")!("%2B";"+")

http.get:{x@"GET ",y," HTTP/1.1\r\nHost: ",(9_string x),"\r\n\r\n"}
http.post:{[url;ep;rh;req]
	url"POST ",ep," HTTP/1.1\r\nHost: ",(9_string url),"\r\n",
	rh,"\r\n\r\n",
	req,"\r\n\r\n"
	}

http.pt:{(4+first x ss"\r\n\r\n")_x}
http.jk:{.j.k 2{reverse min[x?"{}"]_x}/x}
http.enc:raze ssr/[;key cfg.enc;value cfg.enc]@
http.genRH:"\r\n"sv(,').(key;value)@\:
http.parseRC:{"J"$x 0 1 2+first x ss"[0-9][0-9][0-9]"}
http.parseRH:{(!).(`code;http.parseRC x),'(`$except\:[;"-"]@;::)@'flip((0,'i+/:(s?\:":"))_'s:1_r:d vs(x ss d,d:"\r\n")#x)@\:i:0 2}
http.genParamStr:{"?","&"sv"="sv/:flip{@[x;where -10=type each x;1#]}each(key;value)@\:where[0<>count each x]#x}
http.genEncParamStr:http.enc http.genParamStr@

con.url:`:https://www.howsmyssl.com
con.req:http.get[con.url;]"/a/check"@
con.chk:http.parseRC con.req@

c:con.chk[]
-1"Internet connection",$[200=c;"";" not"]," ok: response code was ",string c;

\d .
