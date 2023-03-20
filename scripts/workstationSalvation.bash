#!/bin/bash
(
	cd ~/.local/opt/workstationCreation
	git status
	read -n 1 -p "Press c to commit, p to partial-commit, or any other key to continue. " response >&1
	echo
	if [[ $response -eq "c" ]]
	then
		git commit -a
	elif [[ $response -eq "p" ]]
	then
		git commit -p
	fi
)
