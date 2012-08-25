#!/usr/bin/env bash

REPO=http://github.com/nudded/dotfiles
DEST=".dotfiles"

if [[ -d $DEST ]];then
  cd $DEST && git pull origin master
else
  echo "cloning repo: $REPO into dir: $DEST"
  git clone $REPO $DEST
fi

function setup() {
    SRC="$1"
    DST="$2"
    echo "Installing $SRC..."

    mkdir -p $(dirname "$DST")
    ln -sfn "$PWD/$DEST/$SRC" "$DST"
}

setup vimrc "$HOME/.vimrc"
setup zshrc "$HOME/.zshrc"
