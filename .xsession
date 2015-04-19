#!/bin/bash

xrdb -merge .Xresources
xsetroot -solid black

xset -b
xset r rate 500 30

setxkbmap -option "nbsp:none"

trayer --edge top --align right --SetDockType true --expand true --widthtype pixel --width 192 --transparent true --heighttype pixel --height 18 --alpha 255 --tint 0x000000 &

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
