#!/usr/bin/env bash

function main {
  sudo "$1" install -y zsh

  chsh -s "$(command -v zsh)"
  if [[ -f "${HOME}/.zshrc" ]]; then
    mv "${HOME}/.zshrc" "${HOME}/.zshrc.back"
  fi

  git clone --recursive https://github.com/sorin-ionescu/prezto.git "${ZDOTDIR:-$HOME}/.zprezto"
  git clone --recurse-submodules https://github.com/belak/prezto-contrib "${ZDOTDIR:-$HOME}/.zprezto/contrib"
}

main "$@"
