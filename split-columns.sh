#!/bin/bash
FILE=$1

#find position of 3rd column starting with CCC
padding=`cat $FILE | head -n1 | grep -aob 'CCC' | grep -oE '[0-9]+'`
paddingstr=`printf "%-${padding}s" ' '`

#set max length
maxcolsize=50
maxlen=$(($padding+$maxcolsize))

cat $FILE | while read line; do
#split the line only if it exceeds the desired length
if [[ ${#line} -gt $maxlen ]]; then
	echo "$line" | fmt -s -w$maxcolsize - | head -n1
	echo "$line" | fmt -s -w$maxcolsize - | tail -n+2 | sed "s/^/$paddingstr/"
else
	echo "$line";
fi
done
