#!/usr/bin/env bash

if [[ $UID -eq 0 ]]; then
  echo "Looks like you are running this script as root"
  echo "Please run this script without root or sudo"
  echo "We will ask for your password when needed"
  exit 1
fi

function update_upgrade {
  if [[ "$1" == dnf ]]; then
    sudo dnf upgrade -y
  elif [[ "$1" == apt ]]; then
    sudo apt update
    sudo apt full-upgrade -y
  fi
}

function base_packages {
  basepkgs=(curl dos2unix git git-lfs htop less make man-db most
    nano openssl pinentry-tty rsync tmux tree wget)
  fun=(cowsay figlet fortune-mod)

  sudo "$1" install -y "${basepkgs[@]}" "${fun[@]}"
  gem install lolcat

  sudo update-alternatives --set pinentry "$(command -v pinentry-tty)"
}

function backup_gitconfig {
  if ! [[ -s ~/.gitconfig_local ]]; then
    cat ~/.gitconfig >>~/.gitconfig_local
  fi
}

function link_dotfiles {
  for DOTFILE in "$(pwd)"/{runcom,system}/.[a-z]*; do ln -s "$DOTFILE" ~; done
  for DOTFILE in $(
    cd $(pwd)/../git
    pwd
  )/.[a-z]*; do ln -s "$DOTFILE" ~; done
  for DOTFILE in $(
    cd $(pwd)/../ssh
    pwd
  )/*; do ln -s "$DOTFILE" ~/.ssh; done

  mkdir ~/.ssh/sockets
}

function main {
  update_upgrade "$@"
  base_packages "$@"
  bash ./packages/python_pyenv.sh "$@"
  bash ./packages/node_n.sh "$@"
  bash ./packages/zsh_prezto.sh "$@"
  backup_gitconfig "$@"
  link_dotfiles "$@"
  sudo "$1" autoremove -y
}

# https://www.gnu.org/software/bash/manual/html_node/Conditional-Constructs.html
while [[ $# -gt 0 ]]; do
  case "$1" in
  install | i | setup)
    if [[ -x "$(command -v apt)" ]]; then
      main apt
    elif [[ -x "$(command -v dnf)" ]]; then
      main dnf
    fi
    shift
    ;;
  *)
    shift
    ;;
  esac
done
