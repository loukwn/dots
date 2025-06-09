#!/bin/env bash

ss="󰄀 : 󰒉 "
s1="󰄀 :  "
s2="󰄀 : 󰍹 "
sa="󰄀 :  󰍹 "
rs=" : 󰒉 "
r1=" :  "
r2=" : 󰍹 "

rofi_cmd() {
  rofi -dmenu \
    -p "Screenshot / Screencap" \
    -theme screen_capture.rasi
}

run_rofi() {
  both_monitors='eDP-1
  HDMI-A-1'
  just_laptop='eDP-1'
  just_external='HDMI-A-1'
  monitors_used_now=$(hyprctl monitors | grep "Monitor" | awk -F ' ' '{print $2}')

  case "$monitors_used_now" in
    $both_monitors)
      echo -e "$ss\n$s1\n$s2\n$sa\n$rs\n$r1\n$r2" | rofi_cmd
      ;;
    $just_laptop)
      echo -e "$ss\n$s1\n$rs\n$r1" | rofi_cmd
      ;;
    $just_external)
      echo -e "$ss\n$s2\n$rs\n$r2" | rofi_cmd
      ;;
    *)
      echo -e "$ss\n$s1\n$s2\n$sa\n$rs\n$r1\n$r2" | rofi_cmd
      ;;
    esac
}


img_path="${HOME}/Pictures/Screenshots/Screenshot from $(date +%Y-%m-%d\ %H-%M-%S).png"
vid_path="${HOME}/Videos/Screencasts/Screencast from $(date +%Y-%m-%d\ %H-%M-%S).mp4"

chosen="$(run_rofi)"
case "$chosen" in
  $ss)
    screenshot_area="$(slurp)" || exit 1
    grim -g "$screenshot_area" "$img_path"
    wl-copy < "$img_path"
    notify-send "Screenshot Taken (selection)" "${img_path}"
    ;;
  $s1)
    sleep .2
    grim -c -o eDP-1 "$img_path"
    wl-copy < "$img_path"
    notify-send "Screenshot Taken (laptop)" "${img_path}"
    ;;
  $s2)
    sleep .2
    grim -c -o HDMI-A-1 "$img_path"
    wl-copy < "$img_path"
    notify-send "Screenshot Taken (external)" "${img_path}"
    ;;
  $sa)
    sleep .2
    grim -c -o eDP-1 "${img_path//.png/-eDP-1.png}"
    grim -c -o HDMI-A-1 "${img_path//.png/-HDMI-A-1.png}"
    montage "${img_path//.png/-eDP-1.png}" "${img_path//.png/-HDMI-A-1.png}" -tile 2x1 -geometry +0+0 "$img_path" 
    wl-copy < "$img_path"
    rm "${img_path//.png/-eDP-1.png}" "${img_path/.png/-HDMI-A-1.png}"
    notify-send "Screenshot Taken (all)" "${img_path}"
    ;;
  $rs)
    pkill -SIGKILL -x wf-recorder
    echo "$vid_path" > /tmp/currently_recording.txt
    recording_area="$(slurp)" || exit 1
    wf-recorder -a -g "$recording_area" -f "$vid_path" >/dev/null 2>&1 &
    pkill -RTMIN+8 waybar
    ;;
  $r1)
    pkill -SIGKILL -x wf-recorder
    sleep .2
    echo "$vid_path" > /tmp/currently_recording.txt
    wf-recorder -a -o eDP-1 -f "$vid_path" >/dev/null 2>&1 &
    pkill -RTMIN+8 waybar
    ;;
  $r2)
    pkill -SIGKILL -x wf-recorder
    sleep .2
    echo "$vid_path" > /tmp/currently_recording.txt
    wf-recorder -a -o HDMI-A-1 -f "$vid_path" >/dev/null 2>&1 &
    pkill -RTMIN+8 waybar
    ;;
  *)
    ;;
esac
