# zplug plugins

zplug "~/.zsh", from:local, use:"*.zsh", ignore:"*{zplug,completion}.zsh"
zplug "~/.zsh", from:local, use:"completion.zsh", defer:2

zplug 'zsh-users/zsh-history-substring-search'
zplug 'zsh-users/zsh-autosuggestions'
zplug 'zsh-users/zsh-syntax-highlighting', defer:2
zplug 'zsh-users/zsh-completions'

zplug "rupa/z", use:z.sh
zplug "changyuheng/fz"
zplug "mollifier/cd-gitroot"

## Theme
zplug 'oskarkrawczyk/honukai-iterm-zsh', as:theme
