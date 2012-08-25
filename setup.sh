#!/usr/bin/env zsh

REPO=http://github.com/nudded/dotfiles
DEST=".dotfiles"

if [[ -d $DEST ]];then
  cd $DEST && git pull origin master && cd -
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

echo "Setting up Vundle"
if [[ -d $HOME/.vim/bundle/vundle ]]; then
  echo "Vundle already installed"
else
  git clone https://github.com/gmarik/vundle.git $HOME/.vim/bundle/vundle
fi

setup vimrc "$HOME/.vimrc"
setup zshrc "$HOME/.zshrc"

echo "updating Bundles"
vim -c :BundleInstall\! -c qa\!
