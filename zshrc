# The following lines were added by compinstall
zstyle ':completion:*' auto-description 'specify: %d'
zstyle ':completion:*' completer _expand _complete _ignored _correct
zstyle ':completion:*' group-name ''
zstyle ':completion:*' list-colors ''
zstyle ':completion:*' matcher-list '' 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'
zstyle :compinstall filename '$HOME/.zshrc'
autoload -Uz compinit
autoload -Uz vcs_info
zstyle ':vcs_info:*' actionformats \
    '%F{5}(%f%s%F{5})%F{3}-%F{5}[%F{2}%b%F{3}|%F{1}%a%F{5}]%f '
zstyle ':vcs_info:*' formats       \
    '%F{5}(%f%s%F{5})%F{3}-%F{5}[%F{2}%b%F{5}]%f '
zstyle ':vcs_info:(sv[nk]|bzr):*' branchformat '%b%F{1}:%F{3}%r'

zstyle ':vcs_info:*' enable git cvs svn
vcs_info_wrapper() {
  vcs_info
  if [ -n "$vcs_info_msg_0_" ]; then
    echo "%{$fg[grey]%}${vcs_info_msg_0_}%{$reset_color%}$del"
  fi
}

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
PROMPT='[%T]%{$fg[red]%} %{$fg_bold[green]%}${PWD/#$HOME/~}%{$reset_color%} %(?.✔.✗) '
RPROMPT=$'$(vcs_info_wrapper)'
export PATH="./bin:./exec:.:/usr/local/bin/:/usr/local/sbin/:$PATH"

export EDITOR=subl
alias startdb="pg_ctlcluster 9.6 main start"
alias stopdb="pg_ctlcluster 9.6 main stop"
alias web="foreman start web"
alias bgweb="BACKGROUND_TASK=1 foreman start"
export TBG_DB=metrilio_dev

# Mac specific thingies
platform=$(uname -a)
if [[ $platform =~ "Darwin" ]]; then
  eval "$(rbenv init -)"
#  export CLICOLOR=1
else
  alias ls="ls --color=auto"
  eval $(dircolors)
fi

## Metrilio specific
export TBG_DEV_BASEDIR=~/dev/
export TZ=utc

update_tbg_gem () {
  # $1 is the name of the gem to update
  # the rest will be the list of directories where to update it
  gem=$1
  shift
  for dir in $@
  do
    echo "updating $gem in $dir"
    pushd "$TBG_DEV_BASEDIR/$dir" > /dev/null
    bundle update $gem | grep $gem
    popd > /dev/null
  done
}

update_tbg_core () {
  update_tbg_gem tbg_core tbg_common tbg_admin tbg_api_v2 tbg
}

update_tbg_model () {
  update_tbg_gem tbg_model tbg_common tbg_admin tbg_api_v2 tbg
}

update_tbg_common () {
  update_tbg_gem tbg_common tbg_api_v2 tbg
}


## change db
change_db () {
  db=$1
  shift
  for dir in $@
  do
    echo "changing to $db in $dir"
    pushd "$TBG_DEV_BASEDIR/$dir" > /dev/null
    cat config/database.yml.tmpl | sed "s/\*dev/*$db/" > config/database.yml
    popd > /dev/null
  done
}

metrilio_dev () {
  change_db dev tbg tbg_admin tbg_api_v2
}

metrilio_staging () {
  change_db staging tbg tbg_admin tbg_api_v2
}

metrilio_production () {
  change_db prod tbg tbg_admin tbg_api_v2
}
