#!/bin/sh

userresources=$HOME/.Xresources
usermodmap=$HOME/.Xmodmap
sysresources=/etc/X11/xinit/.Xresources
sysmodmap=/etc/X11/xinit/.Xmodmap

# merge in defaults and keymaps

if [ -f $sysresources ]; then

    xrdb -merge $sysresources

fi

if [ -f $sysmodmap ]; then
    xmodmap $sysmodmap
fi

if [ -f "$userresources" ]; then
    xrdb -merge "$userresources"
fi

if [ -f "$usermodmap" ]; then
    xmodmap "$usermodmap"
fi

# start some nice programs

if [ -d /etc/X11/xinit/xinitrc.d ] ; then
 for f in /etc/X11/xinit/xinitrc.d/?*.sh ; do
  [ -x "$f" ] && . "$f"
 done
 unset f
fi

# X settings
xrdb -merge -I $HOME ~/.Xresources &

# US layout
setxkbmap -layout us -variant intl &

# No mouse acceleration
xset m 1/1 0 &

# Faster keyboard auto-repeat rate
xset r rate 250 50 &

# Multiple monitor setting
xrandr --output DP-0 --primary &
xrandr --output HDMI-0 --left-of DP-0 --rotate right &
powerline-daemon -q
powerline-config tmux setup
tmux new-session -s luizcorreia -d
# Java GUI rendering fix
wmname compiz &

# Set a nice background
#nitrogen --restore &
# Fire up screensaver
xscreensaver -no-splash &
#picom --experimental-backend &

#exec xmonad
# Power Management
xfce4-power-manager &
#lxsession &
/usr/libexec/polkit-gnome-authentication-agent-1 &
eval $(gnome-keyring-daemon -s --components=pkcs11,secrets,ssh,gpg)
#eval $(gnome-keyring-daemon --start)
export SSH_AUTH_SOCK
pcmanfm -d &
#conky -c $HOME/.config/conky/xmonad.conkyrc &
#thunar --daemon &
#volumeicon &
# Start WM
#exec /home/luizcorreia/.local/bin/xmonad
exec xmonad
#exec /usr/bin/lxsession -s awesome -e awesome
#dbus-launch --exit-with-session awesome
#echo 'awesome.restart()' | awesome-client
