#!/usr/bin/env bash

function main() {
  sudo dnf upgrade -y
  sudo dnf install -y haskell-platform
  sudo dnf autoremove -y
}

main "$@"
