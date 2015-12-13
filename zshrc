# Notice
# You should place Environment variable in ~/.zshenv.
# Don't place in this file

####################
# Oh-my-zsh Settings

export ZSH=$HOME/.oh-my-zsh

ZSH_THEME="blinks"

CASE_SENSITIVE="false"

plugins=(rails git python)

source $ZSH/oh-my-zsh.sh

####################
# Zsh settings

bindkey -v

# Entering to vim-cmd-mode by pressing 'jk'
bindkey 'jk' vi-cmd-mode

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
# Functions

# Interactive selection for git changed files
function git-changed-files() {
  git status --short | peco | awk '{print $2}'
}
alias -g GF='$(git-changed-files)'
