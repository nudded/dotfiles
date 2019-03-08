setopt combiningchars
setopt interactive
setopt login
setopt monitor
setopt prompt_subst
setopt zle

setopt appendhistory extendedglob nomatch
HISTSIZE=100000000
SAVEHIST=100000000
HISTFILE=~/.zsh_history
setopt HIST_IGNORE_SPACE
setopt extended_history
setopt hist_expire_dups_first
setopt hist_ignore_dups # ignore duplication command history list
setopt hist_ignore_space
setopt hist_verify
setopt inc_append_history

autoload -Uz vcs_info
autoload -U colors && colors

zstyle ':vcs_info:*' actionformats '%F{5}(%f%s%F{5})%F{3}-%F{5}[%F{2}%b%F{3}|%F{1}%a%F{5}]%f '
zstyle ':vcs_info:*' formats '%F{5}(%f%s%F{5})%F{3}-%F{5}[%F{2}%b%F{5}]%f '
zstyle ':vcs_info:(sv[nk]|bzr):*' branchformat '%b%F{1}:%F{3}%r'
zstyle ':vcs_info:*' enable git cvs svn
zstyle ':completion:*:*:git:*' enable

vcs_info_wrapper() {
  vcs_info
  if [ -n "$vcs_info_msg_0_" ]; then
    echo "%{$fg[grey]%}${vcs_info_msg_0_}%{$reset_color%}$del"
  fi
}

cdm () {
  subdir=$1
  if [[ -z $subdir ]]; then
    cd ~/dev/metrilio
  else
    cd ~/dev/metrilio/$subdir
  fi

}

add_local () {
  domain=$1
  echo "127.0.0.1 $domain.metrilio.test" | sudo tee -a /etc/hosts
}

alias run-help=man
alias which-command=whence

export PROMPT='[%T]%{$fg[red]%} %{$fg_bold[green]%}${PWD/#$HOME/~}%{$reset_color%} %(?.✔.✗) '
export RPROMPT='$(vcs_info_wrapper)'
export PATH="./exec:.:/usr/local/bin/:/usr/local/sbin/:~/.cargo/bin/:$PATH"
eval "$(rbenv init -)"
export EDITOR="vim"
fpath=(/usr/local/share/zsh-completions $fpath)
export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8
export TBG_DB="metrilio_dev"

alias ls='exa -l'
alias tbg='itermocil --here tbg'
alias dl-mp3="youtube-dl --extract-audio --audio-format mp3"
alias rsp="rails s -p "
alias rs="TZ=UTC rails s"
alias lrs="ssh -R 3000:localhost:3000 pi@local.toonwillems.be -p 2222"
alias rc="TZ=UTC rails c"
alias cat="bat"

export FZF_DEFAULT_COMMAND='rg --files'

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
