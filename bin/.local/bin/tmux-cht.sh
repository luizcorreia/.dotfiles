#!/usr/bin/env bash
selected=$(cat ~/.tmux-cht-languages ~/.tmux-cht-command | fzf)
if [[ -z $selected ]]; then
	exit 0
fi

read -p "Enter Query: " query

if grep -qs "$selected" ~/.tmux-cht-languages; then
	query=$(echo $query | tr ' ' '+')
	kitty @ launch "curl cht.sh/$selected/$query\" & curl cht.sh/$selected/$query & while [ : ]; do sleep 1; done"
else
	kitty @ launch "curl -s cht.sh/$selected~$query | less"
fi
