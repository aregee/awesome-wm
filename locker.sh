#!/bin/sh

xautolock -detectsleep -time 15 -locker "i3lock -d -c 000070" -notify 40 -notifier "notify-send critical -t 10000 -- 'System Lockdown'"
