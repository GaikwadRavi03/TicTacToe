#!/bin/bash

echo "welcome in tic tac toe game"

declare -a board

PLAYER=X
COMPUTER=O
turn=0
function whoPlayFirst() {
	random=$((RANDOM%2))
	if [ $random -eq 1 ]
	then
		echo "PLAYER play first"
	else
		echo "COMPUTER play first"
	fi
}

whoPlayFirst
