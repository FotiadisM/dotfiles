#! /bin/env bash

set -eu

sink="@DEFAULT_AUDIO_SINK@"

cur_volume=$(wpctl get-volume $sink | awk '{print $2}')
if (( $(echo "$cur_volume <= 0.95" | bc ))); then
	wpctl set-volume $sink 5%+
elif (( $(echo "$cur_volume > 0.95 && $cur_volume <= 1.00" | bc ))); then 
	wpctl set-volume $sink 100%
fi
