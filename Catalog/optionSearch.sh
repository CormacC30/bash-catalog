#/bin/bash
# Author: Cormac Costello
# Description: display the options in the search menu
read word
case $word in
	[yY] | [yY][Ee][Ss] )
	echo "OK"
	;;
	[nN] | [Nn][Oo] )
        echo "You chose No,";
        exit 0 
        ;;
        *) echo "Invalid input"
        ;;
        esac
        echo
echo "1) CatalogID"
echo "2) Name"
echo "3) Album"
echo "4) Genre"
echo "5) Exit"
