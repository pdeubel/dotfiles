# Setup fzf
# ---------
if [[ ! "$PATH" == */home/pdeubel/.zsh/fzf/bin* ]]; then
  PATH="${PATH:+${PATH}:}/home/pdeubel/.zsh/fzf/bin"
fi

source <(fzf --zsh)
