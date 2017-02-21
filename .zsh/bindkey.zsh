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
bindkey -M menuselect '\t' forward-char
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

zle -la history-incremental-pattern-search-backward
bindkey "^r" history-incremental-pattern-search-backward
