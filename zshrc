####################
# zplug
if [[ -f ~/.zplug/init.zsh ]]; then
  export ZPLUG_LOADFILE=~/.zsh/zplug.zsh
  source ~/.zplug/init.zsh

  # Install plugins if there are plugins that have not been installed
  if ! zplug check --verbose; then
    printf "Install? [y/N]: "
    if read -q; then
      echo; zplug install
    fi
    echo
  fi

  zplug load
fi

####################
# Zsh settings

ZSH_THEME="honukai"

# vim like keybindings
bindkey -v

# Entering to vim-cmd-mode by pressing 'jk'
bindkey 'jk' vi-cmd-mode

# reset vi keybind for specific keys.
bindkey '^A' beginning-of-line
bindkey '^E' end-of-line

# history search by inputted cmd name
bindkey "^[[A" history-search-backward
bindkey "^[[B" history-search-forward
bindkey "^[OA" history-search-backward
bindkey "^[OB" history-search-forward

# Interactive selection
CASE_SENSITIVE="false"
zstyle ':completion:*' menu select interactive
zmodload zsh/complist
bindkey -M menuselect '^l' forward-char
bindkey -M menuselect '^j' down-line-or-history
bindkey -M menuselect '^k' up-line-or-history
bindkey -M menuselect '^h' backward-char

# Enable using commnd stack by pressing C-q
show_buffer_stack() {
    POSTDISPLAY="
    stack: $LBUFFER"
      zle push-line-or-edit
    }
zle -N show_buffer_stack
bindkey '^Q' show_buffer_stack

# History Settings
HISTFILE=~/.zsh_history
HISTSIZE=5000
SAVEHIST=50000

# disable beep
setopt nobeep
# disable flowcontrol
setopt noflowcontrol

setopt hist_ignore_all_dups

####################
# Global Alias
alias -g L='| less'
alias -g G='| grep'
alias -g H='| head'

###################
# Alias
alias la='ls -alF'
alias vim='nvim'
alias rm='rm -i'
alias mkdir='mkdir -p'
alias gcd='cd $(ghq root)/$(ghq list | peco)' # Git Change Directory

alias gd='git diff'
alias ga='git add'
alias gs='git status'
alias gc='git commit'

####################
# Functions

# Interactive selection for git changed files
function git-changed-files() {
  git status --short | peco | awk '{print $2}'
}
alias -g GF='$(git-changed-files)'

function ssh-host-search() {
  cat ~/.ssh/config | grep "^Host" | awk '{print $2;}' | peco 
}
alias sshs='ssh $(ssh-host-search)'

zle -la history-incremental-pattern-search-backward && bindkey "^r" history-incremental-pattern-search-backward
