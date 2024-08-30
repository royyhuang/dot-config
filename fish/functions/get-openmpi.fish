function get-openmpi
    set --local version "-5.0.5"
    set --local file openmpi-{$version}.tar.gz
    set --local url "https://download.open-mpi.org/release/open-mpi/v5.0/$file"
    curl -L $url -o $file
    tar xvzf $file
    rm ${file}
	pushd openmpi-{$version}
	./configure --prefix=$HOME/.local 2>&1 | tee config.out
	make -j (nproc) all 2>&1 | tee make.out
	make install 2>&1 | tee install.out
	popd
end
