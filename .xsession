#!/bin/bash

xrdb -merge .Xresources
xsetroot -solid black

xset -b
xset r rate 500 30

setxkbmap -option "nbsp:none"

stalonetray --icon-gravity E --geometry 10x1-0+0 --max-geometry 10x1-0+0 --background "#000000" --skip-taskbar --icon-size 18 --kludges force_icons_size --window-strut none &

xsetroot -cursor_name left_ptr
feh --bg-scale ~/Downloads/wallpapers/gaudi.jpg

if [ -x /usr/bin/nm-applet ] ; then
   nm-applet --sm-disable &
fi

export SSH_ASKPASS=ssh-askpass
keychain -q id_rsa
. ~/.keychain/$HOSTNAME-sh
unset SSH_ASKPASS

xscreensaver -no-splash &
autocutsel &
xcompmgr &
exec xmonad
