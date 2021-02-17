#!/bin/bash

echo "Starting paradise..."
$QHOME/l32/q paradise.q -p 5000 -cli 0 -ml 1 2>&1 >logs/paradise.log &

echo "Starting mic..."
$QHOME/l32/q mic.q -cli 0 2>&1 >logs/mic.log &

echo "Starting ngrok server..."
$NGROK_HOME/ngrok http -subdomain=paradise 5000 2>&1 >/dev/null &

echo "Started"
exit 0
