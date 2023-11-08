#!/bin/bash

fold_input() {
    local input="$1"
    local max_length=20
    local folded_input=""
    while [ ${#input} -gt $max_length ]; do
        folded_input+="${input:0:$max_length}\n"  # Take the first 20 characters
        input="${input:$max_length}"              # Remove those characters from the input
    done
    folded_input+="$input"                       # Append the remaining characters
    echo -e "$folded_input"                      # Use -e to interpret '\n' as a newline
}

fold_input "$1"
