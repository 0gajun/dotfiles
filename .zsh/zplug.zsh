# zplug plugins

zplug "~/.zsh", from:local, use:"*.zsh", ignore:"zplug.zsh"

zplug 'zsh-users/zsh-history-substring-search'
zplug 'zsh-users/zsh-autosuggestions'
zplug 'zsh-users/zsh-syntax-highlighting', defer:2
zplug 'zsh-users/zsh-completions'

zplug "rupa/z", use:z.sh
zplug "changyuheng/fz"

## Theme
zplug 'oskarkrawczyk/honukai-iterm-zsh', as:theme
