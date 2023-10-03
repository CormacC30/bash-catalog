#!/bin/bash
# Author: Cormac Costello
# Script that can be used to add a new festival record to festivals.csv
echo "Welcome $USER, get ready to add a new Festival record"
if [ -a festival.csv ]; then
    echo "festival.txt file exists"
else
    touch festival.csv
fi

echo "Please enter the festival catalogue number "
read catNum

while ! [[ "$empID" =~ ^[0-9]{3}$ ]]; do
    echo "Invalid entry \"$catNum\", please enter a three-digit number"
    read catNum
done

