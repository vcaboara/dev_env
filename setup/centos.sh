#!/bin/sh
APPS_LIST="epel-release screen git openssh-server python-pip iotop docker"

PYTHON_MODULES="argparse"

# Update your local package index:
yum update # To get the latest package lists
yum upgrade -y
yum install -y $APPS_LIST

# add neovim (requires epel-release)
curl -o /etc/yum.repos.d/dperson-neovim-epel-7.repo https://copr.fedorainfracloud.org/coprs/dperson/neovim/repo/epel-7/dperson-neovim-epel-7.repo 
yum -y install neovim

python -m pip install $PYTHON_MODULES

# Install vim-plugin
curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

# Install fzf
git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
~/.fzf/install
