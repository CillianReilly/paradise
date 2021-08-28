#!/bin/bash

PORT=$(grep PORT $PHOME/paradise.cfg | cut -d "=" -f2)

if [ $# -eq 0 ];then
	rlwrap -r $QHOME/l32/q rpl.q :$PORT
	exit 0
fi

if [ $# -ge 2 ];then
	CMD="$@"
else
	CMD=$@
fi

case $CMD in
	start)		$PHOME/start.sh;;
	stop)		$PHOME/stop.sh;;
	restart)	$PHOME/stop.sh && sleep 1 && $PHOME/start.sh;;
	configure)	vi $PHOME/paradise.cfg;;		
	*)		$QHOME/l32/q rrc.q :$PORT -cmd "paradise\"$CMD\"" -q;;
esac
