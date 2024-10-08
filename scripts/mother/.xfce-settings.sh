#!/bin/bash

if ! [[ $EUID -ne 0 ]]; then
	echo "This script should not be run with root/sudo privileges."
	exit 1
fi

xfconf-query -c xsettings -p /Gtk/FontName -t string -s "Ubuntu 13"
xfconf-query -c xsettings -p /Gtk/MonospaceFontName -t string -s "Monospace 13"

# xfce4-panel -r

xfconf-query -c xfce4-panel -p /panels/panel-1/size -s "44"
