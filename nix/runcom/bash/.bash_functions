#!/usr/bin/env bash

# Copy but fancier
function cpv() {
  rsync -pogbr -hhh --backup-dir=/tmp/rsync -e /dev/null --progress "$@"
}

# VSCode
if [[ -x "$(command -v code-insiders)" ]]; then
  VSCODE=code-insiders
else
  VSCODE=code
fi
if [[ -n "$VSCODE" ]] && ! command -v $VSCODE &>/dev/null; then
  echo "'$VSCODE' flavour of VS Code not detected."
  unset VSCODE
fi

# Otherwise, try to detect a flavour of VS Code.
if [[ -z "$VSCODE" ]]; then
  if command -v code &>/dev/null; then
    VSCODE=code
  elif command -v code-insiders &>/dev/null; then
    VSCODE=code-insiders
  elif command -v codium &>/dev/null; then
    VSCODE=codium
  else
    return
  fi
fi

alias vsc='$VSCODE .'
alias vsca='$VSCODE --add'
alias vscd='$VSCODE --diff'
alias vscg='$VSCODE --goto'
alias vscn='$VSCODE --new-window'
alias vscr='$VSCODE --reuse-window'
alias vscw='$VSCODE --wait'
alias vscu='$VSCODE --user-data-dir'

alias vsced='$VSCODE --extensions-dir'
alias vscie='$VSCODE --install-extension'
alias vscue='$VSCODE --uninstall-extension'

alias vscv='$VSCODE --verbose'
alias vscl='$VSCODE --log'
alias vscde='$VSCODE --disable-extensions'

# Colored man pages
man() {
  env \
    LESS_TERMCAP_mb="$(printf "\e[31m")" \
    LESS_TERMCAP_md="$(printf "\e[93m")" \
    LESS_TERMCAP_me="$(printf "\e[0m")" \
    LESS_TERMCAP_so="$(printf "\e[1;40;92m")" \
    LESS_TERMCAP_se="$(printf "\e[0m")" \
    LESS_TERMCAP_us="$(printf "\e[36m")" \
    LESS_TERMCAP_ue="$(printf "\e[0m")" \
    man "$@"
}

# `tre` is a shorthand for `tree` with hidden files and color enabled, ignoring
# the `.git` directory, listing directories first. The output gets piped into
# `less` with options to preserve color and line numbers, unless the output is
# small enough for one screen.
function tre {
  tree -aC -I '.git|node_modules|bower_components' --dirsfirst "$@" | less -FRNX
}

# Create a new directory and enter it
function mkd {
  # shellcheck disable=SC2164
  mkdir -p "$@" && cd "${@: -1:1}"
  # Next to last ${@: -2:1}
  # The space is important
}

# cd then ls
function cl {
  DIR="$*"
  # if no DIR given, go home
  if [[ $# -lt 1 ]]; then
    DIR=$HOME
  fi
  builtin cd "${DIR}" &&
    # use your preferred ls command
    ls -lFhv --color=auto --group-directories-first
}

# Determine size of a file or total size of a directory
function fs {
  local arg=-sbh
  if [[ -n "$*" ]]; then
    du $arg -- "$@"
  else
    du $arg .[^.]* -- *
  fi
}
