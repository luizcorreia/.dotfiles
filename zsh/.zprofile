# autostart Sway on tty1 at login
# [ -z $DISPLAY ] && [ "$(tty)" = "/dev/tty1" ] && exec awesome
#
# # autostart X (i3-wm) on tty2 at login
# [ -z $DISPLAY ] && [ "$(tty)" = "/dev/tty2" ] && exec startx
export XDG_CONFIG_HOME=$HOME/.config
VIM="nvim"
EDITOR="nvim"

# If you come from bash you might have to change your $PATH.
export PATH=$(yarn global bin):$HOME/bin:$HOME/.local/bin:$PATH

PERSONAL=$XDG_CONFIG_HOME/personal
for i in $(find -L $PERSONAL); do
	source $i
done

export GIT_EDITOR=$VIM

# Where should I put you?
bindkey -s "^f" "tmux-sessionizer^M"
#bindkey -s "^i" "tmux neww tmux-cht.sh^M"

catr() {
	tail -n "+$1" $3 | head -n "$(($2 - $1 + 1))"
}

validateYaml() {
	python -c 'import yaml,sys;yaml.safe_load(sys.stdin)' <$1
}

goWork() {
	cp ~/.npm_work_rc ~/.npmrc
}

goPersonal() {
	cp ~/.npm_personal_rc ~/.npmrc
}

cat1Line() {
	cat $1 | tr -d "\n"
}

ioloop() {
	FIFO=$(mktemp -u /tmp/ioloop_$$_XXXXXX) &&
		trap "rm -f $FIFO" EXIT &&
		mkfifo $FIFO &&
		(: <$FIFO &) && # avoid deadlock on opening pipe
		exec >$FIFO <$FIFO
}

eslintify() {
	cat $1 >/tmp/file_to_eslint
	npx eslint
}
