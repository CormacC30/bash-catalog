#!/bin/bash
# Author: Cormac Costello
# Description: A script which gives a nice column layout with the column headers to returned search results
# Video Demo: https://youtu.be/j1LPZSMR32w

# Takes the result from result.txt
header=`column -t -s '","' -T 20 result.txt | head -n 1`

echo -e "\e[21m\e[1m\e[95m$header\e[0m"
column -t -s '","' -T 20 result.txt | tail +2
