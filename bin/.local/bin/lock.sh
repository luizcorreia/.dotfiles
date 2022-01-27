#!/bin/bash
xset s 1080 &
xautolock -time 20 -locker lockglitch -notify 30 -notifier "notify-send 'Locker' 'Locking screen in 30 seconds'" -killtime 5 -killer "systemctl suspend"
