#! /bin/env bash

set -eu

file=$(fd -t f -H -E .git -E node_modules | fzf)
nvim $file
