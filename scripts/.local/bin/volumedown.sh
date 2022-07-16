#! /bin/env bash

set -eu

sink="@DEFAULT_AUDIO_SINK@"
wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-
