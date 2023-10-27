#!/bin/bash

# CSV file
csv_file="musictracks.csv"

numRec=`wc -l musictracks.csv | awk '{print $1}'` # finds number of employee records
if [ "$numRec" -eq 1 ]  #checks if there are records, if there are not, it exits the program (no search records required for this assignment)
        then echo "There are no records in our catalog"
        echo
        echo
        echo "Would you like to add a new record? (y/n)" # here we might execute another program that allows user to create records, but not in this exercise
        echo
        read choice
            case $choice in

                [yY] | [yY][eE][sS] )
                        echo "Adding new music track"
                        ./addRecord.sh
                        ;;
                [nN] | [nN][oO] )
                        echo "Not agreed"
                        break
                        ;;
                *) echo "Invalid Input"
                        echo "Please try again"
                        ;;
            esac
        exit 0
else

# Define a function to display search options
	echo "Your Search Options" 
	echo "Choose a number (1-7)"
	echo
	echo "	General Search	"
	echo --------------------------------
  	echo "1. Search by Keyword "
	echo --------------------------------
	echo
	echo
	echo "	Advanced Search	"
	echo --------------------------------
  	echo "2. Search by Catalog Number"
  	echo "3. Search by Track Name"
  	echo "4. Search by Artist"
  	echo "5. Search by Album"
  	echo "6. Search by Genre"
	echo
	echo --------------------------------
  	echo "7. Return to Main Menu"
	echo --------------------------------
	echo
while true; do
  read -p "Enter your choice (1-6) or 7 to exit: " choice
  case $choice in
    	        1)
                echo "Search by Keyword"
                read -p "Enter your search term: " search
                result=`tail +2 musictracks.csv | grep -i $search` # search all csv catalog, ignoring the header
                numResult=`tail +2 musictracks.csv | grep -i $search | wc -l` # return number of matching records
                if [ "$numResult" -eq 0 ]
                        then echo "There are no results matching your search"
                else
                        echo "There are $numResult track(s) matching \"$search\": "
                        echo
                        cat musictracks.csv | head -n 1 > result.txt
                        echo "$result" >> result.txt
                        ./resultReport.sh
                fi
                ;;
2)
      	echo "Search by Catalog Number"
	sleep 0.5
	echo "Must be a three digit number"
	sleep 0.5
	read -p "Enter the Catalog Number: " search
        while ! [[ "$search" =~ ^[0-9]{3}$ ]]; do
                echo "Invalid Entry, \"$search\", please enter a three digit number"
                read -p "Please Try Again: " search
        done
      result=`awk -F',' -v term="$search" 'substr($1, 2, 3) == term' "$csv_file"` #uses substr function to ensure the le>
      numResult=`awk -F',' -v term="$search" 'substr($1, 2, 3) == term' "$csv_file" | wc -l` # count the number of match>
        if [ "$numResult" -eq 0 ]
                then echo "This catalog Number does not exist, Try again"
        else
                echo "There are $numResult tracks matching \"$search\""
                cat musictracks.csv | head -n 1 > result.txt
                echo "$result" >> result.txt
                ./resultReport.sh
        fi
        ;;
    3)
	echo "Search by Track Name"
	sleep 0.5
	echo "Please Note, search is case sensitive"
	sleep 0.5
      read -p "Enter the Track Name: " search
        result=`awk -F',' -v term="$search" '$2 ~ term' "$csv_file"`
        numResult=`awk -F',' -v term="$search" '$2 ~ term' "$csv_file" | wc -l`
        if [ "$numResult" -eq 0 ]
                then echo "This track Name does not exist, please try again"
        else
                echo "There are $numResult tracks matching your search"
                cat musictracks.csv | head -n 1 > result.txt
                echo "$result" >> result.txt
                ./resultReport.sh
        fi
        ;;
    4)
	echo "Search by Artist"
        sleep 0.5
        echo "Please Note, search is case sensitive"
        sleep 0.5
      read -p "Enter the Artist: " search
        result=`awk -F',' -v term="$search" '$3 ~ term' "$csv_file"`
        numResult=`awk -F',' -v term="$search" '$3 ~ term' "$csv_file" | wc -l`
        if [ "$numResult" -eq 0 ]
                then echo "This artist does not exist, please try again"
        else
                echo "There are $numResult tracks matching your search"
                cat musictracks.csv | head -n 1 > result.txt
                echo "$result" >> result.txt
                ./resultReport.sh
        fi
      ;;
 5)
	echo "Search by Album"
        sleep 0.5
        echo "Please Note, search is case sensitive"
        sleep 0.5
      read -p "Enter the Album: " search
        result=`awk -F',' -v term="$search" '$4 ~ term' "$csv_file"`
        numResult=`awk -F',' -v term="$search" '$4 ~ term' "$csv_file" | wc -l`
        if [ "$numResult" -eq 0 ]
                then echo "This album does not exist, please try again"
        else
                echo "There are $numResult tracks matching your search"
                cat musictracks.csv | head -n 1 > result.txt
                echo "$result" >> result.txt
                ./resultReport.sh
        fi
      ;;
   6)
	echo "Search by Genre"
        sleep 0.5
        echo "Please Note, search is case sensitive"
        sleep 0.5
      read -p "Enter the Genre: " search
        result=`awk -F',' -v term="$search" '$5 ~ term' "$csv_file"`
        numResult=`awk -F',' -v term="$search" '$5 ~ term' "$csv_file" | wc -l`
        if [ "$numResult" -eq 0 ]
                then echo "This genre does not exist, please try again"
        else
                echo "There are $numResult tracks matching your search"
                cat musictracks.csv | head -n 1 > result.txt
                echo "$result" >> result.txt
                ./resultReport.sh
        fi
        ;;
	7)
		echo "Goodbye!"
      		echo "1) Add"
                echo "2) Search"
                echo "3) Remove"
                echo "4) Generate Report"
                echo "5) Quit"
		exit 0
      		;;
    	*)
      		echo "Invalid choice. Please enter a valid option (1-7)."
      		;;
  esac
echo "Would you like to search again? (y/n)"

read choice
case $choice in

        [yY] | [yY][eE][sS] )
                echo
		echo
		echo
		echo "You chose to search again"
                echo
		echo
        echo "Your Search Options" 
        echo "Choose a number (1-7)"
        echo
        echo "  General Search  "
        echo --------------------------------
        echo "1. Search by Keyword "
        echo --------------------------------
        echo
        echo
        echo "  Advanced Search "
        echo --------------------------------
        echo "2. Search by Catalog Number"
        echo "3. Search by Track Name"
        echo "4. Search by Artist"
        echo "5. Search by Album"
        echo "6. Search by Genre"
        echo
	echo --------------------------------
	echo "7. Return to Main Menu"
        echo --------------------------------
        echo
		echo
		echo
		;;
        [nN] | [nN][oO] )
                echo
		echo
              	echo "You chose No"
                sleep 1
                echo ---------------------------------------------------------------------
                echo "Returning to Main Menu"
                echo
                sleep 1
                echo "1) Add"
                echo "2) Search"
                echo "3) Remove"
                echo "4) Generate Report"
                echo "5) Quit"
                break
                ;;
        *) echo "Invalid Input"
                echo "Please try again"
                ;;

esac
done
fi
