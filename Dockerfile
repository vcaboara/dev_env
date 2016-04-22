FROM ubuntu:latest

# Install initial packages
RUN apt-get update \
        && apt-get install -y vim git zsh screen python-dev

# Vundle: YouCompleteMe dependencies
RUN apt-get install -y \
        cpp \
        gcc \
        libc6 \
        build-essential \
        cmake

RUN apt-get install -y \
        python

ENV HOME /home/scratch
RUN useradd -d "$HOME" -u 999 -m -s /bin/zsh scratch

USER scratch
WORKDIR $HOME

COPY vimrc $HOME/.vimrc
COPY zshrc $HOME/.zshrc
COPY profile $HOME/.profile
COPY inputrc $HOME/.inputrc

RUN git clone https://github.com/gmarik/Vundle.vim.git \
        $HOME/.vim/bundle/Vundle.vim
# Compile YCM
RUN cd $HOME/.vim/bundle/ \
        && git clone https://github.com/Valloric/YouCompleteMe.git \
        && cd YouCompleteMe \
        && git submodule update --init --recursive

RUN $HOME/.vim/bundle/YouCompleteMe/install.py

RUN vim +PluginInstall +qall

CMD zsh
