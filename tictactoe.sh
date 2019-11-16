#!/bin/bash

echo "welcome in tic tac toe game"

declare -a boardPosition

PLAYER=X
COMPUTER=O
turn=0

function whoPlayFirst() {
	random=$((RANDOM%2))
	if [ $random -eq 1 ]
	then
		echo "PLAYER play first"
		printBoard
		playGame $random
	else
		echo "COMPUTER play first"
		printBoard
	fi
}

function printBoard () {
	echo "|-----|-----|-----|"
	echo "|  "${boardPosition[1]}"  |  "${boardPosition[2]}"  |  "${boardPosition[3]}"  |"
	echo "|-----|-----|-----|"
 	echo "|  "${boardPosition[4]}"  |  "${boardPosition[5]}"  |  "${boardPosition[6]}"  |"
	echo "|-----|-----|-----|"
        echo "|  "${boardPosition[7]}"  |  "${boardPosition[8]}"  |  "${boardPosition[9]}"  |"
	echo "|-----|-----|-----|"
	printf "\n"
}

for (( i=1; i<=9; i++ ))
do
	boardPosition[$i]=-
done

function playGame() {
	a=$1
	if [ $a -eq 1 ]
	then
		echo "Player Enter your number : \c"
		read cellNumber
		boardPosition[$cellNumber]=$PLAYER
		printBoard
	fi

}

whoPlayFirst
