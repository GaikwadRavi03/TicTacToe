#!/bin/bash

declare -a boardPosition

boardPosition[1]="X"
boardPosition[3]="X"
boardPosition[2]="X"


function checkWinCondition () {
	for (( a=1; a<=8; a++ ))
	do
		line=""
		i=1
		case $a in
			1 )
			line= echo "${boardPosition["$i"]}${boardPosition["$i+1"]}${boardPosition["$i+2"]}";;
			2 )
			line= echo "${boardPosition["$i+3"]}${boardPosition["$i+4"]}${boardPosition["$i+5"]}";;
			3 )
			line= echo "${boardPosition["$i+6"]}${boardPosition["$i+7"]}${boardPosition["$i+8"]}";;
			4 )
			line= echo "${boardPosition["$i"]}${boardPosition["$i+3"]}${boardPosition["$i+6"]}";;
			5 )
			line= echo "${boardPosition["$i+1"]}${boardPosition["$i+4"]}${boardPosition["$i+7"]}";;
			6 )
			line= echo "${boardPosition["$i+2"]}${boardPosition["$i+5"]}${boardPosition["$i+8"]}";;
			7 )
			line= echo "${boardPosition["$i"]}${boardPosition["$i+4"]}${boardPosition["$i+8"]}";;
			8 )
			line= echo "${boardPosition["$i+2"]}${boardPosition["$i+4"]}${boardPosition["$i+6"]}";;
		esac

			if [ $line -eq "XXX" ]
			then	
				echo 1
			elif [ $line -eq "OOO" ]
			then
				echo 0
			fi
	done
}

Ans=$( checkWinCondition )
echo $Ans

