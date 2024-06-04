#!/usr/bin/env bash

export DEBIAN_FRONTEND=noninteractive
sudo apt-add-repository ppa:fish-shell/release-3
sudo apt-get update
sudo apt-get -y upgrade

# install fish
sudo apt-get -y install unzip cmake fish libevent-dev ncurses-dev build-essential bison pkg-config fzf trash-cli highlight
curl https://raw.githubusercontent.com/oh-my-fish/oh-my-fish/master/bin/install | fish

# install nvim
mkdir -p $HOME/.local; mkdir -p $HOME/.local/bin
sudo apt-get install ninja-build gettext cmake unzip curl build-essential
git clone https://github.com/neovim/neovim.git
cd neovim
make CMAKE_BUILD_TYPE=RelWithDebInfo CMAKE_INSTALL_PREFIX=$HOME/.local
make install

TMUX_VER=3.4
wget https://github.com/tmux/tmux/releases/download/$TMUX_VER/tmux-$TMUX_VER.tar.gz
tar xzvf tmux-$TMUX_VER.tar.gz
cd tmux-$TMUX_VER/
./configure --prefix=$HOME/.local
make -j $(nproc) && make -j $(nproc) install
rm -rf tmux-$TMUX_VER.tar.gz tmux-$TMUX_VER
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
cd $HOME

curl -fsSL https://deb.nodesource.com/setup_22.x | sudo -E bash - &&\
sudo apt-get install -y nodejs

wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh -O $HOME/miniconda.sh
mkdir -p $HOME/.local/miniconda3
bash $HOME/miniconda.sh -b -u -p $HOME/.local/miniconda3

bash ./linux-only.sh > /dev/null
