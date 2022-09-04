#!/usr/bin/env bash

NOTE=true
MAIN=maind
BOTTOM=bottomd
dir="$HOME/.config/polybar"
themes=($(ls --hide="launch.sh" $dir))

launch_bar() {
	# Terminate already running bar instances
	killall -q polybar

	# Wait until the processes have been shut down
	while pgrep -u $UID -x polybar >/dev/null; do sleep 1; done
	if [ -n "$NOTE" ]; then
		MAIN=top
		BOTTOM=bottom
	fi

	# Launch the bar
	if [[ "$style" == "hack" || "$style" == "cuts" ]]; then
		polybar -q $MAIN -c "$dir/$style/config.ini" &
		polybar -q $BOTTOM -c "$dir/$style/config.ini" &
		if [ -z "$NOTE" ]; then
			polybar -q mon2 -c "$dir/$style/config.ini" &
		fi
	elif [[ "$style" == "pwidgets" ]]; then
		bash "$dir"/pwidgets/launch.sh --main
	elif [[ "$style" == "docky" ]]; then
		polybar -q main -c "$dir/$style/config.ini" &
		polybar -q mon2 -c "$dir/$style/config.ini" &
	else
		polybar -q main -c "$dir/$style/config.ini" &
	fi
}

if [[ "$1" == "--material" ]]; then
	style="material"
	launch_bar

elif [[ "$1" == "--shades" ]]; then
	style="shades"
	launch_bar

elif [[ "$1" == "--hack" ]]; then
	style="hack"
	launch_bar

elif [[ "$1" == "--docky" ]]; then
	style="docky"
	launch_bar

elif [[ "$1" == "--cuts" ]]; then
	style="cuts"
	launch_bar

elif [[ "$1" == "--shapes" ]]; then
	style="shapes"
	launch_bar

elif [[ "$1" == "--grayblocks" ]]; then
	style="grayblocks"
	launch_bar

elif [[ "$1" == "--blocks" ]]; then
	style="blocks"
	launch_bar

elif [[ "$1" == "--colorblocks" ]]; then
	style="colorblocks"
	launch_bar

elif [[ "$1" == "--forest" ]]; then
	style="forest"
	launch_bar

elif [[ "$1" == "--pwidgets" ]]; then
	style="pwidgets"
	launch_bar

elif [[ "$1" == "--panels" ]]; then
	style="panels"
	launch_bar

else
	style="docky"
	launch_bar
fi
