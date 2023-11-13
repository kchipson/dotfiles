#!/usr/bin/env zsh

###############################
# EXPORT ENVIRONMENT VARIABLE #
###############################

export DOTFILES="$HOME/.dotfiles"
export WALLPAPERS_PATH="$HOME/.wallpapers"

export TERM="xterm-256color" # This sets up colors properly
export TERMINAL=alacritty

# set shell
export SHELL=/usr/bin/zsh


# XDG
export XDG_CONFIG_HOME=$HOME/.config
export XDG_DATA_HOME=$HOME/.local/share
export XDG_CACHE_HOME=$HOME/.cache


# zsh
export HISTFILE="$XDG_CACHE_HOME/.zhistory"    # History filepath
export HISTSIZE=10000                          # Maximum events for internal history
export SAVEHIST=10000                          # Maximum events in history file


# editor
export VISUAL=vim
export PAGER=more


# PATH
typeset -U path
export PATH="$HOME/bin:$HOME/.local/bin:$PATH[@]"

#Antigen

export ADOTDIR="$XDG_CACHE_HOME/.antigen"
# export ANTIGEN_LOG=""