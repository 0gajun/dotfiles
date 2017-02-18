####################
# Global Alias
alias -g L='| less'
alias -g G='| grep'
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


