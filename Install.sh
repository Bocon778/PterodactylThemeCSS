#!/bin/bash

# Work In Progress
# This script is not intended to be ran as is.

if (( $EUID != 0 )); then
    echo "Please run as root"
    exit
fi

# Main installation function
installTheme(){
    cd /var/www/pterodactyl || {
        echo "Error: Pterodactyl directory not found"
        exit 1
    } 

    # Build steps
    npm i -g yarn
    yarn
    yarn build:production
    php artisan optimize:clear
}

while true; do
    clear
    echo "Bocon's Theme Installer"
    echo "--------------------"
    echo "[1] Install theme"
    echo "[2] Exit"
    
    read -p "Select an option: " choice
    case $choice in
        1)
            read -p "Install theme? [y/N] " confirm
            [[ $confirm == [yY] ]] && installTheme
            ;;
        2)
            exit 0
            ;;
        *)
            echo "Invalid option"
            sleep 2
            ;;
    esac
done