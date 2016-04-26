#!/bin/sh
APPS_LIST="vim zsh screen git openssh-server python-pip build-essential cmake \
	python-dev"
PYTHON_MODULES="argparse"

# Update your local package index:
apt-get update # To get the latest package lists
apt-get install -y $APPS_LIST

python -m pip install $PYTHON_MODULES

# Install Vundle
git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim

# Install YCM
cd ~/.vim/bundle/YouCompleteMe
./install.py
