#!/bin/bash

echo "Setting environment variables from paradise.cfg..."
PORT=$(grep PORT $PHOME/paradise.cfg | cut -d "=" -f2)

echo "Stopping mic..."
ps -ef | grep mic.q | grep $PORT | awk '{print $2}' | xargs --no-run-if-empty kill -9

exit 0
