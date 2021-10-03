#!/usr/bin/env bash

function main {
  if [[ "$1" == apt ]]; then
    basepkgs=(apt-utils build-essential curl libbz2-dev libffi-dev liblzma-dev
      libncursesw5-dev libreadline-dev libsqlite3-dev libssl-dev libxml2-dev
      libxmlsec1-dev llvm make tk-dev wget xz-utils zlib1g-dev)
  elif [[ "$1" == dnf ]]; then
    basepkgs=(bzip2 bzip2-devel gcc libffi-devel make openssl-devel readline-devel
      sqlite sqlite-devel tk-devel xz-devel zlib-devel util-linux-user)
  fi

  sudo "$1" install -y "${basepkgs[@]}"

  curl -SL https://github.com/pyenv/pyenv-installer/raw/master/bin/pyenv-installer | bash
  export PYENV_ROOT="$HOME/.pyenv"
  export PATH="$PYENV_ROOT/bin:$PATH"
  eval "$(pyenv init --path)"
  eval "$(pyenv init -)"

  pyenv install -s 3.9.7
  pyenv global 3.9.7
  pip install --upgrade pip setuptools wheel
}

main "$@"
