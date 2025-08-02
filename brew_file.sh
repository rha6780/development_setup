#!/bin/bash


echo "기본 HomeBrew 를 설치한다."
brew_installed=`which brew`
    if [[ -z $brew_installed ]] ; then
        curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh > /dev/null
        echo " ✔ brew_install!"
    else
        brew update
        echo " ✔ brew_update!"
    fi

echo "================================================================="

echo "설치할 항목을 선택하세요:"
echo "1) Base : 개발 기본 터미널, Git, 컴퓨터 리소스, Ractangle 등 유용한 툴 리스트"

read -p "선택 (예: 1 2): " selections
echo "================================================================="
for sel in $selections; do
  case $sel in
    1) brew bundle --file=./brewfile/Brewfile.base ;;
  esac
done

