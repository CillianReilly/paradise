#!/bin/bash

echo "Setting environment variables from paradise.cfg..."
PORT=$(grep PORT $PHOME/paradise.cfg | cut -d "=" -f2)
CLI=$(grep CLI $PHOME/paradise.cfg | cut -d "=" -f2)
MIC=$(grep MIC $PHOME/paradise.cfg | cut -d "=" -f2)
ML=$(grep ML $PHOME/paradise.cfg | cut -d "=" -f2)

echo "Starting paradise..."
$QHOME/l32/q $PHOME/paradise.q -p $PORT -cli $CLI -ml $ML 2>&1 >$PHOME/logs/paradise.log &

echo "Starting ngrok server..."
$NGROK_HOME/ngrok http --region=us --hostname=paradise.ngrok.io $PORT 2>&1 >/dev/null &

if [ $MIC ];then
	echo "Starting mic..."
	$QHOME/l32/q $PHOME/audio/mic.q -port $PORT -cli $CLI 2>&1 >$PHOME/logs/mic.log &
fi

echo "Paradise processes started"
exit 0
