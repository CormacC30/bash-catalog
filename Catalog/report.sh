#!/bin/bash
# Author: Cormac Costello
# Script used to generate reports on the music catalog, pleasing to the eye

FILE=$1 #accepts the file (in this case musictracks.csv) or any csv file delimited by "," 
header=`column -t -s '","' -T 20 $FILE | head -n 1` #parses csv file and displays first line as columns
#calculates numner of entries excluding the header
numRecord=`tail -n +2 "$1" | wc -l`
echo
echo "There are $numRecord total tracks in the music catalog"
echo
# Use awk to find the most popular artist and genre. 
#Solution courtesy of AI
popularArtist=`tail -n +2 "$1" | cut -d "," -f 3 | sort | uniq -c | sort -nr | head -1 | awk '{print $2}'`
popularGenre=`tail -n +2 "$1" | cut -d "," -f 5 | sort | uniq -c | sort -nr | head -1 | awk '{print $2}'`
echo
echo -e "\e[21m\e[1m\e[95m$header\e[0m" # gives the header a nice purple colour and bold text
column -t -s '","' -T 20 $FILE | tail -n +2 # displays all but the header
echo
echo
#most popular artist and genre
if [ $numRecord -gt 0 ]; then
    echo "Most popular artist: $popularArtist"
    echo "Most popular genre: $popularGenre"
fi
echo
sleep 0.5
echo "Main Menu: "
echo
echo "1) Add"
echo "2) Search"
echo "3) Remove"
echo "4) View Catalog"
echo "5) Quit"
echo
