#!/usr/bin/env bash

REPO=http://github.com/nudded/dotfiles
DEST=".dotfiles"
echo "cloning repo: $REPO into dir: $DEST"
git clone $REPO $DEST

function setup() {
    SRC="$1"
    DST="$2"
    echo "Installing $SRC..."

    mkdir -p $(dirname "$DST")
    ln -sfn "$PWD/$DEST/$SRC" "$DST"
}

setup ackrc "$HOME/.ackrc"
setup gitconfig "$HOME/.gitconfig"
setup vimrc "$HOME/.vimrc"
setup xmonad.hs "$HOME/.xmonad/xmonad.hs"

