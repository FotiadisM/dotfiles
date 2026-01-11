#!/bin/env bash

set -eu

sudo systemctl enable ly@tty2.service
sudo systemctl disable getty@tty2.service

systemctl --user enable swaync.service
systemctl --user enable hyprpaper.service
systemctl --user enable hyprsunset.service
systemctl --user enable hyprpolkitagent.service
systemctl --user enable waybar.service
elephant service enable
