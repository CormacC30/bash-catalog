#!/bin/bash
# Author: Cormac Costello. Student ID: 11399631
# Script for computer systems continuous assessment homework week 4
echo "Welcome $USER!"
echo

if [ -a employee.txt ]; # check if the employee.txt file exists and if not, create it
        then echo "employee.txt file exists"
        else touch employee.txt #creates a new employee.txt file
fi
numEmp=`wc -l employee.txt | awk '{print $1}'` # finds number of employee records
if [ "$numEmp" -eq 0 ]	#checks if there are records, if there are not, it exits the program (no search records required for this assignment)
	then echo "There are no employee records"
	echo
	echo
	echo "Exiting program...byeee!" # here we might execute another program that allows user to create records, but not in this exercise
	exit 0
else
	while [ "$numEmp" -ne 0 ] # enters a loop that executes until the user chooses to exit
	do
		echo "Here is the full list of employee records:"
		echo
		cat employee.txt
		echo
		echo ----------------------------------------------------------------------
		echo
		echo
		echo "Would you like to 1) search for an employee record by name or 2) exit the program?" 
		echo
		echo
		PS3="Please choose an option (must be a number) "
		select opt in Search Exit
		do
			case $opt in
				"Search" )
					echo "Please Enter the name of the employee that you wish to search for:"
					echo
					read empName
					empExists=`grep -i $empName employee.txt | wc -l`
						if [ "$empExists" -eq 0 ]
							then echo "This employee \"$empName\" does not exist in our records"				
							echo
							echo "Please try again"
							echo
							echo --------------------------------------------------------
							echo
						else
							grep -i $empName employee.txt | awk '{print "The expenses recorded for " $2 " are: " $5 }'
						fi
					echo
					echo "Would you like to search again?"
					echo
					echo
					sleep 1
					echo "Select 1) for Yes and 2) to exit"
					echo
					;;
				"Exit" )
					echo "You chose to exit the program. Bye!"
					sleep 1
					echo
					echo "Bye bye!"
					exit 0
					;;
				*)
					echo "Invalid option, Please try again"
					echo
					sleep 1
					echo
					echo
					;;
			esac
		done
	done
fi
