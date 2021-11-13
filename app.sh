#!/bin/bash

github="hub.fastgit.org"
url="https://${github}/neovim/neovim/releases/download/v0.5.0/nvim.appimage"
curr_dir=$(cd "$(dirname "$0")";pwd)
node_url="https://nodejs.org/dist/v14.16.1/node-v14.16.1-linux-x64.tar.xz"
version="v14.16.1"
distro="linux-x64"


install_nvim(){
	yum install wget python3 python2-pip gcc autoconf automake -y

	wget $url
	chmod u+x nvim.appimage
	./nvim.appimage --appimage-extract
	sudo mv squashfs-root / && sudo ln -s /squashfs-root/AppRun /usr/local/bin/nvim
	sudo python3 -m pip install neovim
	sudo python2 -m pip install neovim
 	sudo python3 -m pip install jedi
	ls nvim.appimage | xargs rm
	curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs https://raw.fastgit.org/junegunn/vim-plug/master/plug.vim
}

install_node(){
	wget ${node_url}
	sudo mkdir -p /usr/local/lib/nodejs
	tar -xJvf node-$version-$distro.tar.xz -C /usr/local/lib/nodejs
	echo "export PATH=/usr/local/lib/nodejs/node-$version-$distro/bin:$PATH" | tee -a  ~/.bashrc
	source  ~/.bashrc
	npm install -g yarn
	npm install -g neovim

	yarn config set registry https://registry.npm.taobao.org -g
	yarn config set sass_binary_site http://cdn.npm.taobao.org/dist/node-sass -g

	ls node-$version-$distro.tar.xz | xargs rm
}

install_ranger(){
	python3 -m pip install ranger-fm
	git clone https://hub.fastgit.org/ranger/ranger.git
	cd ranger
	sudo make install

	cd ${curr_dir}
	ls -d ranger | xargs rm -rf

}

install_fzf(){
	git clone --depth 1 https://hub.fastgit.org/junegunn/fzf.git ~/.fzf
	sed -i 's@github.com@hub.fastgit.org@g' ~/.fzf/install
	~/.fzf/install
	/bin/cp -f ~/.fzf/bin/fzf /usr/local/bin/
}

install_rg(){
	export RUSTUP_DIST_SERVER=https://mirrors.ustc.edu.cn/rust-static
	export RUSTUP_UPDATE_ROOT=https://mirrors.ustc.edu.cn/rust-static/rustup
	curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
	source $HOME/.cargo/env

	echo "[source.crates-io]" | tee $HOME/.cargo/config
	echo "registry = 'https://hub.fastgit.org/rust-lang/crates.io-index'" | tee -a $HOME/.cargo/config
	echo "replace-with = 'ustc'" | tee -a $HOME/.cargo/config
	echo "[source.ustc]" | tee -a $HOME/.cargo/config
	echo "registry = 'git://mirrors.ustc.edu.cn/crates.io-index'" | tee -a $HOME/.cargo/config

	git clone https://hub.fastgit.org/BurntSushi/ripgrep
	cd ripgrep
	cargo build --release
	/bin/cp -rf ./target/release/rg /usr/local/bin/

	cd ${curr_dir}
	ls -d ripgrep | xargs rm -rf
}

install_ctags(){
	git clone https://hub.fastgit.org/universal-ctags/ctags.git
	cd ctags
	./autogen.sh
	./configure --prefix=/usr/local
	make && make install

	cd ${curr_dir}
	ls -d ctags | xargs rm -rf
}

copy_file(){

	echo "111"
	# [ ! -d $HOME/.config ] && mkdir -p $HOME/.config
	# /bin/cp -rf ${curr_dir}/nvim $HOME/.config/
}

main(){

    if [ $# -ne 1 ];then
	echo "Usage: bash $0 <deploy|intsll|update|remove>"
	exit 1
    fi

    if [ "$1" == "deploy" ];then
    	install_nvim
	install_node
	install_ranger
	install_fzf
	install_rg
	install_ctags
    elif [ "$1" == "install" ];then
	echo "安装插件"
    elif [ "$1" == "update" ];then
	echo "更新插件"
    elif [ "$1" == "remove" ];then
	echo "卸载插件"
    else
	echo "Usage: bash $0 <deploy|intsll|update|remove>"
	exit 1
    fi
}


main $@
