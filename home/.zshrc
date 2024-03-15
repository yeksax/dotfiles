# Created by newuser for 5.9

bindkey '\e[A' history-beginning-search-backward
bindkey '\e[B' history-beginning-search-forward

HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000

# env
export EDITOR=helix
export VISUAL=neovim
export TERMINAL=terminator
export PATH=$PATH:$HOME/scripts
export PATH=$PATH:$HOME/go/bin

# functions
function drive-sync() {
    CURRENT_DIR=$(pwd)
    cd $HOME/drive && grive -P && cd $CURRENT_DIR
}

function yt-dl() {
    yt-dlp --hls-prefer-ffmpeg -P ~/downloads --recode-video mp4 $1 -o $2
}

# aliases
alias gd="git diff"
alias commit="git add . && git commit"

alias af="albafetch"

alias grep='grep --color=auto'
alias ls='ls --color=auto'
alias cat="bat"

alias mc="LANG=en_EN.UTF-8 mc"
alias set-bg="feh --bg-fill"

alias v="nvim"
alias h="helix"
alias hx="helix"

alias so="source ~/.zshrc"
alias zshrc="helix ~/.zshrc && source ~/.zshrc && echo 'zshrc reloaded'"

alias dotfiles="helix ~/dotfiles"
alias dots="helix ~/dotfiles"

alias drive="drive-sync"
alias grive-sync="drive-sync"

alias dev="bun dev --turbo"
alias build="bun run build && bun run start"
alias pstudio="bunx prisma studio"
alias dstudio="bunx drizzle-kit studio"
alias ppush="bunx prisma db push && bun dev --turbo"
alias dpush="bunx drizzle-kit push:pg && bun dev --turbo"

alias t="tmux"
alias ta="tmux attach"
alias tls="tmux ls"
alias tk="tmux kill-session -t"

# plugins
source ~/.zsh/plugins/zsh-autosuggestions.zsh
source ~/.zsh/plugins/zsh-syntax-highlighting.zsh
source ~/.zsh/scripts/pw-pa
#eval "$(starship init zsh)"
eval "$(zoxide init zsh)"

# themes
source ~/.zsh/themes/yeksax.zsh

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
