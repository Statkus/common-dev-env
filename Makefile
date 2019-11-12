.PHONY : install install-bashrc install-gitconfig install-vimrc install-nvimrc

install: install-bashrc install-gitconfig install-vimrc install-nvimrc

install-bashrc:
	cp .bashrc ~/.bashrc

install-gitconfig:
	cat .gitconfig >> ~/.gitconfig

install-vimrc:
	cp .vimrc ~/.vimrc

install-nvimrc:
	mkdir -p ~/.config/nvim/
	cp init.vim ~/.config/nvim/
