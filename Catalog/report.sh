#!/bin/bash
# Author: Cormac Costello
# Script used to generate reports, pleasing to the eye

FILE=$1 #accepts the file (in this case musictracks.csv) or any csv file delimited by "," 
header=`column -t -s '","' -T 20 $FILE | head -n 1` #parses csv file and displays first line as columns

echo -e "\e[21m\e[1m\e[95m$header\e[0m" # gives the header a nice purple colour and bold text
column -t -s '","' -T 20 $FILE | tail -n +2 # displays all but the header

echo
echo
sleep 1
echo "Main Menu: "
echo
echo "1) Add"
echo "2) Search"
echo "3) Remove"
echo "4) Generate Report"
echo "5) Quit"
echo
echo
