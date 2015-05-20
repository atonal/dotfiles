#!/bin/bash

xrdb -merge .Xresources
xsetroot -solid black

xset -b
xset r rate 500 30

setxkbmap -option "nbsp:none"

xsetroot -cursor_name left_ptr

feh --bg-scale ~/Downloads/wallpapers/gaudi.jpg

stalonetray &

if [ -x /usr/bin/nm-applet ] ; then
   nm-applet --sm-disable &
fi

export SSH_ASKPASS=ssh-askpass
keychain -q id_rsa
. ~/.keychain/$HOSTNAME-sh
unset SSH_ASKPASS

xscreensaver -no-splash &
autocutsel -s PRIMARY -f
autocutsel -s CLIPBOARD -f
xcompmgr &
exec xmonad
