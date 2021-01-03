#!/bin/bash

echo "Starting paradise..."
$QHOME/l32/q run.q -p 5000 -cli 0 -ml 1 2>&1 >logs/paradise.log &

echo "Starting mic..."
$QHOME/l32/q mic.q -cli 0 2>&1 >logs/paradise.log &

echo "Starting ngrok server..."
/home/pi/Downloads/ngrok http -subdomain=paradise 5000 2>&1 >/dev/null &

echo "Started"
exit 0
