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
HISTSIZE=10000
HISTFILESIZE=100000
# }}}

export QUICKLY_EDITOR=vim
export RIPGREP_CONFIG_PATH=$HOME/.config/ripgreprc

# make less more friendly for non-text input files, see lesspipe(1)
export LESS="-R -M --shift 5"
if [ -x /usr/bin/lesspipe ]
then
    if [ -z "$DEBUG_BASHRC" ]
    then
        export LESSOPEN="| /usr/bin/lesspipe %s"
        export LESSCLOSE="/usr/bin/lesspipe %s %s"
    else
        eval "$(SHELL=/bin/sh lesspipe)"
    fi
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
if [ -z "$DEBUG_BASHRC" ] && [ -t 1 ]
then
    color_is_on=true
    color_red='\[\e[0;31m\]'
    color_green='\[\e[0;32m\]'
    color_yellow='\[\e[0;33m\]'
    color_blue='\[\e[0;36m\]'
    color_white='\[\e[0;37m\]'
    color_gray='\[\e[0;90m\]'
    color_off='\[\e[0m\]'
    color_error='\[\e[41m\]\[\e[0;37m\]'
elif [ -x /usr/bin/tput ] && [ -t 1 ]
then
    echo "sourcing tput"
    color_is_on=true
    color_red="\[$(/usr/bin/tput setaf 1)\]"
    color_green="\[$(/usr/bin/tput setaf 2)\]"
    color_yellow="\[$(/usr/bin/tput setaf 3)\]"
    color_blue="\[$(/usr/bin/tput setaf 6)\]"
    color_white="\[$(/usr/bin/tput setaf 7)\]"
    color_gray="\[$(/usr/bin/tput setaf 8)\]"
    color_off="\[$(/usr/bin/tput sgr0)\]"
    color_error="\[$(/usr/bin/tput setab 1)\]\[$(/usr/bin/tput setaf 7)\]"
fi
# }}}

vidstrip() {
    if [ "$#" -lt 3 ]; then
        echo "Usage: vidstrip filename start duration"
        return
    fi
    local fn=$1
    local start=$2
    local duration=$3
    ffmpeg -i "$fn" -an -ss "$start" -t "$duration" -s 890x270 out.mov
}

# Common aliases {{{
# enable color support of ls and also add handy aliases
if [ -z "$DEBUG_BASHRC" ]
then
    LS_COLORS='rs=0:di=01;34:ln=01;36:mh=00:pi=40;33:so=01;35:do=01;35:bd=40;33;01:cd=40;33;01:or=40;31;01:mi=00:su=37;41:sg=30;43:ca=30;41:tw=30;42:ow=34;42:st=37;44:ex=01;32:*.tar=01;31:*.tgz=01;31:*.arc=01;31:*.arj=01;31:*.taz=01;31:*.lha=01;31:*.lz4=01;31:*.lzh=01;31:*.lzma=01;31:*.tlz=01;31:*.txz=01;31:*.tzo=01;31:*.t7z=01;31:*.zip=01;31:*.z=01;31:*.Z=01;31:*.dz=01;31:*.gz=01;31:*.lrz=01;31:*.lz=01;31:*.lzo=01;31:*.xz=01;31:*.zst=01;31:*.tzst=01;31:*.bz2=01;31:*.bz=01;31:*.tbz=01;31:*.tbz2=01;31:*.tz=01;31:*.deb=01;31:*.rpm=01;31:*.jar=01;31:*.war=01;31:*.ear=01;31:*.sar=01;31:*.rar=01;31:*.alz=01;31:*.ace=01;31:*.zoo=01;31:*.cpio=01;31:*.7z=01;31:*.rz=01;31:*.cab=01;31:*.wim=01;31:*.swm=01;31:*.dwm=01;31:*.esd=01;31:*.jpg=01;35:*.jpeg=01;35:*.mjpg=01;35:*.mjpeg=01;35:*.gif=01;35:*.bmp=01;35:*.pbm=01;35:*.pgm=01;35:*.ppm=01;35:*.tga=01;35:*.xbm=01;35:*.xpm=01;35:*.tif=01;35:*.tiff=01;35:*.png=01;35:*.svg=01;35:*.svgz=01;35:*.mng=01;35:*.pcx=01;35:*.mov=01;35:*.mpg=01;35:*.mpeg=01;35:*.m2v=01;35:*.mkv=01;35:*.webm=01;35:*.ogm=01;35:*.mp4=01;35:*.m4v=01;35:*.mp4v=01;35:*.vob=01;35:*.qt=01;35:*.nuv=01;35:*.wmv=01;35:*.asf=01;35:*.rm=01;35:*.rmvb=01;35:*.flc=01;35:*.avi=01;35:*.fli=01;35:*.flv=01;35:*.gl=01;35:*.dl=01;35:*.xcf=01;35:*.xwd=01;35:*.yuv=01;35:*.cgm=01;35:*.emf=01;35:*.ogv=01;35:*.ogx=01;35:*.aac=00;36:*.au=00;36:*.flac=00;36:*.m4a=00;36:*.mid=00;36:*.midi=00;36:*.mka=00;36:*.mp3=00;36:*.mpc=00;36:*.ogg=00;36:*.ra=00;36:*.wav=00;36:*.oga=00;36:*.opus=00;36:*.spx=00;36:*.xspf=00;36:'
    export LS_COLORS
elif [ -x /usr/bin/dircolors ]
then
    [ -r ~/.dircolors ] && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
fi
alias ls='ls --color=auto'
#alias dir='dir --color=auto'
#alias vdir='vdir --color=auto'

alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'
alias rgv='rg --vimgrep'

# some more ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

alias mypy='python3 -m mypy'
# }}}

# Global completion {{{
# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if [ -f /etc/bash_completion ] && ! shopt -oq posix; then
    . /etc/bash_completion
fi

# NOTE additional completions are stored in $HOME/.local/share/bash-completion/completions/*
# and it must be a directory, not symlink, or it would be skipped by bash.
# But you may symlink $HOME/.local/share/bash-completion/
# }}}

# One time C++ code compilation and run {{{
compileOnce ()
{
    local INFILE
    local OUTFILE
    local COMPILER

    if [ "$#" -eq "0" ]; then
        echo "Usage: compileOnce [CFLAGS]... CODE"
        return 1
    fi

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
#include <grp.h>
#include <byteswap.h>

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

# {{{ Skynet
if [ -f "$HOME/.skynet_aliases" ]; then
    . "$HOME/.skynet_aliases"
fi
# }}}

# Prompt {{{

# prerequisites:
#   cargo install starship
#   cargo install jql (for arc)
eval "$(starship init bash --print-full-init)"

# }}}

# vim: ts=4 sts=4 sw=4 et fdm=marker:
