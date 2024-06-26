# Use Ubuntu as the base image
FROM nvidia/cuda:11.8.0-cudnn8-devel-ubuntu22.04

# Set non-interactive frontend (no user interaction during installation)
ENV DEBIAN_FRONTEND=noninteractive

# Install basic utilities, add the Fish shell repository, and install all necessary packages
RUN apt-get update && \
    apt-get install -y software-properties-common wget curl git && \
    apt-add-repository ppa:fish-shell/release-3 && \
    apt-get update && \
    apt-get -y upgrade && \
    apt-get install -y unzip cmake fish libevent-dev ncurses-dev build-essential bison pkg-config fzf trash-cli highlight ninja-build gettext

# Install oh-my-fish, Neovim, tmux, Node.js, and setup Neovim and tmux
RUN curl -L https://raw.githubusercontent.com/oh-my-fish/oh-my-fish/master/bin/install >> install_omf && \
    fish install_omf --noninteractive --yes && \
    rm install_omf && \
    git clone https://github.com/neovim/neovim.git /neovim && \
    cd /neovim && \
    make CMAKE_BUILD_TYPE=RelWithDebInfo CMAKE_INSTALL_PREFIX=$HOME/.local && \
    make install && \
    wget https://github.com/tmux/tmux/releases/download/3.4/tmux-3.4.tar.gz && \
    tar xzvf tmux-3.4.tar.gz && \
    cd tmux-3.4/ && \
    ./configure --prefix=$HOME/.local && \
    make -j $(nproc) && make -j $(nproc) install && \
    cd .. && rm -rf tmux-3.4 tmux-3.4.tar.gz && \
    git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm && \
    curl -fsSL https://deb.nodesource.com/setup_22.x | bash - && \
    apt-get install -y nodejs

# Install Miniconda
RUN wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh -O $HOME/miniconda.sh && \
    chmod +x $HOME/miniconda.sh && \
    bash $HOME/miniconda.sh -b -u -p $HOME/.local/miniconda3 && \
    rm $HOME/miniconda.sh

COPY ./ /root/.config/
WORKDIR /root/

# Set the default command to launch fish shell
CMD ["fish"]
