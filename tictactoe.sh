#!/bin/bash

echo "welcome in tic tac toe game"
declare -a boardPosition

PLAYER="X"
COMPUTER="O"
winLossFlag=false
gameCount=1

function whoPlayFirst() {
	local random=$((RANDOM%2))
	if [ $random -eq 1 ]
	then
		echo "PLAYER play first"
	else
		echo "COMPUTER play first"
	fi
	printBoard
	playGame $random
}

function playGame() {
	local flag=$1
  	while [ $winLossFlag == false ]
  	do
    		if [ $flag -eq 1 ]
    		then
      			echo "Player Enter your Slot :"
      			read playerCellNumber
			if [[ ( "${boardPosition[$playerCellNumber]}" == $PLAYER ) || ( "${boardPosition[$playerCellNumber]}" == $COMPUTER ) ]]
			then
				echo "Slot already taken, Re-enter slot number"
				playGame $flag
			else
      				boardPosition[$playerCellNumber]=$PLAYER
      				printBoard
      				checkWinCondition $PLAYER
				flag=0
			fi
        	else
			echo "Computer Enter your Slot :"
			computerCellNumber=$( checkCompWinningCondition )
			echo "computerCellNumber : $computerCellNumber"
			if [[ ( "${boardPosition[$computerCellNumber]}" == $PLAYER ) || ( "${boardPosition[$computerCellNumber]}" == $COMPUTER ) ]]
			then
				echo "Slot already taken"
				playGame $flag
			else
				boardPosition[$computerCellNumber]=$COMPUTER
				printBoard
      				checkWinCondition $COMPUTER
				flag=1
			fi
		fi
		((gameCount++))
  	done
}

function checkCompWinningCondition(){
	computerRowPosition=$( winComAtRowPosition )
	computerColumnPosition=$( winComAtColoumnPosition )
	computerDiagonalPosition=$( winComAtDiagonalPosition )
	computerTakesCorners=$( takesCorner )
	computerTakesCenter=$( takesCenter )
	computerTakesSide=$( takesSide )

	if [[ $computerRowPosition -gt 0 ]]
	then
		position=$computerRowPosition
		positionToReturn=0;
	elif [[ $computerColumnPosition -gt 0 ]]
	then
		position=$computerColumnPosition
		positionToReturn=0;
	elif [[ $computerDiagonalPosition -gt 0 ]]
	then
		position=$computerDiagonalPosition
		positionToReturn=0;
	elif [[ $computerTakesCorners -gt 0 ]]
	then
		position=$computerTakesCorners
		positionToReturn=0;
	elif [[ $computerTakesCenter -gt 0 ]]
	then
		position=$computerTakesCenter
		positionToReturn=0;
	elif [[ $computerTakesSide -gt 0 ]]
	then
		position=$computerTakesSide
		positionToReturn=0;
	else
		position=$((RANDOM%9+1))
	fi
	echo $position
}

function takesSide(){
	local count=1
	if [[ ${boardPosition[$(($count+1))]} -ne $COMPUTER ]] && [[ ${boardPosition[$(($count+1))]} -ne $PLAYER ]]
	then
		positionToReturn=$(($count+1))
	elif [[ ${boardPosition[$(($count+3))]} -ne $COMPUTER ]] && [[ ${boardPosition[$(($count+3))]} -ne $PLAYER ]]
	then
		positionToReturn=$(($count+3))
	elif [[ ${boardPosition[$(($count+5))]} -ne $COMPUTER ]] && [[ ${boardPosition[$(($count+5))]} -ne $PLAYER ]]
	then
		positionToReturn=$(($count+5))
	elif [[ ${boardPosition[$(($count+7))]} -ne $COMPUTER ]] && [[ ${boardPosition[$(($count+7))]} -ne $PLAYER ]]
	then
		positionToReturn=$(($count+7))
	fi
	echo $positionToReturn
}


function takesCorner(){
	local count=1
	for (( innerLoopCounter=1; innerLoopCounter<=2; innerLoopCounter++ ))
	do
		if [[ ${boardPosition[$count]} -ne $COMPUTER ]] || [[ ${boardPosition[$count]} -ne $PLAYER ]]
		then
			positionToReplay=$count
		elif [[ ${boardPosition[$(($count+2))]} -ne $COMPUTER ]] || [[ ${boardPosition[$(($count+2))]} -ne $PLAYER ]]
		then
			positionToReturn=$(($count+2))
		fi
		count=$(($count+6))
	done
	echo $positionToReturn
}

function takesCenter(){
	local count=1
	if [[ ${boardPosition[$(($count+4))]} -ne $COMPUTER ]] && [[ ${boardPosition[$(($count+4))]} -ne $PLAYER ]]
	then
		positionToReturn=$(($count+4))	
	fi
	echo $positionToReturn
}

	
function winComAtRowPosition(){
	local row=0;
	for (( count=1; count<=3; count++ ))
	do
		row=$(( $row+1 ))
		if [[ ${boardPosition[$row]} == ${boardPosition[$(($row+1))]} ]] || [[ ${boardPosition[$(($row+1))]} == ${boardPosition[$(($row+2))]} ]] || [[ ${boardPosition[$(($row+2))]} == ${boardPosition[$row]} ]]
		then
			for (( innerLoopCounter=$row; innerLoopCounter<=$(($row+2)); innerLoopCounter++ ))
			do
				if [[ ${boardPosition[$innerLoopCounter]} -ne $COMPUTER ]] || [[ ${boardPosition[$innerLoopCounter]} -ne $PLAYER ]]
				then
					positionToReturn=$innerLoopCounter
				fi
			done
		else
			row=$(( $row+2 ))
		fi
	done
	echo $positionToReturn
}

function winComAtColoumnPosition(){
	local column=0
	local positionToReturn
	for (( count=1; count<=3; count++ ))
	do
		column=$(( $column+1 ))
		if [[ ${boardPosition[$column]} == ${boardPosition[$(($column+3))]} ]] || [[ ${boardPosition[$(($column+3))]} == ${boardPosition[$(($column+6))]} ]] || [[ ${boardPosition[$(($column+6))]} == ${boardPosition[$column]} ]] 
		then
			for (( innerLoopCounter=1; innerLoopCounter<=3; innerLoopCounter++ ))
			do
				if [[ ${boardPosition[$column]} -ne $COMPUTER ]] || [[ ${boardPosition[$innerLoopCounter]} -ne $PLAYER ]]
				then
					positionToReturn=$column
				fi
				column=$(( $column+3 ))
				if [ $column -eq 10 ]
				then
					column=1
					break
				fi
			done
		fi
	done
	echo $positionToReturn
}

function winComAtDiagonalPosition(){
	local diagCount=1;
	local count=1;
	if [[ ${boardPosition[$diagCount]} == ${boardPosition[$(($diagCount+4))]} ]] || [[ ${boardPosition[$(($diagCount+4))]} == ${boardPosition[$(($diagCount+8))]} ]] || [[ ${boardPosition[$(($diagCount+8))]} == ${boardPosition[$diagCount]} ]]
	then
		for (( innerLoopCounter=1; innerLoopCounter<=3; innerLoopCounter++ ))
		do
			if [[ ${boardPosition[$diagCount]} -ne $COMPUTER ]] || [[ ${boardPosition[$innerLoopCounter]} -ne $PLAYER ]]
			then
				positionToReturn=$diagCount
			fi
			diagCount=$(( $diagCount+4 ))
		done
	elif [[ ${boardPosition[$(($count+2))]} == ${boardPosition[$(($count+4))]} ]] || [[ ${boardPosition[$(($count+4))]} == ${boardPosition[$(($count+6))]} ]] || [[ ${boardPosition[$(($count+6))]} == ${boardPosition[$(($count+2))]} ]]
	then
		for (( innerLoopCounter=1; innerLoopCounter<=3; innerLoopCounter++ ))
		do
			count=$(( $count+2 ))
			if [[ ${boardPosition[$count]} -ne $COMPUTER ]] || [[ ${boardPosition[$innerLoopCounter]} -ne $PLAYER ]]
			then
				positionToReturn=$count
			fi
		done
	fi
	echo $positionToReturn
}


function checkWinCondition () {
	checkRows $1
	checkColumns $1
	checkDiagonals $1
	gameTieCheck
}

function checkRows () {
	loopCheck=1
	position=1
	while [ $loopCheck -le 3 ]
	do
		if [[ ${boardPosition[$position]} == ${boardPosition[$(($position+1))]} ]] && [[ ${boardPosition[$(($position+1))]} == ${boardPosition[$(($position+2))]} ]] && [[ ${boardPosition[$position]} == $1 ]]
		then
			winLossFlag=true
			echo "$1 Won"
			break
		else
			position=$(($position+3))
		fi
		((loopCheck++))
	done
}

function checkDiagonals () {
	loopCheck=1
	position=1
	while [ $loopCheck -le 3 ]
	do
		if [[ ${boardPosition[$position]} == ${boardPosition[$(($position+4))]} ]] && [[ ${boardPosition[$(($position+4))]} == ${boardPosition[$(($position+8))]} ]] && [[ ${boardPosition[$position]} == $1 ]]
		then
			winLossFlag=true
			echo "$1 Won"
			break
		elif [[ ${boardPosition[$(($position+2))]} == ${boardPosition[$(($position+4))]} ]] && [[ ${boardPosition[$(($position+4))]} == ${boardPosition[$(($position+6))]} ]]  && [[ ${boardPosition[$(($position+2))]} == $1 ]]
		then
			echo "$1 Won"
			winLossFlag=true
			break
		fi
		((loopCheck++))
	done
}

function checkColumns () {
	loopCheck=1
	position=1
	while [ $loopCheck -le 3 ]
	do
		if [[ ${boardPosition[$position]} == ${boardPosition[$(($position+3))]} ]] && [[ ${boardPosition[$(($position+3))]} == ${boardPosition[$(($position+6))]} ]]  && [[ ${boardPosition[$position]} == $symbol ]]
		then
			echo "$1 Won"
			winLossFlag=true
			break
		else
			position=$(($position+1))
		fi
		((loopCheck++))
	done
}

function gameTieCheck () {
	if [ $gameCount -ge 9 ]
	then
		echo "Match Tie"
		winLossFlag=true
	fi
}

function printBoard () {
	index=1
	for ((Counter=0; Counter<3; Counter++))
	do
		echo "|-----|-----|-----|"
		echo "|  "${boardPosition[counter+$index]}"  |  "${boardPosition[counter+index+1]}"  |  "${boardPosition[counter+index+2]}"  |"
		echo "|-----|-----|-----|"
		index=$(($index+3))
	done
}

for (( index=1; index<=9; index++ ))
do
	boardPosition[$index]=$index
done

whoPlayFirst

