#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

fastfetch

alias dotfiles='git --git-dir=$HOME/.dotfiles --work-tree=$HOME'
alias ls='ls --color=auto'
alias grep='grep --color=auto'
PS1='[\u@\h \W]\$ '
export PATH="$HOME/.local/bin:$PATH"
export PATH="$HOME/.local/bin:$PATH"
export PATH="$HOME/.local/bin:$PATH"
