#!/bin/bash

set -e
set -u

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
BACKUP_DIR="${DIR}_backup_$(date +%Y-%m-%d-%H:%M)"

IGNORE="^install\.sh$|\
^install-dependencies\.sh$|\
^README\.md$|\
^xmonad\.desktop$|\
^dependencies$"

echo "Installing dotfiles"
echo "Backup directory: $BACKUP_DIR"
echo

cd "$DIR"

files="$(git ls-files | egrep -v $IGNORE | sort)"
for file in $files ; do
    home_file="$(readlink -f "$HOME/$file" || true)"
    home_file="${home_file:-$HOME/$file}"
    destination_file="$(readlink -f "$DIR/$file")"

	if command -v realpath &> /dev/null ; then
		destination_file_link=$(realpath --relative-to="$(dirname "$home_file")" "$destination_file")
	else
		destination_file_link="$destination_file"
	fi

    if [ "$home_file" != "$destination_file" ] ; then
        echo "Needs linking:    $file"
        mkdir -v -p "$(dirname "$HOME/$file")" || true

        if [ -e "$home_file" ] ; then
            mkdir -p "$BACKUP_DIR" || true
            mv -v "$home_file" "$BACKUP_DIR" || true
        fi

        ln -s -f -v "$destination_file_link" "$home_file"
    else
        echo "Nothing to do:    $file"
    fi
done

echo
echo "Initializing and updating git submodules"
git submodule update --init

echo "Installing urxvt extensions"
urxvt_ext="$DIR/.urxvt/ext/urxvt-font-size/font-size"
if command -v realpath &> /dev/null ; then
	urxvt_ext_link=$(realpath --relative-to="$(dirname "$HOME/.urxvt/ext/font-size")" "$urxvt_ext")
else
	urxvt_ext_link="$urxvt_ext"
fi
ln -s -f -v "$urxvt_ext_link" "$HOME/.urxvt/ext/font-size"

echo
echo "All done."
