#!/bin/bash

DIR=$(readlink -f "$(dirname "${BASH_SOURCE[0]}")")

#echo "Acquire::ForceIPv4 \"true\";" | sudo tee /etc/apt/apt.conf.d/99force-ipv4
install_packages=(
    arandr
    autocutsel
    c2hs
    cabal-install
    cscope
    curl
    feh
    irssi
    keychain
    libasound2-dev
    libghc-xmonad-contrib-dev
    libghc-xmonad-dev
    libiw-dev
    libxml2-dev
    libxpm-dev
    rxvt-unicode-256color
    sshuttle
    stalonetray
    suckless-tools
    vim
    vim-gnome
    xclip
    xcompmgr
    xmonad
    xscreensaver
    zsh
)

sudo apt-get install "${install_packages[@]}"

purge_packages=(
    gnome-screensaver
)

sudo apt-get purge "${purge_packages[@]}"

sudo cabal update
sudo cabal install --global xmobar --flags="all_extensions"

cp "${DIR}"/xmonad.desktop /usr/share/xsessions/

gsettings set org.gnome.desktop.background show-desktop-icons false
gsettings set org.gnome.desktop.lockdown disable-lock-screen true
