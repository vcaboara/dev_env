FROM ubuntu:22.04

# Install initial packages
RUN apt-get update && \
        # Dev tools/resources
        apt-get install -y \
        neovim git zsh screen tmux less htop iotop curl

ENV SCRATCH_HOME=/home/scratch

RUN useradd -d "$SCRATCH_HOME" -u 999 -m -s /bin/zsh scratch && \
        # Install fzf
        git clone --depth 1 https://github.com/junegunn/fzf.git "$SCRATCH_HOME/.fzf" && \
        "$SCRATCH_HOME/.fzf/install" && \
        chown -R scratch:scratch ${SCRATCH_HOME}

USER scratch
WORKDIR $SCRATCH_HOME

COPY init.vim ${HOME}/.vimrc
# COPY zshrc $HOME/.zshrc
COPY bashrc $HOME/.bashrc
COPY profile $HOME/.profile
COPY inputrc $HOME/.inputrc

# TODO: vim-plug installs
# RUN vim +PlugInstall +qall

# CMD zsh
CMD [ "bash" ]
