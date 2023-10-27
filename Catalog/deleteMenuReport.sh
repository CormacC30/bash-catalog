#!/bin/bash
# Author: Cormac Costello
# Script used to generate reports, pleasing to the eye

FILE=$1
header=`column -t -s '","' -T 20 $FILE | head -n 1` #takes header from first line of file

echo -e "\e[21m\e[1m\e[95m$header\e[0m" #gives the header a purple colour, bold text
column -t -s '","' -T 20 $FILE | tail -n +2 #displays the csv as neat columns

