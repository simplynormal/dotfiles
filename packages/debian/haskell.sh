#!/usr/bin/env bash

source ../common.sh

function main() {
  sudo apt update
  sudo apt install -y haskell-platform
  sudo apt autoremove -y
}

main "$@"
