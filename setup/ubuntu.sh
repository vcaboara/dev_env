#!/bin/sh
APPS_LIST="neovim screen workrave chromium-browser \
	git openssh-server python-pip build-essential cmake \
	python-dev exfat-fuse exfat-utils iotop apt-transport-https \
	ca-certificates virtualbox docker-engine"

PYTHON_MODULES="argparse"

# add neovim ppa
add-apt-repository -y ppa:neovim-ppa/unstable

# Update your local package index:
apt-get update # To get the latest package lists
apt-get upgrade -y
apt-get install -y $APPS_LIST

curl -L https://github.com/docker/compose/releases/download/1.8.0/docker-compose-`uname -s`-`uname -m` > /usr/local/bin/docker-compose
chmod +x /usr/local/bin/docker-compose

python -m pip install $PYTHON_MODULES

# Install Vundle
#git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim

# Install YCM
#cd ~/.vim/bundle/YouCompleteMe
#./install.py
