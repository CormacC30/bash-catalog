#!/bin/bash
# Author: Cormac Costello
# Script that can be used to add a new music track to musictracks.txt
echo "Welcome $USER, get ready to add a new entry"
catalog_file="musictracks.txt"
if [ -e "$catalog_file" ]; then
    echo "Hooray!"
    echo
    echo "Catalog file exists"
else
    echo "Creating a new catalog"
    touch "$catalog_file"
    echo -e "Number\tTrack Name\tArtist\tAlbum\tGenre\tDuration" >> "$catalog_file" # Use tab as delimiter
fi

while true; do

    padNumber() {
        printf "%03d" "$1"
    }

    # Find the last catalog number and increment it
    numLines=$(wc -l "$catalog_file" | awk '{print $1}')
    if [ $numLines -gt 1 ]; then
        last_cat_number=$(tail -n 1 "$catalog_file" | awk -F'\t' '{gsub(/"/, "", $1); print $1}' | sed 's/^0*//')
    else
        last_cat_number=0
    fi

    next_cat_number=$((last_cat_number + 1))

    # Pad the number to three digits
    next_cat_num_pad=$(padNumber "$next_cat_number")

    echo "Your new track will have an auto-generated catalog number of: $next_cat_num_pad"

    read -p "Enter Track Name: " trackName

    read -p "Enter Artist: " artist

    read -p "Enter Album: " album

    read -p "Enter Genre: " genre

    validate_input() {
        local input="$1"
        if [[ "$input" =~ ^[0-9]+$ && "$input" -ge 0 && "$input" -le 59 && ${#input} -le 2 ]]; then
            return 0 # valid input
        else
            return 1 # invalid input
        fi
    }

    echo "Enter Duration"
    # Read and validate minutes
    while true; do
        read -p "minutes: " minutes
        if validate_input "$minutes"; then
            break # valid input, exit loop
        else
            echo "Invalid input. Please enter a number between 0 and 59"
        fi
    done

    # Read and validate seconds
    while true; do
        read -p "seconds: " seconds
        if validate_input "$seconds"; then
            break
        else
            echo "Invalid input. Please enter a number between 0 and 59"
        fi
    done

    padMinutes=$(printf "%02d" "$minutes")
    padSeconds=$(printf "%02d" "$seconds")

    duration=$(printf "$padMinutes:$padSeconds")

    echo -e "$next_cat_num_pad\t$trackName\t$artist\t$album\t$genre\t$duration" >> "$catalog_file"
    echo "Added successfully"
    echo
    echo "The Track you just added is:"
    echo
    head -n 1 "$catalog_file" | sed 's/\t/ /g' # Print the column headers using sed
    echo
    echo "Your full Catalogue:"
    echo
    echo
    ./splitColumns.sh "$catalog_file" # Assuming you have a separate script to format columns
    echo
    echo
    awk 'BEGIN {FS="\t"}{gsub(/"/, "", $0);
        if (NR == 1)    {
            printf "%-10s%-20s%-20s%-20s%-20s%-20s\n", $1, $2, $3, $4, $5, $6;
            printf "%-100s\n", "--------------------------------------------------------------------------------------------"
        }
        else printf "%-10s%-20s%-20s%-20s%-20s%-20s\n", $1, $2, $3, $4, $5, $6;}' "$catalog_file"
    echo
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
            echo "4) Generate Report"
            echo "5) Quit"
            break
            ;;
        *) echo "Invalid Input"
            echo "Please try again"
            ;;
    esac

done
