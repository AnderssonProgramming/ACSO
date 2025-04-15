#!/bin/sh
# Script to count lines in /etc/profile

# Clear the screen
clear

# Count the lines and print the result
line_count=$(wc -l < /etc/profile)
echo "El número de líneas del archivo /etc/profile es: $line_count"
