#!/bin/bash
# Author: Cormac Costello
# A script to delete records from the catalog
echo "Get Ready to delete some records"
echo
while true; do
echo "Would you like to view the full catalog?"
echo "Y/N"
read opt
                case $opt in

                [yY] | [yY][eE][sS] )
                        ./deleteMenuReport.sh musictracks.csv
                        ;;
                [nN] | [nN][oO] )
                        echo "You chose No"
                        ;;
                *) echo "Invalid Input"
                        echo "Please try again"
                        ;;

                esac

                echo "Search for the record(s) you would like to delete"
                read -p "Enter your search term: " search
                result=`tail +2 musictracks.csv | grep -i $search` # search all csv catalog, ignore case
                numResult=`tail +2 musictracks.csv | grep -i $search | wc -l` # return number of music tracks
                if [ "$numResult" -eq 0 ] #
                        then echo "There are no results matching your search"
			echo
			echo
		elif [ $numResult -gt 1 ]; then
                        echo "There are $numResult track(s) that match \"$search\": "
                        echo
                        cat musictracks.csv | head -n 1 > result.txt
                        echo "$result" >> result.txt
                        ./resultReport.sh

			echo "Would you like to delete: "
			echo "1. All of these tracks?"
			echo "2. Individual track?"
			echo "3. Return to Main Menu"
			echo
			read -p "Enter your choice (1-3)" choice
			case $choice in
			1)
				echo
				echo "Are you sure? (y/n)"
        			read option
                		case $option in

                			[yY] | [yY][eE][sS] )
                        		echo "Deleting Tracks"
                        		sed -i "/$search/d" musictracks.csv # this doesn't work 
                        		;;
			                [nN] | [nN][oO] )
                        		echo "You chose No"
                        		sleep 1
                        		echo "Returning to Main Menu"
           				                echo "1) Add"
                echo "2) Search"
                echo "3) Remove"
                echo "4) Generate Report"
                echo "5) Quit"
					exit 0
                        		;;
                			*)
					echo "Invalid Input"
	                       		echo "Please try again"
					;;
                		esac
				;;
			2)
				echo
				echo
				echo "Type the catalog number of the track that you would like to delete"
				echo
				echo "Must be a three digit number"
				echo
				read catNum
				catNumExists=`awk -F"," -v term="$catNum" '$1 == term' musictracks.csv`

				while ! [[ "$catNum" =~ ^[0-9]{3}$ ]]; do
        				echo "Invalid Entry, \"$catNum\", please enter a three digit number"
        				read catNum
				done

				if grep -q "^\"$catNum\"," musictracks.csv; then
			        	echo "Catalog number $catNum exists in the file."
        				echo "Are you sure you want to delete this track? (y/n)"
        				read choice
                			case $choice in

               	 			[yY] | [yY][eE][sS] )
                        			echo "Deleting Track $catNum"
                        			sed -i "/\"$catNum\"/d" musictracks.csv
						echo
						sleep 1
                        			echo "track deleted"
						;;
                			[nN] | [nN][oO] )
                        			echo "You chose No"
                        			sleep 1
                        			echo "Returning to Main Menu"
                        			echo
                        			exit 0
                        			;;
                			*)
						echo "Invalid Input"
                        			echo "Please try again"
                        			exit 0
        	                		;;

                			esac
				else
       		 			echo "Catalog Number $catNum does not exist in this catalog"
				fi
				;;
			3)
                    echo "Returning to Main Menu"
                    echo
                echo "1) Add"
                echo "2) Search"
                echo "3) Remove"
                echo "4) Generate Report"
                echo "5) Quit"
                    exit 0
                    ;;
                *)
                    echo "Invalid Input, please try again"
                    ;;
            esac
	else
		echo "There are $numResult Records matching this search: "
		echo
		echo
	        cat musictracks.csv | head -n 1 > result.txt
                echo "$result" >> result.txt
                ./resultReport.sh
		echo
		echo "Delete the record? (Y/N)"
		read option
            case "$option" in
                [yY] | [yY][eE][sS] )
                    echo "Deleting Track $result"
                    echo
			sed -i "/$search/d" musictracks.csv
			echo
			sleep 1
			echo "Record deleted"
                    ;;
                [nN] | [nN][oO] )
                    echo "You chose No"
                    sleep 1
                    echo "Returning to Main Menu"
		echo
                    echo
                echo "1) Add"
                echo "2) Search"
                echo "3) Remove"
                echo "4) Generate Report"
                echo "5) Quit"
		echo
                    exit 0
                    ;;
                *)
                    echo "Invalid Input, please try again"
                    ;;
            esac
	fi
echo "Would you like to search again? (Y/N)"
read choice
case $choice in

        [yY] | [yY][eE][sS] )
                echo "You chose.. Yes"
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
