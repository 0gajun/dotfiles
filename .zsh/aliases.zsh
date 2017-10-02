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

alias tf='terraform'
alias tp='terraform plan'

####################
# Functions

# Interactive selection for git changed files
function git-changed-files() {
  git status --short | peco | awk '{print $2}'
}
alias -g GF='$(git-changed-files)'

function ssh-host-search-and-connect() {
  ssh_host=$(cat ~/.ssh/config | grep "^Host" | awk '{print $2;}' | peco)
  echo "======================="
  echo "Connecting to $ssh_host"
  echo "=======================\n"
  ssh $ssh_host
}
alias sshs=ssh-host-search-and-connect

function ghq-interactive-directory-select-and-cd() {
  target=$(ghq list | fzf --height=20 --no-sort +m --query "$1" --prompt="Repository > ")
  if [ -z $target ]; then
    return 0
  fi
  cd $(ghq root)/$target
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

function create-new-repository() {
  if [ -z $GHQ_ROOT ]; then
    echo "\$GHQ_ROOT is not defined"
    return 1
  fi

  if [ -z $1 ]; then
    echo "Must specify repo name"
    return 1
  fi

  dst=$GHQ_ROOT/github.com/0gajun/$1
  echo "Creating repo to $dst"
  mkdir $dst && cd $dst && git init
}

alias create-repo='create-new-repository'
