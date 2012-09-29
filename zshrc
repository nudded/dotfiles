# The following lines were added by compinstall
zstyle ':completion:*' auto-description 'specify: %d'
zstyle ':completion:*' completer _expand _complete _ignored _correct
zstyle ':completion:*' group-name ''
zstyle ':completion:*' list-colors ''
zstyle ':completion:*' matcher-list '' 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'
zstyle :compinstall filename '$HOME/.zshrc'
autoload -Uz compinit
compinit
# End of lines added by compinstall
# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
bindkey -e
# End of lines configured by zsh-newuser-install
export LANG='en_US.UTF-8'
export LC_ALL='en_US.UTF-8'

autoload colors
colors

setopt prompt_subst
PROMPT='[%T]%{$fg[red]%} %n@%m %{$fg_bold[green]%}${PWD/#$HOME/~}%{$reset_color%} %(?.✔.✗) '
export PATH=".:/usr/local/bin/:/usr/local/sbin/:$HOME/.cabal/bin/:$PATH"
export PATH="$PATH:/usr/local/Cellar/go/1.0.2/bin"

export EDITOR=vim

# Mac specific thingies
platform=$(uname -a)
if [[ $platform =~ "Darwin" ]]; then
  eval "$(rbenv init -)"
  eval "$(hub alias -s)"
  alias vim='mvim -v'
  export CLICOLOR=1
else
  alias ls="ls --color=auto"
  eval $(dircolors)
fi
if [[ "$TERM" != "screen-256color" ]]; then
  tmux attach-session -t "$USER" || tmux new-session -s "$USER"
  exit
fi

