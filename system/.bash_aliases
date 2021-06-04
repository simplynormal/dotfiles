#!/usr/bin/env bash

# Shortcuts
alias reload="command clear; exec zsh"
alias rr="rm -rf"

# Navigation
alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."
alias .....="cd ../../../.."
alias ......="cd ../../../../.."
alias ~="cd ~"
alias -- -="cd -"

# Directory listing/traversal
alias l="ls -hlsG --color=tty --group-directories-first --time-style=long-iso"
alias lt="l -tr"
alias ld="l -d */"
alias ll="l -A"
alias llt="lt -A"
alias lld="ld .*/"
alias lp="stat -c '%a %n' *"

# Python
alias va='if [[ ! -d "venv" && ! -L "venv" ]]; then; python3 -m venv ./venv; source ./venv/bin/activate; touch -a requirements.txt; pip install --upgrade pip setuptools wheel; else; source ./venv/bin/activate; fi;'
alias vx='deactivate'
alias pycclean='find . -name \*.pyc -type f -ls -delete'

# Django
alias djrun='find . -maxdepth 2 -name 'manage.py' -exec python "{}" runserver \;'
alias djsu='find . -maxdepth 2 -name 'manage.py' -exec python "{}" createsuperuser --email="owner@localhost.com" \;'
alias djmm='find . -maxdepth 2 -name 'manage.py' -exec python "{}" makemigrations \;'
alias djmig='find . -maxdepth 2 -name 'manage.py' -exec python "{}" migrate \;'
alias djsh='find . -maxdepth 2 -name manage.py -exec python "{}" shell \;'
alias djshp='find . -maxdepth 2 -name manage.py -exec python "{}" shell_plus \;'

# Copy with progress bar
alias cpv='rsync -ah --info=progress2'

# Undo a `git push`
alias undopush="git push -f origin HEAD^:master"

# List declared aliases, functions, paths
alias aliases="alias | sed 's/=.*//'"
alias functions="declare -f | grep '^[a-z].* ()' | sed 's/{$//'"
alias paths='echo -e ${PATH//:/\\n}'

# Enable aliases to be sudo’ed
alias sudo='sudo '

# Other
alias now='date +"%T"'
alias week='date +%V'
