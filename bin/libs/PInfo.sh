#!/usr/bin/env bash

#
# libs: PInfo
#

# Defining variables.
    # This color requires special attention from the user.
green='\033[32m'
    # This color is used to display the process of script execution.
red='\033[31m'
    # This color is used to display additional information.
yellow='\033[33m'
    # Color End Flag.
reset='\033[0m'

PInfo() {
    case "$1" in
        "g" | "green")
            echo -e "$green $2 $reset"
        ;;
        "r" | "red")
            echo -e "$red $2 $reset"
        ;;
        "y" | "yellow")
            echo -e "$yellow $2 $reset"
        ;;
        *)
            echo -e "=> Parameter error."
        ;;
    esac
}
