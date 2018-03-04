#!/usr/bin/env zsh

REPO=http://github.com/nudded/dotfiles
DEST="$HOME/.dotfiles"

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
    ln -sfn "$DEST/$SRC" "$DST"
}

echo "Setting up vim-plug"
if [[ -d $HOME/.vim/autoload/plug.vim ]]; then
  echo "vim-plug already installed"
else
  curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
fi

setup vimrc "$HOME/.vimrc"

echo "updating Bundles"
vim +PlugInstall +qall

reset
