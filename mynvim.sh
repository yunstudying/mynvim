#!/bin/bash

github="hub.fastgit.org"
url="https://${github}/neovim/neovim/releases/download/v0.5.0/nvim.appimage"
curr_dir=$(cd "$(dirname "$0")";pwd)
node_url="https://nodejs.org/dist/v14.16.1/node-v14.16.1-linux-x64.tar.xz"
version="v14.16.1"
distro="linux-x64"
vim_path="$HOME/.config/nvim"


install_nvim(){
	yum install wget python3 python2-pip gcc autoconf automake git -y

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
	echo "Usage: bash $0 <deploy|intsll|update>"
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
	git submodule add -f https://${github}/junegunn/fzf.git pack/plugins/opt/fzf
	git submodule add -f https://${github}/junegunn/fzf.vim.git pack/plugins/opt/fzf.vim
	git submodule add -f https://${github}/Yggdroot/LeaderF.git pack/plugins/opt/LeaderF
	git submodule add -f https://${github}/preservim/nerdtree.git pack/plugins/opt/nerdtree
	git submodule add -f https://${github}/kevinhwang91/rnvimr.git pack/plugins/opt/rnvimr
	git submodule add -f https://${github}/vim-autoformat/vim-autoformat.git pack/plugins/opt/vim-autoformat
	git submodule add -f https://${github}/tpope/vim-commentary.git pack/plugins/opt/vim-commentary
	git submodule add -f https://${github}/airblade/vim-rooter.git pack/plugins/opt/vim-rooter
	git submodule add -f https://${github}/liuchengxu/vista.vim.git pack/plugins/opt/vista.vim

	git submodule add -f https://${github}/neoclide/coc.nvim.git pack/plugins/start/coc.vim
	git submodule add -f https://${github}/itchyny/lightline.vim.git pack/plugins/start/lightline.vim
	git submodule add -f https://${github}/joshdick/onedark.vim.git pack/plugins/start/onedark.vim
	git submodule add -f https://${github}/bagrat/vim-buffet.git pack/plugins/start/vim-buffet
	git submodule add -f https://${github}/voldikss/vim-floaterm.git pack/plugins/start/vim-floaterm
	git submodule add -f https://${github}/mhinz/vim-startify.git pack/plugins/start/vim-startify
	git submodule add -f https://${github}/tpope/vim-surround.git pack/plugins/start/vim-surround


	cd pack/plugins/start/coc.vim && yarn install

	
	cd ${curr_dir}/
	[ ! -d $HOME/.config/nvim ] && mkdir -p $HOME/.config/nvim
	/bin/cp -rf ${curr_dir}/pack $HOME/.config/nvim/
	/bin/cp -rf ${curr_dir}/init.vim $HOME/.config/nvim/
	/bin/cp -rf ${curr_dir}/config $HOME/.config/nvim/

    elif [ "$1" == "update" ];then
	git submodule update --recursive

	cd ${curr_dir}/
	[ ! -d $HOME/.config/nvim ] && mkdir -p $HOME/.config/nvim
	/bin/cp -rf ${curr_dir}/pack $HOME/.config/nvim/
    else
	echo "Usage: bash $0 <deploy|intsll|update|remove>"
	exit 1
    fi
}


main $@
