# Login

# Dotfiles (order matters)
for DOTFILE in ~/.{path,env,prompt,custom}; do
  [[ -f "$DOTFILE" ]] && source "$DOTFILE"
done

# Interactive
[[ -r ~/.bashrc ]] && source ~/.bashrc
