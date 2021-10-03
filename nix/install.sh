#!/usr/bin/env bash

if [[ $UID -eq 0 ]]; then
  echo "Looks like you are running this script as root"
  echo "Please run this script without root or sudo"
  echo "We will ask for your password when needed"
  exit 1
fi

BASEDIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

function update_upgrade {
  if [[ "$1" == dnf ]]; then
      sudo dnf upgrade -y
  elif [[ "$1" == apt ]]; then
      sudo apt update
      sudo apt full-upgrade -y
  fi
}

function base_packages {
  basepkgs=(curl direnv dos2unix git git-lfs htop keychain less make man-db most
    nano openssl pinentry-tty rsync tree)

  sudo "$1" install -y "${basepkgs[@]}"

  sudo update-alternatives --set pinentry "$(command -v pinentry-tty)"
}

function backup_gitconfig {
  if ! [[ -s ~/.gitconfig_local ]]; then
    cat ~/.gitconfig >>~/.gitconfig_local
  fi
}

function link_dotfiles {
  for DOTFILE in "$BASEDIR"/{git,system}/.[a-z]*; do ln -sfv "$DOTFILE" ~; done
  # for DOTFILE in "$BASEDIR"/runcom/bash/.[a-z]*; do ln -sfv "$DOTFILE" ~; done
  for DOTFILE in "$BASEDIR"/runcom/zsh/.[a-z]*; do ln -sfv "$DOTFILE" ~; done
  ln -sfvd "$BASEDIR"/system/.bin/ ~
}

function main {
  update_upgrade "$@"
  base_packages "$@"
  bash ./packages/python_pyenv.sh "$@"
  bash ./packages/omz_zsh.sh "$@"
  bash ./packages/node_n.sh "$@"
  backup_gitconfig
  link_dotfiles
  sudo "$1" autoremove -y
}

if [[ -x "$(command -v apt)" ]]; then
  main apt
elif [[ -x "$(command -v dnf)" ]]; then
  main dnf
fi
