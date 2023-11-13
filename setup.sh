#!/bin/bash

# TODO: стоит изучить bash скрипт и сделать это по-человечески 
# - (например не затирать логи, если это возможно используя dialog)
# - сценарий при использовании от рута

DOTFILESPATH=$(dirname "$(readlink -f "$0")")

# sudo apt update && sudo apt upgrade -y
# sudo apt install git stow -y

# sudo apt install dialog -y 
cmd=(dialog --separate-output --checklist "Please Select Software you want to install:" 22 76 16)
options=(
    1 "zsh" on
    2 "zoxide" on
    3 "fzf" on
    # 4 "flameshot" off
)
choices=$("${cmd[@]}" "${options[@]}" 2>&1 >/dev/tty)
clear
for choice in $choices
do
    case $choice in
        1)
        #Install zsh
        echo "Installing zsh"
        sudo apt install zsh -y
        rm -fv ~/.zsh*
        stow -d $DOTFILESPATH -R -v -t ~ zsh

        XDG_CONFIG_HOME=$HOME/.config
        ZDOTDIR="$XDG_CONFIG_HOME/zsh"
        curl -L git.io/antigen > $ZDOTDIR/antigen.zsh

        dialog --yesno "Make zsh the default shell?" 5 40
        if [[ $? -eq 0 ]]; then
            clear
            $(chsh -s $(which zsh))
        fi
        clear
        ;;

        2) 
        #Install zoxide
        echo "Installing zoxide"
        sudo apt install zoxide -y
        ;;

        3) 
        #Install fzf
        echo "Installing fzf"
        sudo apt install fzf -y
        ;;

        # 4) 
        # #Install flameshot
        # echo "Installing flameshot"
        # sudo apt install flameshot -y
        # ;;

    esac
done
