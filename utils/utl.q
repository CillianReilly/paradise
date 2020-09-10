\d .utl

http.get:{x@"GET ",y," HTTP/1.1\r\nHost: ",(9_string x),"\r\n\r\n"}

http.genParamStr:{"?","&"sv"="sv/:flip{@[x;where -10=type each x;1#]}each(key;value)@\:where[0<>count each x]#x}
http.jk:{.j.k 2{reverse min[x?"{}"]_x}/x}
http.parseResponseCode:{"J"$x 0 1 2+first x ss"[0-9][0-9][0-9]"}
http.parseResponseHeaders:{i:where(ix:r?\:":")<count each r:"\r\n"vs(x?"{")#x;(enlist[`response]!enlist first r),(!).(`$except\:[;"-"](ix i)#';(2+ix i)_')@\:r i}

con.url:`:https://www.howsmyssl.com
con.req:http.get[con.url;]"/a/check"@
con.chk:http.parseResponseCode con.req@

c:con.chk[]
-1"Internet connection",$[200=c;"";"not"]," ok: response code was ",string c;

\d .
