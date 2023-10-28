#!/bin/bash
# Author: Cormac Costello
# A script to delete records from the catalog
echo "Get Ready to delete some records"
echo
while true; do
	echo "Would you like to view the full catalog?"
	echo "Y/N"
	read opt
	case $opt in

	[yY] | [yY][eE][sS])
		./deleteMenuReport.sh musictracks.csv #displays the catalog (without menu options)
		;;
	[nN] | [nN][oO])
		echo "You chose No"
		;;
	*)
		echo "Invalid Input"
		echo "Please try again"
		;;
	esac

	echo "Search for the record(s) you would like to delete"
	read -p "Enter your search term: " search
	result=`tail +2 musictracks.csv | grep -i $search`            # search all csv catalog, ignore case
	numResult=`tail +2 musictracks.csv | grep -i $search | wc -l` # return number of music tracks
	if [ "$numResult" -eq 0 ]; then                                #
		echo "There are no results matching your search"
		echo
		echo
	elif [ $numResult -gt 1 ]; then #gives the user options if the number of matching tracks are greater than one
		echo "There are $numResult track(s) that match \"$search\": "
		echo
		cat musictracks.csv | head -n 1 >result.txt
		echo "$result" >>result.txt
		./resultReport.sh

		echo "Would you like to delete: "
		echo "1. All of these tracks?"
		echo "2. Individual track?"
		echo "3. Return to Main Menu"
		echo
		read -p "Enter your choice (1-3)" choice
		case $choice in
		1)
			echo
			echo "Are you sure? (y/n)"
			read option
			case $option in

			[yY] | [yY][eE][sS])
				echo "Deleting Tracks"
				sed -i "/$search/d" musictracks.csv # deletes all of the tracks with matching search term, case insensitive
				;;
			[nN] | [nN][oO])
				echo "You chose No"
				sleep 1
				echo "Returning to Main Menu"
				echo "1) Add"
				echo "2) Search"
				echo "3) Remove"
				echo "4) View Catalog"
				echo "5) Quit"
				exit 0
				;;
			*)
				echo "Invalid Input"
				echo "Please try again"
				;;
			esac
			;;
		2)
			echo
			echo
			echo "Type the catalog number of the track that you would like to delete"
			echo
			echo "Must be a three digit number"
			echo
			read catNum
			
			while ! [[ "$catNum" =~ ^[0-9]{3}$ ]]; do # checks to see if the user inputs a three digit number
				echo "Invalid Entry, \"$catNum\", please enter a three digit number"
				read catNum
			done

			if grep -q "^\"$catNum\"," musictracks.csv; then # uses grep as a condition, checks the file for the catalog number without sending anything to standard output
				echo "Catalog number $catNum exists in the file."
				echo
				echo "Are you sure you want to delete this track? (y/n)"
				read choice
				case $choice in

				[yY] | [yY][eE][sS])
					echo "Deleting Track $catNum"
					sed -i "/\"$catNum\"/d" musictracks.csv # will delete the track of matching catalog number
					echo
					sleep 1
					echo "track deleted"
					;;
				[nN] | [nN][oO])
					echo "You chose No"
					sleep 1
					echo "Returning to Main Menu"
					echo
					echo "1) Add"
					echo "2) Search"
					echo "3) Remove"
					echo "4) View Catalog"
					echo "5) Quit"
					exit 0
					;;
				*)
					echo "Invalid Input"
					echo "Please try again"
					exit 0
					;;

				esac
			else
				echo "Catalog Number $catNum does not exist in this catalog"
			fi
			;;
		3)
			echo "Returning to Main Menu"
			echo
			echo "1) Add"
			echo "2) Search"
			echo "3) Remove"
			echo "4) View Catalog"
			echo "5) Quit"
			exit 0
			;;
		*)
			echo "Invalid Input, please try again"
			;;
		esac
	else 		# this only executes if the number of matches to the search is 1.
		echo "There is $numResult Record matching this search: " #if there are matching results
		echo										#the user can then delete all the results, or one of their choosing
		echo
		cat musictracks.csv | head -n 1 >result.txt # to avoid having over-stretched columns, the header and result are
		echo "$result" >>result.txt					# appended to a separate file, and the 	 
		./resultReport.sh							# report is generated from here using this resultReport script
		echo
		echo "Delete the record? (Y/N)"
		read option
		case "$option" in
		[yY] | [yY][eE][sS])
			echo "Deleting Track $result"
			echo
			sed -i "/$search/d" musictracks.csv
			echo
			sleep 1
			echo "Record deleted"
			;;
		[nN] | [nN][oO]) # if you choose no, get shown the main menu again
			echo "You chose No"
			sleep 1
			echo "Returning to Main Menu"
			echo
			echo
			echo "1) Add"
			echo "2) Search"
			echo "3) Remove"
			echo "4) View Catalog"
			echo "5) Quit"
			echo
			exit 0
			;;
		*)
			echo "Invalid Input, please try again"
			;;
		esac
	fi
	echo "Would you like to search again? (Y/N)"
	read choice
	case $choice in

	[yY] | [yY][eE][sS])
		echo "You chose.. Yes"
		;;
	[nN] | [nN][oO])
		echo "You chose No"
		sleep 1
		echo ---------------------------------------------------------------------
		echo "Returning to Main Menu"
		echo
		echo "1) Add"
		echo "2) Search"
		echo "3) Remove"
		echo "4) View Catalog"
		echo "5) Quit"
		break
		;;
	*)
		echo "Invalid Input"
		echo "Please try again"
		;;

	esac
done
