#!/bin/bash

PORT=$(grep PORT paradise.cfg | cut -d "=" -f2)

if [ $# -eq 0 ];then
        rlwrap -r $QHOME/l32/q rpl.q -port $PORT
        exit 0
fi

if [ $# -ge 2 ];then
	CMD="$@"
else
	CMD=$@
fi

case $CMD in
	start)	  ./start.sh;;
	stop)	  ./stop.sh;;
	restart)  ./stop.sh && sleep 1 && ./start.sh;;
	*)	  $QHOME/l32/q rrc.q -port $PORT -cmd "paradise\"$CMD\"" -q;;
esac
