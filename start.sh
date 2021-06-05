#!/bin/bash

echo "Setting environment variables from paradise.cfg..."
PORT=$(grep PORT paradise.cfg | cut -d "=" -f2)
CLI=$(grep CLI paradise.cfg | cut -d "=" -f2)
ML=$(grep ML paradise.cfg | cut -d "=" -f2)

echo "Starting paradise..."
$QHOME/l32/q paradise.q -p $PORT -cli $CLI -ml $ML 2>&1 >logs/paradise.log &

echo "Starting mic..."
$QHOME/l32/q mic.q -port $PORT -cli $CLI 2>&1 >logs/mic.log &

echo "Starting ngrok server..."
$NGROK_HOME/ngrok http -subdomain=paradise $PORT 2>&1 >/dev/null &

echo "Started"
exit 0
