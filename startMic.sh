#!/bin/bash

echo "Setting environment variables from paradise.cfg..."
PORT=$(grep PORT $PHOME/paradise.cfg | cut -d "=" -f2)
CLI=$(grep CLI $PHOME/paradise.cfg | cut -d "=" -f2)

echo "Starting mic..."
$QHOME/l32/q $PHOME/audio/mic.q -port $PORT -cli $CLI 2>&1 >$PHOME/logs/mic.log &

exit 0
