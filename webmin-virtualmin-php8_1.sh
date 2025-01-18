#!/bin/bash

# Function to check if the user is root
check_root() {
    if [ "$EUID" -ne 0 ]; then
        echo "This script must be run as root. Use 'sudo' to execute the script."
        exit 1
    fi
}

# Function to update and upgrade the system
update_and_upgrade() {
    echo "Updating and upgrading the system..."
    sudo apt update && sudo apt upgrade -y
    if [ $? -ne 0 ]; then
        echo "Error during update or upgrade. Please check your internet connection or package manager."
        exit 1
    fi
}

# Function to install Webmin
install_webmin() {
    echo "Do you want to install Webmin? (y/n)"
    read -r install_webmin_choice
    if [ "$install_webmin_choice" = "y" ]; then
        echo "Adding Webmin repository and key..."
        sudo sh -c 'echo "deb https://download.webmin.com/download/repository sarge contrib" > /etc/apt/sources.list.d/webmin.list'
        wget -q -O- http://www.webmin.com/jcameron-key.asc | sudo apt-key add -
        update_and_upgrade
        echo "Installing Webmin..."
        sudo apt install -y webmin
        if [ $? -eq 0 ]; then
            echo "Webmin installed successfully."
        else
            echo "Webmin installation failed."
        fi
    fi
}

# Function to install Virtualmin
install_virtualmin() {
    echo "Do you want to install Virtualmin? (y/n)"
    read -r install_virtualmin_choice
    if [ "$install_virtualmin_choice" = "y" ]; then
        echo "Installing Virtualmin..."
        sudo apt install -y wget software-properties-common apt-transport-https
        wget http://software.virtualmin.com/gpl/scripts/install.sh
        sudo sh install.sh
        if [ $? -eq 0 ]; then
            echo "Virtualmin installed successfully."
        else
            echo "Virtualmin installation failed."
        fi
    fi
}

# Function to install PHP 8.1 and extensions
install_php() {
    echo "Do you want to install PHP 8.1 and its extensions? (y/n)"
    read -r install_php_choice
    if [ "$install_php_choice" = "y" ]; then
        echo "Adding PHP repository and installing PHP 8.1 with extensions..."
        sudo add-apt-repository ppa:ondrej/php -y
        update_and_upgrade
        sudo apt install -y php8.1-{bcmath,common,xml,fpm,mysql,zip,intl,ldap,gd,cli,bz2,curl,mbstring,pgsql,opcache,soap,cgi,imap,mailparse}
        if [ $? -eq 0 ]; then
            echo "PHP 8.1 and extensions installed successfully."
        else
            echo "PHP installation failed."
        fi
    fi
}

# Function to install Composer
install_composer() {
    echo "Do you want to install Composer? (y/n)"
    read -r install_composer_choice
    if [ "$install_composer_choice" = "y" ]; then
        echo "Installing Composer..."
        php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');"
        EXPECTED_SIGNATURE=$(wget -q -O - https://composer.github.io/installer.sig)
        ACTUAL_SIGNATURE=$(php -r "echo hash_file('sha384', 'composer-setup.php');")

        if [ "$EXPECTED_SIGNATURE" != "$ACTUAL_SIGNATURE" ]; then
            echo "ERROR: Invalid installer signature"
            rm composer-setup.php
            exit 1
        fi

        php composer-setup.php --quiet
        RESULT=$?
        rm composer-setup.php

        if [ $RESULT -eq 0 ]; then
            sudo mv composer.phar /usr/local/bin/composer
            echo "Composer installed successfully."
        else
            echo "Composer installation failed."
        fi
    fi
}

# Main script execution
check_root
update_and_upgrade
install_webmin
install_virtualmin
install_php
install_composer

echo "All tasks completed."
