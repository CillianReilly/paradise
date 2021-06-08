#!/bin/bash

echo "Setting environment variables from paradise.cfg..."
PORT=$(grep PORT paradise.cfg | cut -d "=" -f2)

echo "Stopping mic and ngrok..."
ps -ef | grep "mic.q\|ngrok" | grep $PORT | awk '{print $2}' | xargs --no-run-if-empty kill -9

echo "Stopping Paradise..."
$QHOME/l32/q rrc.q -port $PORT -cmd "exit 0" -q

echo "Paradise shutdown completed"
