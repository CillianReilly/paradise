#!/bin/bash

echo "Stopping mic and ngrok..."
ps -ef | grep "mic.q\|ngrok" grep -v grep | awk '{print $2}' | xargs kill -9 2>/dev/null

echo "Stopping Paradise..."
$QHOME/l32/q rrc.q -port 6000 -cmd "exit 0" -q

echo "Paradise shutdown completed"
