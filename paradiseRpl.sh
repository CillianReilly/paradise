#!/bin/bash

echo "Setting environment variables from paradise.cfg..."
PORT=$(grep PORT paradise.cfg | cut -d "=" -f2)

rlwrap -r $QHOME/l32/q rpl.q -port $PORT -host localhost
