\d .utl

http.jk:{.j.k 2{reverse min[x?"{}"]_x}/x}
http.genParameters:{"&"sv"="sv/:flip(key;value)@\:where[0<>count each x]#x}
http.parseResponseCode:{"J"$x 0 1 2+first x ss"[0-9][0-9][0-9]"}
http.parseResponseHeaders:{i:where(ix:r?\:":")<count each r:"\r\n"vs(x?"{")#x;(enlist[`response]!enlist first r),(!).(`$except\:[;"-"](ix i)#';(2+ix i)_')@\:r i}

\d .
