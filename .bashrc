#!/bin/bash
# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
[ -z "$PS1" ] && return

# shopt configuration {{{
# don't put duplicate lines in the history. See bash(1) for more options
# ... or force ignoredups and ignorespace
HISTCONTROL=ignoredups:ignorespace
# append to the history file, don't overwrite it
shopt -s histappend
# recognize ** for recursive patterns
shopt -s globstar
# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize
# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=4000
HISTFILESIZE=10000
# }}}

export QUICKLY_EDITOR=vim
export RIPGREP_CONFIG_PATH=$HOME/.config/ripgreprc

# make less more friendly for non-text input files, see lesspipe(1)
export LESS="-R -M --shift 5"
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "$debian_chroot" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# setup colors {{{
color_is_on=
color_red=
color_green=
color_yellow=
color_blue=
color_white=
color_gray=
color_bg_red=
color_off=
if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
    color_is_on=true
    color_red="\[$(/usr/bin/tput setaf 1)\]"
    color_green="\[$(/usr/bin/tput setaf 2)\]"
    color_yellow="\[$(/usr/bin/tput setaf 3)\]"
    color_blue="\[$(/usr/bin/tput setaf 6)\]"
    color_white="\[$(/usr/bin/tput setaf 7)\]"
    color_gray="\[$(/usr/bin/tput setaf 8)\]"
    color_off="\[$(/usr/bin/tput sgr0)\]"
    color_error="\[$(/usr/bin/tput setab 1)\]\[$(/usr/bin/tput setaf 7)\]"
    color_error_off="\[$(/usr/bin/tput sgr0)\]"
fi
# }}}

vidstrip() {
    local fn=$1
    local start=$2
    local duration=$3
    ffmpeg -i "$fn" -an -ss "$start" -t "$duration" -s 890x270 out.mov
}

# Common aliases {{{
# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    [ -r ~/.dircolors ] && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# some more ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi
# }}}

# Global completion {{{
# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if [ -f /etc/bash_completion ] && ! shopt -oq posix; then
    . /etc/bash_completion
fi
# }}}

# One time C++ code compilation and run {{{
compileOnce ()
{
    local INFILE
    local OUTFILE
    local COMPILER

    COMPILER="$CXX"
    if [ -z "$COMPILER" ];
    then
        COMPILER=/usr/bin/g++
    fi

    local LOCAL_CFLAGS="$CFLAGS"
    while [ "$#" -gt "1" ];
    do
        LOCAL_CFLAGS="$LOCAL_CFLAGS $1"
        shift
    done
    INFILE="$(mktemp --tmpdir --suffix=.cpp)"
    OUTFILE="$(mktemp --tmpdir)"
    {
        cat <<EOF
#include <sstream>
#include <iostream>
#include <iomanip>
#include <map>
#include <list>
#include <vector>
#include <limits>
#include <bitset>
#include <stddef.h>
#include <string.h>
#include <set>
#include <math.h>
#include <ctime>
#include <limits.h>
#include <signal.h>
#include <unistd.h>
#include <exception>
#include <stdexcept>
#include <typeinfo>
#include <thread>
#include <sys/types.h>
#include <sys/socket.h>
#include <netdb.h>
#include <netinet/in.h>
#include <netinet/tcp.h>

int main(int argc, char **argv) {
    $1
    return 0;
}
EOF
    } >"$INFILE"
    "$COMPILER" -std=c++11 -O3 $LOCAL_CFLAGS -o "$OUTFILE" "$INFILE" -lrt -ldl
    "$OUTFILE"
    rm "$OUTFILE" "$INFILE"
}
# }}}

# VCS info methods {{{
make_vcs_status () {
    local vcs=$1
    local branch=$2
    local dirty=$3

    if [ ! -z "$branch" ];
    then
        if [ ! -z "$color_is_on" ]; then
            if [ -z "$dirty" ]; then
                echo " ($vcs: ${color_green}${branch}${color_off})"
            else
                echo " ($vcs: ${color_red}${branch}${color_off})"
            fi
        else
            echo " ($vcs: ${branch})"
        fi
    fi
}

parse_git_status () {
    # clear git variables
    local GIT_BRANCH
    local GIT_DIRTY
    local GIT_BIN
    local GIT_STATUS
    local CUR_DIR

    # exit if no git found in system
    GIT_BIN=$(which git 2>/dev/null)
    [ -z "$GIT_BIN" ] && return

    # check we are in git repo
    CUR_DIR="$PWD"
    while [ ! -d "${CUR_DIR}/.git" ] && [ ! -z "$CUR_DIR" ] && [ ! "$CUR_DIR" = "/" ]; do CUR_DIR=${CUR_DIR%/*}; done
    [ ! -d "${CUR_DIR}/.git" ] && return
    # get git branch
    GIT_BRANCH=$($GIT_BIN symbolic-ref -q --short HEAD 2>/dev/null)
    if [ -z "$GIT_BRANCH" ];
    then
        GIT_BRANCH=$($GIT_BIN describe --tags --exact-match 2>/dev/null)
        [ -z "$GIT_BRANCH" ] && return
        GIT_BRANCH="<tag>$GIT_BRANCH"
    fi
    [ -z "$GIT_BRANCH" ] && return

    # get git status
    GIT_STATUS=$($GIT_BIN status --porcelain 2>/dev/null)
    [ -n "$GIT_STATUS" ] && GIT_DIRTY=true

    make_vcs_status git "$GIT_BRANCH" "$GIT_DIRTY"
}

parse_hg_status () {
    local HG_BRANCH
    local HG_DIRTY
    local HG_BIN
    local HG_SUM

    HG_BIN=$(which hg 2>/dev/null)
    [ -z "$HG_BIN" ] && return

    HG_SUM=$(LANGUAGE=en LANG=C $HG_BIN summary 2>/dev/null)
    while read -r LINE;
    do
        case "$LINE" in
            branch*)
                [[ $LINE =~ branch:\ (.*) ]] && HG_BRANCH=${BASH_REMATCH[1]}
                ;;
            bookmarks*)
                [[ $LINE =~ bookmarks:\ (.*) ]] && HG_BRANCH=${BASH_REMATCH[1]}
                ;;
            commit*)
                [[ $LINE =~ \(clean\) && ! $LINE =~ unknown ]] \
                    || HG_DIRTY=true
                ;;
        esac
    done < <( echo "$HG_SUM" )

    make_vcs_status hg "$HG_BRANCH" "$HG_DIRTY"
}

parse_bzr_status () {
    local BZR_BIN
    local BZR_BRANCH
    local BZR_DIRTY

    BZR_BIN=$(which bzr 2>/dev/null)
    [ -z "$BZR_BIN" ] && return

    BZR_BRANCH=$($BZR_BIN nick 2>/dev/null)
    [ -n "$BZR_BRANCH" ] || return
    BZR_DIRTY="$($BZR_BIN st 2>/dev/null)"
    
    make_vcs_status bzr "$BZR_BRANCH" "$BZR_DIRTY"
}

# }}}

# Prompt {{{
prompt_command () {
    local RETCODE=$?
    local TIMESTAMP
    local PS1_VCS
    local color_user
    local UPPER_LINE
    local UPPER_LEN
    local fillsize
    local FILL

    # errno
    if [ $RETCODE -eq 0 ];
    then
        RETCODE="${color_green}${RETCODE}${color_off}"
    else
        RETCODE="${color_red}${RETCODE}${color_off}"
    fi
    
    # parse VCS status
    [ -z "$PS1_VCS" ] && PS1_VCS=$(parse_hg_status)
    [ -z "$PS1_VCS" ] && PS1_VCS=$(parse_git_status)
    [ -z "$PS1_VCS" ] && PS1_VCS=$(parse_bzr_status)
    
    TIMESTAMP="[$(date +'%Y-%m-%d %H:%M:%S')]"

    if $color_is_on; then
        # set user color
        case $(id -u) in
            0)
                color_user=$color_red
                ;;
            *)
                color_user=$color_green
                ;;
        esac
    fi

    UPPER_LINE="${USER}@${HOSTNAME}:${PWD}${PS1_VCS} ${TIMESTAMP}"
    UPPER_LEN=$(printf "%s" "$UPPER_LINE" | sed -r "s/\x1B\[([0-9]{1,2}(;[0-9]{1,2})?)?[m|K]//g" | wc -c | tr -d " ")
    # calculate fillsize
    fillsize=$((COLUMNS-UPPER_LEN-1))

    FILL=$color_gray
    while [ $fillsize -gt 0 ]; do FILL="${FILL}─"; fillsize=$((fillsize-1)); done
    FILL="${FILL}${color_off}"
    
    # set new color prompt
    PS1="${color_user}\u${color_off}@${color_yellow}\h${color_off}:${color_white}\w${color_off}${PS1_VCS} ${color_blue}${TIMESTAMP}${color_off} ${FILL}\n${RETCODE} ➜ "
}
PROMPT_COMMAND=prompt_command
# }}}

# {{{ Skynet
if [ -f "$HOME/.skynet_aliases" ]; then
    . "$HOME/.skynet_aliases"
fi
# }}}

# vim: ts=4 sts=4 sw=4 et fdm=marker:
