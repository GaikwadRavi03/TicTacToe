#!/bin/bash

echo "welcome in tic tac toe game"

declare -a boardPosition

PLAYER="X"
COMPUTER="O"
turn=9

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
		playGame $random
	fi
}

function playGame() {
	flag=$1
  	limit=0
  	# limit 0 work 1 stop 
  	while [ $limit -eq 0 ]
  	do
    		if [ $flag -eq 1 ]
    		then
      			echo "Player Enter your Slot :"
      			read cellNumber
			if [[ ( ${boardPosition[$cellNumber]} -eq $PLAYER ) || ( ${boardPosition[$cellNumber]} -eq $COMPUTER ) ]]
			then
				echo "Slot already taken, Re-enter slot number"
				playGame
			else
      				boardPosition[$cellNumber]=$PLAYER
      				printBoard
      				limit=$( checkWinCondition )
				if [ $limit -eq 1 ]
				then
					echo "Player win"
				fi
				flag=0
			fi
        	else
			echo "Computer Enter your Slot :"
			randomCellNumber=$((RANDOM%9+1))
			if [[ ( ${boardPosition[$randomCellNumber]} -eq $PLAYER ) || ( ${boardPosition[$randomCellNumber]} -eq $COMPUTER ) ]]
			then			
				echo "Slot already take"
				playGame
			else  	
				boardPosition[$randomCellNumber]=$COMPUTER
				printBoard
      				limit=$( checkWinCondition )		
				if [ $limit -eq 1 ]
				then
					echo "Computer win"
				fi
			fi
			flag=1
		fi
  	done
}

function checkWinCondition () {
 checkCondition=$( checkmatch 1 2 3 )
 checkCondition=$( checkmatch 4 5 6 )
 checkCondition=$( checkmatch 7 8 9 )
 checkCondition=$( checkmatch 1 4 7 )
 checkCondition=$( checkmatch 2 5 8 )
 checkCondition=$( checkmatch 3 6 9 )
 checkCondition=$( checkmatch 1 5 9 )
 checkCondition=$( checkmatch 3 5 7 )
	echo 1
}

checkmatch(){
 if [ ${boardPosition[$1]} != "." ] && [ ${boardPosition[$1]} == ${boardPosition[$2]} ] && [ ${boardPosition[$2]} == ${boardPosition[$3]} ]
 then
   echo 1
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
	boardPosition[$i]=$i
done

whoPlayFirst
