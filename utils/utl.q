\d .utl

con.url:`:https://www.howsmyssl.com
con.req:{con.url"GET /a/check HTTP/1.1\r\nHost: ",(9_string con.url),"\r\n\r\n"}
con.chk:{c:http.parseResponseCode con.req[];$[c=200;"Internet connection ok";"Not connected, response code was ",string c]}

http.jk:{.j.k 2{reverse min[x?"{}"]_x}/x}
http.genParameters:{"&"sv"="sv/:flip(key;value)@\:where[0<>count each x]#x}
http.parseResponseCode:{"J"$x 0 1 2+first x ss"[0-9][0-9][0-9]"}
http.parseResponseHeaders:{i:where(ix:r?\:":")<count each r:"\r\n"vs(x?"{")#x;(enlist[`response]!enlist first r),(!).(`$except\:[;"-"](ix i)#';(2+ix i)_')@\:r i}

\d .
