# Use Ubuntu as the base image
FROM nvidia/cuda:12.1.0-cudnn8-devel-ubuntu22.04

# Set non-interactive frontend (no user interaction during installation)
ENV DEBIAN_FRONTEND=noninteractive
ENV TERM=xterm-256color

# Install basic utilities, add the Fish shell repository, and install all necessary packages
RUN apt-get update \
    && apt-get install -y software-properties-common wget curl git \
    && apt-add-repository ppa:fish-shell/release-3 \
    && apt-get update \
    && apt-get -y upgrade \
    && apt-get install -y unzip cmake fish libevent-dev ncurses-dev \
		build-essential bison pkg-config fzf trash-cli highlight \
		ninja-build gettext

# Install oh-my-fish, Neovim, tmux, Node.js, and setup Neovim and tmux
RUN curl -L https://raw.githubusercontent.com/oh-my-fish/oh-my-fish/master/bin/install >> install_omf \
    && fish install_omf --noninteractive --yes && rm install_omf \
    && git clone https://github.com/neovim/neovim.git /neovim && cd /neovim \
    && make CMAKE_BUILD_TYPE=RelWithDebInfo CMAKE_INSTALL_PREFIX=$HOME/.local \
    && make install \
    && wget https://github.com/tmux/tmux/releases/download/3.4/tmux-3.4.tar.gz \
    && tar xzvf tmux-3.4.tar.gz \
    && cd tmux-3.4/ \
    && ./configure --prefix=$HOME/.local \
    && make -j $(nproc) && make -j $(nproc) install \
    && cd .. && rm -rf tmux-3.4 tmux-3.4.tar.gz \
    && git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm \
    && curl -fsSL https://deb.nodesource.com/setup_22.x | bash - \
    && apt-get install -y nodejs

# Install github-cli
RUN mkdir -p -m 755 /etc/apt/keyrings \
	&& wget -qO- https://cli.github.com/packages/githubcli-archive-keyring.gpg \
		| tee /etc/apt/keyrings/githubcli-archive-keyring.gpg > /dev/null \
	&& chmod go+r /etc/apt/keyrings/githubcli-archive-keyring.gpg \
	&& echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/githubcli-archive-keyring.gpg] https://cli.github.com/packages stable main" \
		| tee /etc/apt/sources.list.d/github-cli.list > /dev/null \
	&& apt update && apt install gh -y

# Install Miniconda
RUN wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh \
		-O $HOME/miniconda.sh \
    && chmod +x $HOME/miniconda.sh \
    && bash $HOME/miniconda.sh -b -u -p $HOME/.local/miniconda3 \
    && rm $HOME/miniconda.sh

# Install Rust
RUN curl https://sh.rustup.rs -sSf | sh -s -- -y

# Install fzf
RUN git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf \
    && ~/.fzf/install --all

COPY ./ /root/.config/
WORKDIR /root/

# Set the default command to launch fish shell
CMD ["fish"]
