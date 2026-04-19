DOTFILES_ZSH_DIR="$(dirname "$(readlink -f "${(%):-%x}")")"

if [[ "$(uname)" == "Darwin" ]]; then
  source "$DOTFILES_ZSH_DIR/.zshrc.mac" pre
else
  source "$DOTFILES_ZSH_DIR/.zshrc.linux" pre
fi

source "$DOTFILES_ZSH_DIR/.zshrc.common"

if [[ "$(uname)" == "Darwin" ]]; then
  source "$DOTFILES_ZSH_DIR/.zshrc.mac" post
else
  source "$DOTFILES_ZSH_DIR/.zshrc.linux" post
fi

# Secrets (not tracked by git)
if [[ -f "$DOTFILES_ZSH_DIR/.zshrc.secrets" ]]; then
  source "$DOTFILES_ZSH_DIR/.zshrc.secrets"
fi
