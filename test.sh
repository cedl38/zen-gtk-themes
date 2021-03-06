#!/bin/sh

# test the themes
# dependencies : awf

# sleep
t=15

# package name
pkgname=$(grep -m 1 'pkgname=' arch/PKGBUILD | cut -d= -f2)
name=${pkgname%%-*}
# first letter in uppercase
name=$(echo ${name:0:1}|tr a-z A-Z)${name:1}

# themes to test
themes=$(ls -1 | grep "$name")

# run "A Widget Factory"
		awf-gtk2  &
		awf-gtk3  &
set $themes
	if [ "$1" != "" ]
	then
		until [ $# = 0 ]
		do
		xfconf-query -c xsettings -p /Net/ThemeName -s "$1-dev"
		xfconf-query -c xsettings -p /Net/IconThemeName -s "Foxtrot"
		echo "theme $1 tested, sleep for $t sec, $# restants"
		sleep $t
		shift
		done
	fi

# User theme
xfconf-query -c xsettings -p /Net/ThemeName -s "Zen"
xfconf-query -c xsettings -p /Net/IconThemeName -s "Foxtrot"

#GTK theme:
#gconftool-2 --type=string -s /desktop/gnome/interface/gtk_theme Clearlooks

#Metacity:
#gconftool-2 --type=string -s /apps/metacity/general/theme Clearlooks

#Icons:
#gconftool-2 --type=string -s /desktop/gnome/interface/icon_theme gnome

#Wallpaper:
#gconftool-2 -t str --set /desktop/gnome/background/picture_filename "/usr/share/backgrounds/gnome.png"
