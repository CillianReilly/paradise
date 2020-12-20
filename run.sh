#!/bin/bash

echo "Starting paradise..."
$QHOME/l32/q run.q -p 5000 -cli 0 -mic 0 -ml 0 >/dev/null >logs/paradise.log 2>&1 &

echo "Starting ngrok server..."
ngrok http -subdomain=paradise 5000 2>&1 >/dev/null &

echo "Started"
exit 0
