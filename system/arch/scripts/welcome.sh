#!/bin/bash

# ANSI escape codes for formatting
BOLD="\e[1m"
RESET="\e[0m"
RED="\e[31m"
GREEN="\e[32m"
YELLOW="\e[33m"
BLUE="\e[34m"
MAGENTA="\e[35m"
CYAN="\e[36m"
WHITE="\e[37m"

display_title() {
    clear
    echo -e "${BOLD}${BLUE}"
    cat << EOF
         _   _    _____  ___    ___    _   _ 
 / \_/ \( ) ( )  (  _  )|  _ \ (  _ \ ( ) ( )
 |     || |/ /   | (_) || (_) )| ( (_)| |_| |
 | (_) ||   (    (  _  )|    / | |  _ |  _  |
 | | | || |\ \   | | | || |\ \ | (_( )| | | |
 (_) (_)( ) (_)  (_) (_)(_) (_)(____/ (_) (_)
        /(                                   
       (__)                                  

EOF
    echo -e "${RESET}"
}

display_title