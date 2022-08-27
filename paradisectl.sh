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

cd $PHOME
case $CMD in
	start)		./start.sh;;
	stop)		./stop.sh;;
	shutdown)	./stop.sh;;
	restart)	./stop.sh && sleep 1 && ./start.sh;;
	configure)	vi paradise.cfg;;		
	*)		if [[ ! "q)" == ${CMD:0:2} ]]
				then CMD="paradise\"$CMD\""
			fi
			$QHOME/l32/q rrc.q :$PORT -cmd "$CMD" -q;;
esac
