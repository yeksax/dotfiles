# Created by newuser for 5.9

HISTFILE=~/.zsh/.zsh_history

alias ls='ls --color=auto'
alias grep='grep --color=auto'

bindkey '^[[1;5C' forward-word
bindkey '^[[1;5D' backward-word

source ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh
source ~/.zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source ~/.zsh/themes/yeksax.zsh
