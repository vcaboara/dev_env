#!/bin/sh
APPS_LIST="vim neovim screen workrave chromium-browser git openssh-server \
	python-pip build-essential cmake python-dev exfat-fuse curl \
	exfat-utils iotop htop apt-transport-https ca-certificates docker-ce"

PYTHON_MODULES="argparse"

# TODO: Install handbrake, makemkv, privaite internet access,
# TODO: Setup bashrc|bash_profile (macOS uses _profile)
# TODO: Setup .vimrc (neovim)

# add neovim ppa
add-apt-repository -y ppa:neovim-ppa/unstable

# Update your local package index:
apt-get update # To get the latest package lists
apt-get upgrade -y
apt-get install -y $APPS_LIST

python -m pip install $PYTHON_MODULES

# Install vim-plugin
curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

# Install fzf
#git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
#~/.fzf/install
