#!/bin/sh
APPS_LIST="vim zsh screen workrave \
	git openssh-server python-pip build-essential cmake \
	python-dev exfat-fuse exfat-utils iotop apt-transport-https \
	ca-certificates virtualbox"
PYTHON_MODULES="argparse"

apt-key adv --keyserver hkp://p80.pool.sks-keyservers.net:80 --recv-keys 58118E89F3A912897C070ADBF76221572C52609D
echo 'deb https://apt.dockerproject.org/repo ubuntu-xenial main' >> \
	/etc/apt/sources.list.d/docker.list

# Update your local package index:
apt-get update # To get the latest package lists
apt-get upgrade -y
apt-get install -y $APPS_LIST

python -m pip install $PYTHON_MODULES

# Install Vundle
git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim

# Install YCM
#cd ~/.vim/bundle/YouCompleteMe
#./install.py
