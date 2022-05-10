#! /bin/env bash

folder=$1
if [ $# -eq 0 ]; then
	folder=$(fd -t d -H -a -E .git -E node_modules | fzf)
	if [ $? -ne 0 ]; then
		exit 0
	fi
fi

name=$(basename $folder)
tmux has -t $name 2> /dev/null
if [ $? -ne 0 ]; then
	tmux new -d -s $name -c $folder
fi

tmux switch -t $name
