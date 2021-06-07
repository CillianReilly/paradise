#!/bin/bash

if [ $# -ge 2 ];then
	echo "Commands containing a space must be wrapped in quotes"
	echo "Usage: ./$(basename $0) \"$@\""
	exit 1
fi

PORT=$(grep PORT paradise.cfg | cut -d "=" -f2)

if [ $# -eq 0 ];then
	rlwrap -r $QHOME/l32/q rpl.q -port $PORT
	exit 0
fi

case $1 in
	start)	./start.sh;;
	stop)	./stop.sh;;
	*)	$QHOME/l32/q rrc.q -port $PORT -cmd "paradise\"$1\"" -q;;
esac
