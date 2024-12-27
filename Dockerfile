# Use Ubuntu as the base image
FROM nvidia/cuda:12.1.0-cudnn8-devel-ubuntu22.04

# Set non-interactive frontend (no user interaction during installation)
ENV DEBIAN_FRONTEND=noninteractive \
	TERM=xterm-256color \
	NVIM_VER=0.10.2 \
	TMUX_VER=3.4 \
	NODE_VER=22

# Install basic utilities, add the Fish shell repository, and install all necessary packages
RUN apt-get update \
	&& apt-get install -y software-properties-common wget curl git \
	&& apt-add-repository ppa:fish-shell/release-3 \
	&& apt-get update \
	&& apt-get -y upgrade \
	&& apt-get install -y unzip cmake fish libevent-dev ncurses-dev \
	build-essential bison pkg-config trash-cli highlight \
	ninja-build gettext ripgrep

# Install oh-my-fish, 
RUN curl -L https://raw.githubusercontent.com/oh-my-fish/oh-my-fish/master/bin/install >> install_omf \
	&& fish install_omf --noninteractive --yes && rm install_omf

# Install nvim
RUN wget https://github.com/neovim/neovim/archive/refs/tags/v${NVIM_VER}.tar.gz \
	&& tar xzvf v${NVIM_VER}.tar.gz && mv neovim-${NVIM_VER} neovim && cd neovim \
	&& make CMAKE_BUILD_TYPE=Release CMAKE_INSTALL_PREFIX=$HOME/.local \
	&& make install \
	&& cd - && rm -rf v${NVIM_VER}.tar.gz v${NVIM_VER}

# Install tmux and tmux plugin manger
RUN wget https://github.com/tmux/tmux/releases/download/${TMUX_VER}/tmux-${TMUX_VER}.tar.gz \
	&& tar xzvf tmux-${TMUX_VER}.tar.gz \
	&& cd tmux-${TMUX_VER}/ \
	&& ./configure --prefix=$HOME/.local \
	&& make -j $(nproc) && make -j $(nproc) install \
	&& cd - && rm -rf tmux-${TMUX_VER} tmux-${TMUX_VER}.tar.gz \
	&& git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

# Install nodejs
RUN curl -fsSL https://deb.nodesource.com/setup_${NODE_VER}.x | bash - \
	&& apt-get install -y nodejs

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
