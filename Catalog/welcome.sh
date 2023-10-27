#!/bin/bash
# Author: Cormac Costello
# Description: A shell script for computer systems, HDip in CS at SETU, 2023
echo "Hello $USER!"
sleep 0.5
echo
./artwork.sh
echo
catalog_file="musictracks.csv"
if [ -a "$catalog_file" ]; then #check if the file exists
        echo "Hooray!"
        echo
        echo "catalogue file exists"
else
        echo "Creating new catalogue"
        touch "$catalog_file"
        echo "\"Number\",\"Track Name\",\"Artist\",\"Album\",\"Genre\",\"Duration\"" >> "$catalog_file" # column headings appended to file
fi
echo "Please select from the following menu options"
echo
echo
PS3='Enter your choice: '
options=("Add" "Search" "Remove" "View Catalog" "Quit")
select opt in "${options[@]}"
do
	case $opt in
		"Add")
			echo "you chose to add a new record"
			./addRecord.sh
			;;
		"Search")
			echo "you chose to search for record(s)"
			./search.sh
			;;
		"Remove")
			echo "you chose to remove records"
			./removeRecord.sh
			;;
		"View Catalog")
			echo "you chose to generate a new report"
			./report.sh musictracks.csv
			;;
		"Quit")
			echo "are you sure you want to quit? (y/n)"
			read choice
			case $choice in
				[yY] | [yY][eE][sS] )
				echo "Quitting now"
				echo
				echo "Goodbye!"
				echo
				break
				;;
				[nN] | [nN][oO] )
				echo "Returning to Main Menu"
				;;
				*) echo "invalid input"
				;;
			esac
	esac
done
echo
echo
echo
echo
