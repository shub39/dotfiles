#!/bin/bash

# Check if a file and line number are provided
if [[ $# -ne 2 ]]; then
    echo "Usage: $0 <file_path> <line_number>"
    exit 1
fi

FILE="$1"
LINE_NUMBER="$2"

# Check if the file exists
if [[ ! -f "$FILE" ]]; then
    echo "Error: File '$FILE' not found."
    exit 1
fi

# Read the specific line
LINE_CONTENT=$(sed "${LINE_NUMBER}q;d" "$FILE")

# Check if the line is already commented
if [[ "$LINE_CONTENT" =~ ^[[:space:]]*# ]]; then
    # Uncomment the line
    sed -i "${LINE_NUMBER}s/^#//" "$FILE"
    echo "Uncommented line $LINE_NUMBER in file '$FILE'."
else
    # Comment the line
    sed -i "${LINE_NUMBER}s/^/#/" "$FILE"
    echo "Commented line $LINE_NUMBER in file '$FILE'."
fi

