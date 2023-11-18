# Created by newuser for 5.9

HISTFILE=~/.zsh/.zsh_history
HISTSIZE=10000
SAVEHIST=10000

export EDITOR=nvim
export VISUAL=nvim
export TERMINAL=terminator
export PATH=$PATH:$HOME/scripts

alias ls='ls --color=auto'
alias grep='grep --color=auto'
alias neofetch='fm6000 -f ~/ascii/arch.txt -c blue -nd -os "arch linux"'
# traição acima, desculpa...

source ~/.zsh/plugins/zsh-vi-mode.zsh
source ~/.zsh/plugins/zsh-autosuggestions.zsh
source ~/.zsh/plugins/zsh-syntax-highlighting.zsh
source ~/.zsh/themes/yeksax.zsh
