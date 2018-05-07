#!/bin/sh

CURRENT_DIR=$(cd `dirname $0`; pwd)

PID_FILE="${CURRENT_DIR}/catalina.pid"

if [ -f "$PID_FILE" ]; then
	PID=`cat "$PID_FILE"`
	if [ -z "$PID" ]
	then
		echo "application(flight-booking) is already stopped"
	else
		echo "killing applicaiton(flight-booking) with the PID: $PID"
		kill -9 $PID
	fi
fi
