#!/usr/bin/env bash

# Terminate already running bar instances
killall -q polybar

# Wait until the processes have been shut down
while pgrep -x polybar >/dev/null; do sleep 1; done

# Launch polybar
polybar base &
polybar bar2 &

sleep 1

if ! pgrep -x polybar; then
	polybar base &
else
	pkill -USR1 polybar
fi

if $NOTE; then
	polybar note &
fi

echo "Bars launched..."
