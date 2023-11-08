#!/bin/bash
# Author: Cormac Costello
# Description: Script that can be used to add a new music track to musictracks.csv
# Video Demo: https://youtu.be/j1LPZSMR32w
clear
echo "Welcome $USER, get ready to add a new entry"
catalog_file="musictracks.csv"
if [ -a "$catalog_file" ]; then
	echo "Catalog File Exists!"
else
	echo "Creating new catalogue"
    	touch "$catalog_file"
	echo "\"Number\",\"Track Name\",\"Artist\",\"Album\",\"Genre\",\"Duration\"" >> "$catalog_file" # column headings appended to file
fi

while true; do
	#function to add leading zeros to number
	padNumber() {
		printf "%03d" "$1"
	}

	#find the last catalog number and increment it
	#Note: sed is used to ignore the leading zero's so the catalog number is treated as decimal rather than octal
	numLines=`wc -l musictracks.csv | awk '{print $1}'`
	if [ $numLines -gt 1 ]; then
		last_cat_number=`tail -n 1 "$catalog_file" | awk 'BEGIN {FS=","}{gsub(/"/, "", $1); print $1}' | sed 's/^0*//'`
	else
		last_cat_number=0
	fi

	next_cat_number=$((last_cat_number + 1))

	#pad the number to three digits
	next_cat_num_pad=$(padNumber "$next_cat_number")

	echo "Your new track will have auto-generated catalog number of: $next_cat_num_pad"

	read -p "Enter Track Name: " trackName

	read -p "Enter Artist: " artist

	read -p "Enter Album: " album

	read -p "Enter Genre: " genre

	# function to validate the input of the song duration, must be mm:ss, mm and ss no greater than 59
	validate_input() {
		local input="$1"
		if [[ "$input" =~ ^[0-9]+$ && "$input" -ge 0 && "$input" -le 59 && ${#input} -le 2 ]]; then
			return 0 # valid input
		else
			return 1 #invalid input
		fi
	}

	echo "Enter Duration"
	# read and validate minutes
	while true; do

		read -p "minutes: " minutes
		if validate_input "$minutes"; then
			break #valid input, exit loop
		else
			echo "Invalid input. Please enter a number between 0 and 59"
		fi
	done

	# read and validate seconds
	while true; do
		read -p "seconds: " seconds
		if validate_input "$seconds"; then
			break
		else
			echo "Invalid input. Please enter a number between 0 and 59"
		fi
	done

	padMinutes=`printf "%02d" "$minutes"` #adds leading zeros to the minutes input if less than 10
	padSeconds=`printf "%02d" "$seconds"` #adds leading zeros to seconds if less than 10

	duration=`printf "$padMinutes:$padSeconds"` #stitches the two together to give the duration in mm:ss
	echo
	echo
	echo "You have entered:"
	echo "Catalog Number: $next_cat_num_pad, Track Name: $trackName, Artist: $artist, Album: $album, Genre: $genre, Duration: $duration"
	echo
	echo "Are you sure these details are correct? (y/n) "
	read choice
	case $choice in

			[yY] | [yY][eE][sS] )
					echo "Agreed"
					echo
					echo "\"$next_cat_num_pad\",\"$trackName\",\"$artist\",\"$album\",\"$genre\",\"$duration\"" >> "musictracks.csv" #append new track to the csv
					echo "Added successfully"
					echo
					echo "The Track you just added is:"
					echo
					headings=`column -t -s '","' musictracks.csv | head -n 1` # print the column headers
					echo -e "\e[1m\e[21m$headings \e[0m"
					column -t -s '","' musictracks.csv | tail -n 1 # print just last line
					echo
					;;
			[nN] | [nN][oO] )
					echo "You chose No"
					sleep 1
					echo ---------------------------------------------------------------------
					echo "Please try again"
					;;
			*) echo "Invalid Input"
					echo "Please try again"
					;;

	esac
	echo
	echo "Would you like to add another track? (y/n) "
	read choice
	case $choice in

			[yY] | [yY][eE][sS] )
					echo "Agreed"
					;;
			[nN] | [nN][oO] )
					echo "You chose No"
			sleep 1
			echo ---------------------------------------------------------------------
			echo "Returning to Main Menu"
			echo
			sleep 1
			echo "1) Add"
			echo "2) Search"
			echo "3) Remove"
			echo "4) View Catalog"
			echo "5) Quit"
					break
					;;
			*) echo "Invalid Input"
					echo "Please try again"
					;;

	esac

done
