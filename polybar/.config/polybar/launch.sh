#!/usr/bin/env bash
MAIN=base
# Terminate already running bar instances
killall -q polybar

# Wait until the processes have been shut down
while pgrep -x polybar >/dev/null; do sleep 1; done
if [ -n "$NOTE" ]; then
MAIN=note
fi

# Launch polybar
polybar $MAIN &
polybar bar2 &

sleep 1

if ! pgrep -x polybar; then
	polybar $MAIN &
else
	pkill -USR1 polybar
fi


echo "Bars launched..."
