#!/bin/bash
#.zshrc 기준 


vscode() {
    echo "vscode"
    export PATH="\$PATH:/Applications/Visual Studio Code.app/Contents/Resources/app/bin"
    echo "code () { VSCODE_CWD="$PWD" open -n -b "com.microsoft.VSCode" --args $* ;}" >> ~/.zshrc
}

basic_setup() {
    brew_installed=`which brew`
    if [[ -z $brew_installed ]] ; then
        curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh > /dev/null
        echo " ✔ brew_install!"
    else
        brew update
        echo " ✔ brew_update!"
    fi

    brew_install git
    brew_install zsh
    brew_install node@16
    brew_install libpq
    echo 'export PATH="/opt/homebrew/opt/libpq/bin:$PATH"' >> ~/.zshrc
    export LDFLAGS="-L/opt/homebrew/opt/libpq/lib"
    export CPPFLAGS="-I/opt/homebrew/opt/libpq/include"
    export PKG_CONFIG_PATH="/opt/homebrew/opt/libpq/lib/pkgconfig"
    brew_install postgresql@15
    echo 'export PATH="/opt/homebrew/opt/postgresql@15/bin:$PATH"' >> ~/.zshrc
    export LDFLAGS="-L/opt/homebrew/opt/postgresql@15/lib"
    export CPPFLAGS="-I/opt/homebrew/opt/postgresql@15/include"
    export PKG_CONFIG_PATH="/opt/homebrew/opt/postgresql@15/lib/pkgconfig"
    brew services restart postgresql@15
    brew_install openjdk@11
    brew_install rbenv
    brew_install pipenv
    brew_install pre-commit
    brew_install tfenv
    brew_install awscli
    brew_install python@3.10
    brew_install --cask rectangle
    brew_install --cask docker
    brew install --cask tableplus

    if [[ -z `which rbenv` ]]; then
        setup_rbenv 3.1.2
    fi
}

brew_install() {
    if [[ $1 = '--cask' ]]; then
        local library=$2
        local is_installed=`brew list --versions --cask $library`
        
        if [[ -n $is_installed ]] ; then
            echo "already installed : $is_installed"
        else
            brew install --cask $library
            echo "✔ $library""_installed!"
        fi
    else
        local library=$1
        local is_installed=`brew list --versions $library`
        
        if [[ -n $is_installed ]] ; then
            echo "already installed : $is_installed"
        else
            brew install $library
            echo "✔ $library""_installed!"
        fi
    fi
}

setup_rbenv() {
    local version=$1
    echo 'export PATH="$HOME/.rbenv/bin:$PATH"' >> ~/.zshrc
    echo 'eval "$(rbenv init -)"' >> ~/.zshrc
    echo "rbenv install location : `which rbenv`"
    rbenv install $version
    echo "ruby $version installed!"
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
