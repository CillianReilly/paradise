#!/bin/bash

if [ $# -ge 2 ];then
	echo "Commands containing a space must be wrapped in quotes"
	echo "Usage: ./$(basename $0) \"$@\""
	exit 1
fi

$QHOME/l32/q rrc.q -port 5000 -cmd "paradise\"$1\"" -q
