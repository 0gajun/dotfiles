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
# Zsh misc settings

CASE_SENSITIVE="false"
ZSH_THEME="honukai"

# History Settings
HISTFILE=~/.zsh_history
HISTSIZE=5000
SAVEHIST=50000

# disable beep
setopt nobeep
# disable flowcontrol
setopt noflowcontrol

setopt hist_ignore_all_dups
