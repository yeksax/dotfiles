# Created by newuser for 5.9

bindkey '\e[A' history-beginning-search-backward
bindkey '\e[B' history-beginning-search-forward


HISTFILE=~/.zsh/.zsh_history
HISTSIZE=10000
SAVEHIST=10000

export EDITOR=nvim
export VISUAL=nvim
export TERMINAL=terminator
export PATH=$PATH:$HOME/scripts
export PATH=$PATH:$HOME/go/bin

alias ls='ls --color=auto'
alias grep='grep --color=auto'
# alias neofetch='fm6000 -f ~/ascii/arch.txt -c blue -nd -os "arch linux"'
# traição acima, desculpa...

# source ~/.zsh/plugins/zsh-vi-mode.zsh
source ~/.zsh/plugins/zsh-autosuggestions.zsh
source ~/.zsh/plugins/zsh-syntax-highlighting.zsh
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
