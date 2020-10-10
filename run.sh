#!/bin/bash

echo "Starting paradise..."
$QHOME/l32/q run.q -p 5000 -cli 0 -mic 1 -ml 1 </dev/null >logs/paradise.log 2>&1 &

echo "Started"
