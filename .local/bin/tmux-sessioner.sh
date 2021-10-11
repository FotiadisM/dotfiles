#!/bin/sh

folder=$(fd -t d --hidden --exclude .git | fzf)

if [ $? -eq 0 ]
then
	name=$(basename $folder)

	tmux has -t $name
	if [ $? -eq 1 ]
	then
		tmux new -d -s $name -c $folder
	fi

	tmux switch -t $name
fi
