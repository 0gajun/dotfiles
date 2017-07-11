####################
# Global Alias
alias -g L='| less'
alias -g G='| grep -i'
alias -g H='| head'

alias -g J='| jq .'

###################
# Alias

if (( $+commands[gls] )); then
  alias ls='gls -F --color --group-directories-first'
elif (( $+commands[ls] )); then
  if is_osx; then
    alias ls='ls -GF'
  else
    alias ls='ls -F --color'
  fi
fi

alias ..='cd ../'
alias ...='cd ../../'
alias ....='cd ../../../'

alias l='ls'
alias la='ls -alF -h'
alias rm='rm -i'
alias mkdir='mkdir -p'
alias history='history 0'

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

function ghq-interactive-directory-select-and-cd() {
  cd $(ghq root)/$(ghq list | fzf --height=20 --no-sort +m --query "$LBUFFER" --prompt="Repository > ")
}

alias gcd=ghq-interactive-directory-select-and-cd # Git Change Directory

unalias z 2> /dev/null
z() {
  [ $# -gt 0 ] && _z "$*" && return
  cd "$(_z -l 2>&1 | fzf-tmux +s --tac --query "$*" | sed 's/^[0-9,.]* *//')"
}

function git-branch-filter() {
  git branch | peco | sed -e "s/^\*\s*//g"
}
alias -g GB='$(git-branch-filter)'
