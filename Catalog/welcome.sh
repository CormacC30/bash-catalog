#!/bin/bash
# Author: Cormac Costello
# Description: A shell script for computer systems, HDip in CS at SETU, 2023
echo "Hello $USER!"
sleep 1
echo "Welcome to.."
echo
echo M   M  U   U  SSSS  III  CCC       PPPP    A   L
echo MM MM  U   U  S      I  C  C       P   P  A A  L
echo M M M  U   U  SSS    I  C          PPPP  AAAAA L
echo M   M  U   U     S   I  C  C       P     A   A L
echo M   M   UUU   SSSS  III  CCC       P     A   A LLLLL

echo -----------------------------------------------------------------------
echo
echo "Please select from the following menu options"
echo
PS3='Enter your choice: '
options=("Add" "Search" "Remove" "Generate Report" "Quit")
select opt in "${options[@]}"
do
	case $opt in
		"Add")
			echo "you chose to add a new record"
			/bin/bash addRecord.sh
			;;
		"Search")
			echo "you chose to search for record(s)"
			/bin/bash searchRecords.sh
			;;
		"Remove")
			echo "you chose to remove records"
			/bin/bash removeRecord.sh
			;;
		"Generate Report")
			echo "you chose to generate a new report"
			;;
		"Quit")
			echo "are you sure you want to quit? (y/n)"
			read choice
			case $choice in
				[yY] | [yY][eE][sS] )
				echo "Quitting now"
				break
				;;
				[nN] | [nN][oO] )
				echo "ok not quitting"
				;;
				*) echo "invalid input"
				;;
			esac
	esac
done
