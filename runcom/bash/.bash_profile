# Login
# echo "$(basename $BASH_SOURCE)"

# Pyenv
export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init --path)"

# Dotfiles (order matters)
for DOTFILE in ~/.{path,env,prompt,custom}; do
  [[ -f "$DOTFILE" ]] && source "$DOTFILE"
done

# Interactive
[[ -r ~/.bashrc ]] && source ~/.bashrc
