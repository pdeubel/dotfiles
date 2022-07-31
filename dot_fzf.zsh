# Setup fzf
# ---------
if [[ ! "$PATH" == */home/pdeubel/.zsh/fzf/bin* ]]; then
  export PATH="${PATH:+${PATH}:}/home/pdeubel/.zsh/fzf/bin"
fi

# Auto-completion
# ---------------
[[ $- == *i* ]] && source "/home/pdeubel/.zsh/fzf/shell/completion.zsh" 2> /dev/null

# Key bindings
# ------------
source "/home/pdeubel/.zsh/fzf/shell/key-bindings.zsh"
