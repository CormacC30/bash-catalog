#!/bin/bash
# Author: Cormac Costello. Student ID: 11399631
# Script for computer systems continuous assessment homework week 4
echo "Welcome $USER!"
echo

if [[ -e musictracks.csv ]]; # check if the employee.txt file exists and if not, create it
        then echo "catalog file exists"
        else touch "musictracks.csv" #creates a new employee.txt file
fi

numRec=`wc -l musictracks.csv | awk '{ print $1 }'` # finds number of employee records
if [ "$numRec" -eq 0 ]  #checks if there are records, if there are not, it exits the program (no search records required for this assignment)
        then echo "There are no records in our catalog"
        echo
        echo
        echo "Would you like to add a new record? (y/n)" # here we might execute another program that allows user to create records, but not in this exercise
        echo 
        read choice
            case $choice in

                [yY] | [yY][eE][sS] )
                        echo "Adding new music track"
                        /bin/bash ~/Assessment-1-Files/AddRecord/addTest.sh
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
        while [ "$numRec" -ge 1 ] # enters a loop that executes until the user chooses to exit
        do
                echo "Here is the full list of records:"
                echo
                cat musictracks.csv
                echo
                echo ----------------------------------------------------------------------
                echo
                echo
                echo "Would you like to search for a track by 1) catalogID 2) name 3) album 4) genre or 5) exit the program?" 
                echo
                                        #continue editing from here
                PS3="Please choose an option (must be a number) "
                select opt in CatalogID Name Album Genre Exit
                do
                        case $opt in
                                "CatalogID")
                                        echo "Please Enter the catalog number of the track that you wish to search for:"
                                        echo 
                                        echo "Must be a three digit number"
                                        read trackNum
                                        while ! [[ "$trackNum" =~ ^[0-9]{3}$ ]]; do
                                            echo "Invalid entry \"$trackNum\", please enter a three-digit number"
                                            read trackNum
                                        done
                                        trackNumExists=`grep $trackNum musictracks.csv | wc -l`
                                            if [ "$trackNumExists" -eq 0 ] 
                                                        then echo "This Track Number \"$trackNum\" does not exist in our records"
                                                        echo
                                                        echo "Please try again"
                                                        echo
                                                        echo --------------------------------------------------------
                                                        echo
                                                else
                                                        numRecords=`grep $trackNum musictracks.csv | wc -l`
                                                        echo "There are $numRecords tracks recorded in our records: "
                                                        grep $trackNum musictracks.csv | sed 's/;/ /g' 
                                                        echo
                                                        echo "Would you like to search again?"
                                                        echo                                            
                                            fi         
                                                        ;;                 

                                "Name" )
                                        echo "Please Enter the name of the track that you wish to search for:"
                                        echo
                                        read trackName
                                        nameExists=`grep -i $trackName musictracks.csv | wc -l`
                                                if [ "$nameExists" -eq 0 ]
                                                        then echo "This track \"$trackName\" does not exist in our records"
                                                        echo
                                                        echo "Please try again"
                                                        echo
                                                        echo --------------------------------------------------------
                                                        echo
                                                else
                                                        grep -i $empName employee.txt | awk sed 's/;/ /g'
                                                        
                                                fi
                                        echo
                                        echo "Would you like to search again?"
                                        echo
                                        echo
                                        sleep 1
                                        echo
                                        ;;
                                "Album" )
                                        echo "You chose to search by album"
                                        echo
                                        ;;
                                "Genre" )
                                        echo "You chose to search by Genre"
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
