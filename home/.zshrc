# Created by newuser for 5.9

bindkey '\e[A' history-beginning-search-backward
bindkey '\e[B' history-beginning-search-forward

HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000

# env
export EDITOR=nvim
export VISUAL=nvim
export TERMINAL=terminator
export PATH=$PATH:$HOME/scripts
export PATH=$PATH:$HOME/go/bin

# aliases
alias ls='ls --color=auto'
alias grep='grep --color=auto'
alias yt-dlp='yt-dlp -P ~/downloads -f "bestvideo[ext=mp4]+bestaudio[ext=m4a]/best[ext=mp4]/best" -S "codec:h264"'
alias mc="LANG=en_EN.UTF-8 mc"
alias grive-sync="cd $HOME/drive && grive -P"
alias set-bg="feh --bg-fill"
alias af="albafetch"
alias cat="bat"
alias cd="z"

# plugins
# source ~/.zsh/plugins/zsh-vi-mode.zsh
source ~/.zsh/plugins/zsh-autosuggestions.zsh
source ~/.zsh/plugins/zsh-syntax-highlighting.zsh
eval "$(starship init zsh)"
eval "$(zoxide init zsh)"

# themes
# source ~/.zsh/themes/yeksax.zsh

# bun completions
[ -s "/home/yeksax/.bun/_bun" ] && source "/home/yeksax/.bun/_bun"

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"

# pnpm
export PNPM_HOME="/home/yeksax/.local/share/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac
# pnpm end
