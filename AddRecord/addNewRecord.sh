#!/bin/bash
# Author: Cormac Costello
# Script that can be used to add a new festival record to festivals.csv
echo "Welcome $USER, get ready to add a new Festival record"
if [ -a festival.txt ]; then
    echo "festival.txt file exists"
else
    touch festival.txt
fi

echo "Please enter the festival catalogue number "
read catNum

while ! [[ "$catNum" =~ ^[0-9]{3}$ ]]; do
    echo "Invalid entry \"$catNum\", please enter a three-digit number"
    read catNum
done

numExists=`grep '^$catNum' festival.txt | wc -l`
if [ $numExists -ne 0 ]; then
	echo "A festival with this catalog number already exists"
	echo "Please enter a different catalog number"
	read catNum
else
	echo "Your catalogue number is: $catNum"
fi

echo "Please enter the festival name"
read festName
echo "Please enter the festival type"
read festType
echo "Please enter the festival location"
read festLocation

while true; do
    echo "Please enter the employee's salary in €"
    read salary
    if [[ "$salary" =~ ^[0-9]+$ ]]; then
        break
    else
        echo "Invalid entry \"$salary\", please enter a number"
    fi
done

# Create a single line with all the details and append it to the file
festival_record="$catNum $festName $festType $festLocation €$salary"
echo "$festival_record" >> festival.txt

echo "Festival record added successfully:"
echo "$festival_record"

