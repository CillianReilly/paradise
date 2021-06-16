#!/bin/bash

PORT=$(grep PORT $PHOME/paradise.cfg | cut -d "=" -f2)

if [ $# -eq 0 ];then
	rlwrap -r $QHOME/l32/q $PHOME/rpl.q -port $PORT
	exit 0
fi

if [ $# -ge 2 ];then
	CMD="$@"
else
	CMD=$@
fi

case $CMD in
	start)	  $PHOME/start.sh;;
	stop)	  $PHOME/stop.sh;;
	restart)  $PHOME/stop.sh && sleep 1 && ./start.sh;;
	*)	  $QHOME/l32/q $PHOME/rrc.q -port $PORT -cmd "paradise\"$CMD\"" -q;;
esac
