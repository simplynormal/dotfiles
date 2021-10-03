#!/usr/bin/env bash

function main() {
  sudo "$1" install -y haskell-platform
}

main "$@"
