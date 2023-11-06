#!/bin/bash
#
# Status bar for sway
# 
# Requires: noto fonts

date_time=$(date "+%a %d %b %Y 🕘 %R")
loadavg_5min=$(cat /proc/loadavg | awk -F ' ' '{print $2}')
network=$(ip route get 1.1.1.1 | grep -Po '(?<=dev\s)\w+' | cut -f1 -d ' ')
temperature=$(echo "scale=2; $(cat /sys/class/thermal/thermal_zone0/temp) / 1000" | bc -l)
total_memory=$(grep MemTotal /proc/meminfo | grep -Eo '[0-9]*')
free_memory=$(grep MemFree /proc/meminfo | grep -Eo '[0-9]*')
memory_use=$(echo "scale=2; ($total_memory - $free_memory) * 100 / $total_memory" | bc -l)
cpu_use=$(awk '{u=$2+$4; t=$2+$4+$5; if (NR==1){u1=u; t1=t;} else printf "%.2f%%", (($2+$4-u1) * 100 / (t-t1))}' <(grep 'cpu ' /proc/stat) <(sleep 0.1; grep 'cpu ' /proc/stat))
audio_volume=$(pamixer --get-volume)
audio_is_muted=$(pamixer --get-mute)

if ! [ $network ]
then
   network_active="⛔"
else
   network_active="⇆"
fi

if [ $audio_is_muted = "true" ]
then
    audio_active='🔇'
else
    audio_active="$audio_volume% 🔊"
fi

echo "🖳 $cpu_use | 🖴 $memory_use% | 🌡 $temperature°C | $network_active $network | 🏋 $loadavg_5min | $date_time | $audio_active"
