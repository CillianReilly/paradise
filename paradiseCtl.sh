#!/bin/bash

if [ -z $1 ];then
	echo "Usage: ./$(basename $0) cmd"
	exit 1
fi

if [ $# -ge 2 ];then
	echo "Commands containing a space must be wrapped in quotes"
	echo "Usage: ./$(basename $0) \"$@\""
	exit 1
fi

echo "Setting environment variables from paradise.cfg..."
PORT=$(grep PORT paradise.cfg | cut -d "=" -f2)

$QHOME/l32/q rrc.q -port $PORT -cmd "paradise\"$1\"" -q
