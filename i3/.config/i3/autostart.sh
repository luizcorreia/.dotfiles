#!/bin/sh

# ===================================================================
# Start Up commands
# ===================================================================
# keyboard layout
# exec --no-startup-id setxkbmap -model abnt2 -layout br

# xscreensaver
# exec --no-startup-id xscreensaver -nosplash

# picom
# compositor
killall picom
while pgrep -u $UID -x picom >/dev/null; do sleep 1; done
picom --config ~/.config/picom/picom.conf --vsync &
xfce4-panel --disable-wm-check &
/usr/libexec/polkit-agent-helper-1 &
eval $(gnome-keyring-daemon -s --components=pkcs11,secrets,ssh,gpg) &
dbus-update-activation-environment --all &
xss-lock --transfer-sleep-lock -- i3lock --nofork
xfce4-power-manager &

# wallpaper
nitrogen --restore &

# polybar
#exec_always --no-startup-id ~/.config/polybar/launch.sh --cuts

# ~/.config/polybar/launch.sh &

#bg
dunst &
nm-applet &
volumeicon &
thunar --daemon &
setxkbmap -layout us -variant intl &
xset m 1/1 0 &
xset r rate 250 50 &
xrandr --output DisplayPort-0 --primary &
xrandr --output HDMI-A-0 --rotate left --left-of DisplayPort-0 &

# Java GUI rendering fix
wmname compiz &

flatpak run org.telegram.desktop &
flatpak run com.slack.Slack &
flatpak run org.mozilla.Thunderbird &
flatpak run net.waterfox.waterfox &
flatpak run md.obsidian.Obsidian &
flatpak run com.nextcloud.desktopclient.nextcloud &

