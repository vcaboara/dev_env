FROM ubuntu:22.04

# Install initial packages
RUN apt-get update \
        && apt-get install -y \
        zsh neovim git screen tmux less htop iotop curl

ENV HOME /home/scratch
RUN useradd -d "$HOME" -u 999 -m -s /bin/zsh scratch

USER scratch
WORKDIR $HOME

COPY vimrc $HOME/.vimrc
COPY zshrc $HOME/.zshrc
COPY profile $HOME/.profile
COPY inputrc $HOME/.inputrc

# RUN vim +PluginInstall +qall

# CMD zsh
CMD [ "bash" ]
