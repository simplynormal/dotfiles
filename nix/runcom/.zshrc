#
# Executes commands at the start of an interactive session.
#

# Source Prezto.
if [[ -s "${ZDOTDIR:-$HOME}/.zprezto/init.zsh" ]]; then
  source "${ZDOTDIR:-$HOME}/.zprezto/init.zsh"
fi

# Dotfiles (order matters)
source ~/.zsh_functions
source ~/.zsh_aliases

# Set PATH so it includes user's private bin if it exists
if [[ -d "$HOME/.bin" ]]; then
  PATH="$HOME/.bin:$PATH"
fi

# GnuPG pinentry
export GPG_TTY=$(tty)

# Pyenv
if [[ -z "$VIRTUAL_ENV" ]]; then
  eval "$(pyenv init -)"
fi

# N
export N_PREFIX="$HOME/n"
[[ :$PATH: == *":$N_PREFIX/bin:"* ]] || PATH+=":$N_PREFIX/bin"
