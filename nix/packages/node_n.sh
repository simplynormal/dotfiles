#!/usr/bin/env bash

function main {
  curl -SL https://git.io/n-install | bash -s -- -y
  export N_PREFIX="$HOME/n"
  [[ :$PATH: == *":$N_PREFIX/bin:"* ]] || PATH+=":$N_PREFIX/bin"

  n rm "$(n --lts)"
  n latest

  npm install -g editorconfig
}

main "$@"
