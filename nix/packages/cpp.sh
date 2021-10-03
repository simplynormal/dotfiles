#!/usr/bin/env bash

source ../common.sh

function main() {
  if [[ "$1" == apt ]]; then
    basepkgs=(build-essential clang gcc g++ gdb gdbserver rsync zip)
  elif [[ "$1" == dnf ]]; then
    basepkgs=(make clang gcc gcc-c++ gdb gdb-gdbserver rsync zip)
  fi

  # Install the Microsoft version of CMake for Visual Studio
  createtmp
  # shellcheck disable=SC2155
  local dist="$(uname -m)"
  if [[ ${dist} == "x86_64" ]]; then
    wget -O cmake.sh "https://github.com/microsoft/CMake/releases/download/v3.19.4268486/cmake-3.19.4268486-MSVC_2-Linux-${dist/86_/}.sh"
    sudo bash cmake.sh --skip-license --prefix=/usr/local
  fi
  cleantmp
}

main "$@"
