#!/usr/bin/env bash

# Directory for config if needed
config="$HOME/.config/fuzzel/config"

# Options
shutdown="Shutdown"
reboot="Reboot"
lock="Lock"
suspend="Suspend"
logout="Logout"

# Confirmation function
confirm_exit() {
    echo -e "yes\nno" | fuzzel -p "Are you sure?" -l 2 -f "$config"
}

# Get uptime
uptime=$(uptime -p | sed -e 's/up //g')

# Show power menu
options="$shutdown\n$reboot\n$lock\n$suspend\n$logout"
chosen=$(echo -e "$options" | fuzzel -p "Uptime: $uptime" -l 6 -f "$config" -s "$options")

case $chosen in
    $shutdown)
        ans=$(confirm_exit)
        [[ "$ans" == "yes" ]] && loginctl poweroff
        ;;
    $reboot)
        ans=$(confirm_exit)
        [[ "$ans" == "yes" ]] && loginctl reboot
        ;;
    $lock)
        if command -v i3lock >/dev/null; then
            i3lock
        elif command -v betterlockscreen >/dev/null; then
            betterlockscreen -l
        fi
        ;;
    $suspend)
        ans=$(confirm_exit)
        [[ "$ans" == "yes" ]] && loginctl suspend
        ;;
    $logout)
        ans=$(confirm_exit)
        if [[ "$ans" == "yes" ]]; then
            case "$DESKTOP_SESSION" in
                bspwm) bspc quit ;;
                i3) i3-msg exit ;;
                awesome) pkill awesome ;;
                voidwm|dwm) pkill dwm ;;
                *) pkill Hyprland ;;
            esac
        fi
        ;;
esac
