# Setup fzf
# ---------
if [[ ! "$PATH" == */home/mascanio/.fzf/bin* ]]; then
  PATH="${PATH:+${PATH}:}/home/mascanio/.fzf/bin"
fi

# Auto-completion
# ---------------
source "/home/mascanio/.fzf/shell/completion.bash"

# Key bindings
# ------------
source "/home/mascanio/.fzf/shell/key-bindings.bash"
