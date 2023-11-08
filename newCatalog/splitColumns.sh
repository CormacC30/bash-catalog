#!/bin/bash
FILE=$1

# Define the maximum column width
maxcolsize=20

# Process the tab-delimited text file
while IFS=$'\t' read -r -a fields; do
    for field in "${fields[@]}"; do
        while [ -n "$field" ]; do
            wrapped_field="${field:0:$maxcolsize}"
            printf "%-20s" "$wrapped_field"
            field="${field:$maxcolsize}"
        done
    done
    printf "\n"
done < "$FILE"
