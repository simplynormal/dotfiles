#!/usr/bin/env bash

source ../common.sh

function main() {
  if [[ "$1" == apt ]]; then
  createtmp
  wget https://packages.microsoft.com/config/debian/11/packages-microsoft-prod.deb -O packages-microsoft-prod.deb
  sudo dpkg -i packages-microsoft-prod.deb
  cleantmp
  fi

  sudo "$1" install -y dotnet-sdk-5.0 nuget
}

main "$@"
