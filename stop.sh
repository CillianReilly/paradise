#!/bin/bash

read -p "Are you sure you want to shutdown Paradise? Enter Y to proceed: " SHUTDOWN
if [[ ! "$SHUTDOWN" == [Yy] ]];then
	echo "Shutdown not confirmed, attempt aborted"
	exit 1
fi

echo "Setting environment variables from paradise.cfg..."
PORT=$(grep PORT $PHOME/paradise.cfg | cut -d "=" -f2)

echo "Stopping mic..."
ps -ef | grep "mic.q" | grep $PORT | awk '{print $2}' | xargs --no-run-if-empty kill -9

echo "Stopping Paradise..."
$QHOME/l32/q rrc.q :$PORT -cmd "exit 0" -q

echo "Paradise shutdown completed"
