#!/bin/bash
# Author: Cormac Costello
# Script that can be used to add a new festival record to festivals.csv
echo "Welcome $USER, get ready to add a new Festival record"
if [ -a festival.csv ]; then
    echo "festival.txt file exists"
else
    touch festival.csv
fi

echo "Generating a new festival catalog Number: "
numRecord=`tail -n1 festival.csv | awk '{ print $1 }'`

if [ numRecord -eq 0 ]; then
catNum=000
else
catNum=($numRecord + 1)
fi

echo "$catNum"

while ! [[ "$festName" =~ ^[0-9]{3}$ ]]; do
    echo "Invalid entry \"$empID\", please enter a three-digit number"
    read empID
done

echo "Please enter the employee name"
read empName
echo "Please enter the employee's role"
read empRole
echo "Please enter the employee's Department"
read empDept

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
employee_record="$empID $empName $empRole $empDept €$salary"
echo "$employee_record" >> employee.txt

echo "Employee record added successfully:"
echo "$employee_record"

