#!/usr/bin/env bash

clean-dot-config() {
	pushd $HOME/.config
	rm -rf ./alacritty \
		  ./clash \
		  ./doom ./elisp ./emacs \
		  ./grammarly-languageserver \
		  ./raycast \
		  ./sketchybar ./skhd ./yabai \
		  ./htop \
		  ./hammerspoon > /dev/null
	popd
}

install-gpu-driver() {
	sudo apt update
	sudo apt-get install -y ubuntu-drivers-common
	sudo ubuntu-drivers install --gpgpu nvidia:535-server
	sudo apt-get install -y \
		nvidia-utils-535-server \
		nvidia-fabricmanager-535 \
		libnvidia-nscq-535
}

uninstall-gpu-driver() {
 	sudo apt-get --purge remove "*nvidia*" "*cublas*" "*cuda*"
	sudo apt autoremove
}

install-code-cli() {
	sudo apt install -y software-properties-common apt-transport-https wget
	wget -q https://packages.microsoft.com/keys/microsoft.asc -O- \
		| sudo apt-key add -
	sudo add-apt-repository \
		"deb [arch=amd64] https://packages.microsoft.com/repos/vscode stable main"
	sudo apt update
	sudo apt install -y code
}

uninstall-docker() {
	# remove any previous installation of docker
	old_docker_pkg=(
		docker.io
		docker-doc
		docker-compose
		docker-compose-v2
		podman-docker
		containerd
		runc
	)
	for pkg in "${old_docker_pkg[@]}"; do
		sudo apt-get remove $pkg
	done
	sudo apt autoremove -y
}

install-docker() {
	# remove previous installation first
	uninstall-docker

	# Add Docker's official GPG key:
	sudo apt-get update
	sudo apt-get install -y ca-certificates curl
	sudo install -m 0755 -d /etc/apt/keyrings
	sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg \
		-o /etc/apt/keyrings/docker.asc
	sudo chmod a+r /etc/apt/keyrings/docker.asc

	# Add the repository to Apt sources:
	echo \
		"deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu \
		$(. /etc/os-release && echo "$VERSION_CODENAME") stable" | \
		sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

	sudo apt-get update
	sudo apt-get install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

	curl -fsSL https://nvidia.github.io/libnvidia-container/gpgkey \
		| sudo gpg --dearmor -o /usr/share/keyrings/nvidia-container-toolkit-keyring.gpg \
  		&& curl -s -L https://nvidia.github.io/libnvidia-container/stable/deb/nvidia-container-toolkit.list | \
    	sed 's#deb https://#deb [signed-by=/usr/share/keyrings/nvidia-container-toolkit-keyring.gpg] https://#g' | \
    	sudo tee /etc/apt/sources.list.d/nvidia-container-toolkit.list

	sudo apt-get update
	sudo apt-get install -y nvidia-container-toolkit

	sudo nvidia-ctk runtime configure --runtime=docker
	sudo systemctl restart docker
}

install-conda-dev() {
	curl -O https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh
	sh Miniconda3-latest-Linux-x86_64.sh -b -p $HOME/miniconda3
	rm Miniconda3-latest-Linux-x86_64.sh
	source ~/miniconda3/etc/profile.d/conda.sh
	conda create --name torch python=3.10
	conda activate torch
	conda install pytorch torchvision torchaudio pytorch-cuda=12.1 -c pytorch -c nvidia
}

setup-ssh-tunnel() {
	sudo install autossh
	ssh-keygen
	eval $(ssh-agent -s)
	ssh-add $HOME/.ssh/id_rsa
	ssh-copy-id yuyangh@heart.cs.uchicago.edu
	ssh yuyangh@heart.cs.uchicago.edu "cat .ssh/id_rsa.pub" \
		>> $HOME/.ssh/authorized_keys
	autossh -f -M 0 -N -R 10022:localhost:22 yuyangh@heart.cs.uchicago.edu
}

install-all() {
	install-gpu-driver \
		&& install-docker \
		&& install-conda-dev \
		&& install-code-cli \
		&& setup-ssh-tunnel
	config_dir=$(dirname $(realpath "$0"))
	pushd $config_dir
	sudo docker build yuyangh-workspace:latest ./
	popd
}

init-dev-tools() {

	export DEBIAN_FRONTEND=noninteractive
	sudo apt-add-repository ppa:fish-shell/release-3
	sudo apt-get update
	sudo apt-get -y upgrade

	export PREFIX=$HOME/.local

	# install fish
	sudo apt-get -y install unzip cmake fish libevent-dev ncurses-dev \
		build-essential bison pkg-config fzf trash-cli highlight
	curl https://raw.githubusercontent.com/oh-my-fish/oh-my-fish/master/bin/install | fish

	# install nvim
	mkdir -p $PREFIX; mkdir -p $PREFIX/bin
	sudo apt-get install -y ninja-build gettext cmake unzip curl build-essential
	git clone https://github.com/neovim/neovim.git
	cd neovim
	make CMAKE_BUILD_TYPE=RelWithDebInfo CMAKE_INSTALL_PREFIX=$PREFIX
	make install

	TMUX_VER=3.4
	wget https://github.com/tmux/tmux/releases/download/$TMUX_VER/tmux-$TMUX_VER.tar.gz
	tar xzvf tmux-$TMUX_VER.tar.gz
	cd tmux-$TMUX_VER/
	./configure --prefix=$PREFIX
	make -j $(nproc) && make -j $(nproc) install
	rm -rf tmux-$TMUX_VER.tar.gz tmux-$TMUX_VER
	git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
	cd $HOME

	# nodejs
	curl -fsSL https://deb.nodesource.com/setup_22.x | sudo -E bash - \
		&& sudo apt-get install -y nodejs

	# miniconda3
	wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh \
		-O $HOME/miniconda.sh
	mkdir -p $PREFIX/miniconda3
	bash $HOME/miniconda.sh -b -u -p $PREFIX/miniconda3

	# rust
	curl https://sh.rustup.rs -sSf | sh -s -- -y

	git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf \
    && ~/.fzf/install --all

	clean-dot-config > /dev/null

}

get-openmpi() {
    local version=${1:-4.1.5}
    local file=openmpi-${version}.tar.bz2
    local url="https://download.open-mpi.org/release/open-mpi/v4.1/${file}"
    curl -L ${url} -o ${file}
    tar xjf ${file}
    rm ${file}
    add-path $(pwd)/openmpi-${version}/bin
}

# GPU clock frequency
print-nv-clocks() {
    nvidia-smi --query-gpu=index,timestamp,power.draw,clocks.sm,clocks.mem,clocks.gr,clocks.max.sm,clocks.max.mem,clocks.max.gr --format=csv
}

lock-nv-clocks() {
    for i in $(nvidia-smi --query-gpu=index --format=csv,noheader,nounits); do
        max_gr=$(nvidia-smi --query-gpu=clocks.max.gr --format=csv,noheader,nounits -i $i)
        nvidia-smi -lgc $max_gr -i $i
    done
}

ws-init() {
	sudo docker run -d \
		--volume workspace:/root/workspace \
		--volume /mnt:/root/mnt \
		--network host \
		--gpus all \
		--name yuyangh-workspace yuyangh-workspace:latest \
		tail -f /dev/null
}

ws-shell() {
	sudo docker exec -it yuyangh-workspace fish
}

# short for ws-shell
ws() {
	ws-shell
}

ws-restart() {
	sudo docker stop yuyangh-workspace \
		&& sudo docker start yuyangh-workspace
}
