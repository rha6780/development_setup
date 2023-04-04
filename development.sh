#!/bin/bash

all() {
    basic_setup
    vscode
}


vscode() {
    echo "vscode"
    export PATH="\$PATH:/Applications/Visual Studio Code.app/Contents/Resources/app/bin"
    echo "code () { VSCODE_CWD="$PWD" open -n -b "com.microsoft.VSCode" --args $* ;}" >> ~/.zshrc
}

basic_setup() {
    brew_installed=`which brew`
    if [[ -z $brew_installed ]] ; then
        # Install Homebrew
        curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh > /dev/null
        echo " ✔ brew_install!"
    else
        brew update
        echo " ✔ brew_update!"
    fi


    brew_install git
    brew_install zsh
    brew_install --cask rectangle
    brew_install rbenv
}

brew_install() {
    local library=$1
    local is_installed=`brew list --versions $library`
    
    if [[ -n $is_installed ]] ; then
        echo "already installed : $is_installed"
    else
        brew install $library
        echo "✔ $library_installed!"
    fi
}

command=$1
echo "Start Development Setup!"
echo "========================"
echo "Warning : you should install Vscode to installing Extensions"
echo $command
if [[ $command == "basic" ]]; then
    basic_setup

elif [[ $command == "all" ]]; then
    all

elif [[ $command == "vscode" ]]; then
    vscode
else
    echo "else!"
fi

echo "========================"
echo "END! Enjoy your programming!"
