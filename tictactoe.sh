#!/bin/bash

echo "welcome in tic tac toe game"

declare -a boardPosition

PLAYER=X
COMPUTER=O
9=turn

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
		#playGame $random
	fi
}

function playGame() {
	a=$1
  	limit=0
  	# limit 0 work 1 stop 
  	while [ $limit -eq 0 ]
  	do
    		if [ $a -eq 1 ]
    		then
      			echo "PLay Player Enter your number : \c"
      			read cellNumber
      				boardPosition[$cellNumber]=$PLAYER
      				printBoard
      				limit=$( checkWinCondition )
        	else
      			printf Play by computer
     			printBoard
  		fi
		if [ $limit -eq 1 ]
		then
			echo "Player win"
		fi
  done
}

function checkWinCondition () {
	i=1
    	if [[ ( ${boardPosition[$i]} -eq $PLAYER ) && ( ${boardPosition[$(($i+1))]} -eq $PLAYER ) && ( ${boardPosition[$(($i+2))]} -eq $PLAYER ) ]]
    	then
      		echo 1
    	elif [[ ( ${boardPosition["$i+3"]} -eq $PLAYER ) && ( ${boardPosition["$i+4"]} -eq $PLAYER ) && ( ${boardPosition["$i+5"]} -eq $PLAYER ) ]]
    	then
      		echo 1
    	elif [[ ( ${boardPosition["$i+6"]} -eq $PLAYER ) && ( ${boardPosition["$i+7"]} -eq $PLAYER ) && ( ${boardPosition["$i+8"]} -eq $PLAYER ) ]]
    	then
      		echo 1
    	elif [[ ( ${boardPosition["$i"]} -eq $PLAYER ) && ( ${boardPosition["$i+3"]} -eq $PLAYER ) && ( ${boardPosition["$i+6"]} -eq $PLAYER ) ]]
    	then
      		echo 1
    	elif [[ ( ${boardPosition["$i+1"]} -eq $PLAYER ) && ( ${boardPosition["$i+4"]} -eq $PLAYER ) && ( ${boardPosition["$i+7"]} -eq $PLAYER ) ]]
    	then
      		echo 1
    	elif [[ ( ${boardPosition["$i+2"]} -eq $PLAYER ) && ( ${boardPosition["$i+5"]} -eq $PLAYER ) && ( ${boardPosition["$i+8"]} -eq $PLAYER ) ]]
    	then
      		echo 1
    	elif [[ ( ${boardPosition["$i"]} -eq $PLAYER ) && ( ${boardPosition["$i+4"]} -eq $PLAYER ) && ( ${boardPosition["$i+8"]} -eq $PLAYER ) ]]
    	then
      		echo 1
    	elif [[ ( ${boardPosition["$i+2"]} -eq $PLAYER ) && ( ${boardPosition["$i+4"]} -eq $PLAYER ) && ( ${boardPosition["$i+6"]} -eq $PLAYER ) ]]
    	then
      		echo 1
    	else
      		echo 0
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
