#!/bin/bash

echo "welcome in tic tac toe game"

declare -a boardPosition

PLAYER="X"
COMPUTER="O"
turn=9
counter=false
gameCount=1

function whoPlayFirst() {
	local random=$((RANDOM%2))
	if [ $random -eq 1 ]
	then
		echo "PLAYER play first"
		printBoard
		playGame $random
	else
		echo "COMPUTER play first"
		printBoard
		playGame $random
	fi
}

function playGame() {
	local flag=$1
  	while [ $counter == false ]
  	do
    		if [ $flag -eq 1 ]
    		then
      			echo "Player Enter your Slot :"
      			read cellNumber
			if [[ ( "${boardPosition[$cellNumber]}" == $PLAYER ) || ( "${boardPosition[$cellNumber]}" == $COMPUTER ) ]]
			then
				echo "Slot already taken, Re-enter slot number"
				playGame $flag
			else
      				boardPosition[$cellNumber]="$PLAYER"
      				printBoard
      				checkWinCondition $PLAYER
				flag=0
			fi
        	else
			echo "Computer Enter your Slot :"
			randomCellNumber=$((RANDOM%9+1))
			if [[ ( "${boardPosition[$randomCellNumber]}" == $PLAYER ) || ( "${boardPosition[$randomCellNumber]}" == $COMPUTER ) ]]
			then
				echo "Slot already take"
				playGame $flag
			else
				boardPosition[$randomCellNumber]="$COMPUTER"		
				printBoard
      				checkWinCondition $COMPUTER
				flag=1
			fi
		fi
		((gameCount++))
  	done
}

function checkWinCondition () {
	symbol=$1
	checkRows $symbol
	checkColumns $symbol
	checkDiagonals $symbol
	gameTieCheck
}

function checkRows () {
	symbol=$1
	loopCheck=1
	position=1
	while [ $loopCheck -le 3 ]
	do
		if [[ ${boardPosition[$position]} == ${boardPosition[$(($position+1))]} ]] && [[ ${boardPosition[$(($position+1))]} == ${boardPosition[$(($position+2))]} ]] && [[ ${boardPosition[$position]} == $symbol ]]
		then
			counter=true
			echo "$symbol Won"
			break
		else
			position=$(($position+3))
		fi
		((loopCheck++))
	done
}

function checkDiagonals () {
	symbol=$1
	loopCheck=1
	position=1
	while [ $loopCheck -le 3 ]
	do
		if [[ ${boardPosition[$position]} == ${boardPosition[$(($position+4))]} ]] && [[ ${boardPosition[$(($position+4))]} == ${boardPosition[$(($position+8))]} ]] && [[ ${boardPosition[$position]} == $symbol ]]
		then
			counter=true
			echo "$symbol Won"
			break
		elif [[ ${boardPosition[$(($position+2))]} == ${boardPosition[$(($position+4))]} ]] && [[ ${boardPosition[$(($position+4))]} == ${boardPosition[$(($position+6))]} ]]  && [[ ${boardPosition[$(($position+2))]} == $symbol ]]
		then
			counter=true
			echo "$symbol Won"
			break
		fi
		((loopCheck++))
	done
}

function checkColumns () {
	symbol=$1
	loopCheck=1
	position=1
	while [ $loopCheck -le 3 ]
	do
		if [[ ${boardPosition[$position]} == ${boardPosition[$(($position+3))]} ]] && [[ ${boardPosition[$(($position+3))]} == ${boardPosition[$(($position+6))]} ]]  && [[ ${boardPosition[$position]} == $symbol ]]
		then
			counter=true
			echo "$symbol Won"
			break
		else
			position=$(($position+1))
		fi
		((loopCheck++))
	done
}

function gameTieCheck () {
	if [ $gameCount -eq 9 ]
	then
		echo "Match Tie"
		counter=true
	fi
}

function printBoard () {
	i=1
	for ((Counter=0; Counter<3; Counter++))
	do
		echo "|-----|-----|-----|"
		echo "|  "${boardPosition[counter+i]}"  |  "${boardPosition[counter+i+1]}"  |  "${boardPosition[counter+i+2]}"  |"
		echo "|-----|-----|-----|"
		i=$((i+3))
	done
}

for (( i=1; i<=9; i++ ))
do
	boardPosition[$i]=$i
done

whoPlayFirst
