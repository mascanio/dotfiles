if [[ -f "/opt/homebrew/bin/brew" ]] then
  # If you're using macOS, you'll want this enabled
  eval "$(/opt/homebrew/bin/brew shellenv)"
fi

if [ "$TERM_PROGRAM" != "Apple_Terminal" ]; then
  export PATH=$PATH:/home/mascanio/.local/bin
fi

export STARSHIP_CONFIG=~/.config/starship/starship.toml
eval "$(starship init zsh)"

# Set the directory we want to store zinit and plugins
ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"

# Download Zinit, if it's not there yet
if [ ! -d "$ZINIT_HOME" ]; then
   mkdir -p "$(dirname $ZINIT_HOME)"
   git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
fi

# Source/Load zinit
source "${ZINIT_HOME}/zinit.zsh"

# Add in zsh plugins
zinit light zsh-users/zsh-syntax-highlighting
zinit light zsh-users/zsh-completions

# Load completions
fpath=(~/.docker/completions \/Users/mascanio/.local/share/zinit/completions /usr/local/share/zsh/site-functions /usr/share/zsh/site-functions /usr/share/zsh/5.9/functions /Users/mascanio/.local/share/zinit/plugins/zsh-users---zsh-completions/src /Users/mascanio/.local/share/zinit/plugins/Aloxaf---fzf-tab/lib)
autoload -Uz compinit && compinit

zinit light Aloxaf/fzf-tab
zinit light zsh-users/zsh-autosuggestions

# Add in snippets
zinit snippet OMZP::git
zinit snippet OMZP::sudo
zinit snippet OMZP::kubectl
zinit snippet OMZP::command-not-found
zinit snippet OMZP::golang

zinit cdreplay -q

# Keybindings
bindkey '^y' autosuggest-accept
bindkey '^l' autosuggest-execute

# History
HISTSIZE=50000
HISTFILE=~/.zsh_history
SAVEHIST=$HISTSIZE
HISTDUP=erase
setopt appendhistory
setopt sharehistory
setopt hist_ignore_space
setopt hist_ignore_all_dups
setopt hist_save_no_dups
setopt hist_ignore_dups
setopt hist_find_no_dups

# Completion styling
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
zstyle ':completion:*' menu no
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'eza -1 --color=always $realpath'

# Aliases
alias vim='nvim'
alias ll='eza -l --group-directories-first --icons=always'
alias ls='eza -l --group-directories-first --icons=always --no-user --no-permissions'
alias l='eza --group-directories-first --icons=always'
alias la='eza -l --group-directories-first --icons=always -a'

# Shell integrations
# Set up fzf key bindings and fuzzy completion
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

. "$HOME/.cargo/env"

if [[ -f "/opt/homebrew/bin/brew" ]] then
  # fnm
  FNM_PATH="/Users/mascanio/Library/Application Support/fnm"
  if [ -d "$FNM_PATH" ]; then
    export PATH="/Users/mascanio/Library/Application Support/fnm:$PATH"
    eval "`fnm env`"
    eval "$(fnm env --use-on-cd)"
  fi

  eval "$(fzf --zsh)"

  export PATH="/Users/mascanio/go/bin/:$PATH"
  # Java
  export PATH="/opt/homebrew/opt/openjdk/bin:$PATH"
  # Ruby
  export PATH="/opt/homebrew/opt/ruby/bin:$PATH"
  export PATH="/opt/homebrew/lib/ruby/gems/3.4.0/bin:$PATH"
  export LDFLAGS="-L/opt/homebrew/opt/ruby/lib"
  export CPPFLAGS="-I/opt/homebrew/opt/ruby/include"
  # Perl
  eval "$(perl -I$HOME/perl5/lib/perl5 -Mlocal::lib=$HOME/perl5)"
else
  # fnm
  FNM_PATH="/home/mascanio/.local/share/fnm"
  if [ -d "$FNM_PATH" ]; then
    export PATH="/home/mascanio/.local/share/fnm:$PATH"
    eval "`fnm env`"
  fi
  export PATH=$PATH:/usr/local/go/bin
  export PATH=$PATH:/home/mascanio/go/bin
fi

