#!/bin/sh
clear
find "$1" -type f -exec ls -l {} \; | grep "$2"