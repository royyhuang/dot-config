#!/usr/bin/env bash

export DEBIAN_FRONTEND=noninteractive
sudo apt-add-repository ppa:fish-shell/release-3
sudo apt-get update
sudo apt-get -y upgrade

# install fish
sudo apt-get -y install fish libevent-dev ncurses-dev build-essential bison pkg-config fzf trash-cli highlight
curl https://raw.githubusercontent.com/oh-my-fish/oh-my-fish/master/bin/install | fish

# install nvim
mkdir -p $HOME/.local; mkdir -p $HOME/.local/bin
curl -L https://github.com/neovim/neovim/releases/latest/download/nvim.appimage -O $HOME/.local/bin/nvim
chmod u+x $HOME/.local/bin/nvim

TMUX_VER=3.4
wget https://github.com/tmux/tmux/releases/download/$TMUX_VER/tmux-$TMUX_VER.tar.gz
tar xzvf tmux-$TMUX_VER.tar.gz
cd tmux-$TMUX_VER/
./configure --prefix=$HOME/.local
make -j $(nproc) && make -j $(nproc) install
rm -rf tmux-$TMUX_VER.tar.gz tmux-$TMUX_VER
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

sudo mkdir -p -m 755 /etc/apt/keyrings && wget -qO- https://cli.github.com/packages/githubcli-archive-keyring.gpg | sudo tee /etc/apt/keyrings/githubcli-archive-keyring.gpg > /dev/null \
&& sudo chmod go+r /etc/apt/keyrings/githubcli-archive-keyring.gpg \
&& echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/githubcli-archive-keyring.gpg] https://cli.github.com/packages stable main" | sudo tee /etc/apt/sources.list.d/github-cli.list > /dev/null \
&& sudo apt update \
&& sudo apt install gh -y
export GH_TOKEN=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
gh repo clone royyhuang/dot-config
cd dot-config
bash ./linux-only.sh
cd $HOME; rm -rf $HOME/.config/fish
mv dot-config/* $HOME/.config


