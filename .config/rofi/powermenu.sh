#!/usr/bin/env bash

# CMDs
uptime="`uptime -p | sed -e 's/up //g'`"

# Options
shutdown='󰐥'
reboot='󰜉'
lock='󰌾'
# suspend=''
logout='󰩈'
yes='󰄬'
no='󰅖'

rofi_cmd() {
	rofi -dmenu \
		-p "Time to touch grass..." \
		-mesg "Uptime: $uptime" \
		-theme powermenu.rasi
}

confirm_cmd() {
  rofi -dmenu \
		-mesg 'Are you sure?' \
    -theme confirmation.rasi
}

run_confirmation() {
	echo -e "$no\n$yes" | confirm_cmd
}

run_rofi() {
	echo -e "$lock\n$logout\n$reboot\n$shutdown" | rofi_cmd
}

confirm_choice() {
	selected="$(run_confirmation)"
	if [[ "$selected" == "$yes" ]]; then
		if [[ $1 == '--shutdown' ]]; then
			systemctl poweroff
		elif [[ $1 == '--reboot' ]]; then
			systemctl reboot
#		elif [[ $1 == '--suspend' ]]; then
#			systemctl suspend
		elif [[ $1 == '--logout' ]]; then
      hyprctl dispatch exit
		fi
	else
		exit 0
	fi
}

chosen="$(run_rofi)"
case ${chosen} in
    $shutdown)
		confirm_choice --shutdown
        ;;
    $reboot)
		confirm_choice --reboot
        ;;
    $lock)
    swaylock
        ;;
#    $suspend)
#		confirm_choice --suspend
#        ;;
    $logout)
		confirm_choice --logout
        ;;
esac
