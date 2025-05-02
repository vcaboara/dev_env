FROM ubuntu:latest

WORKDIR /app

ARG DEBIAN_FRONTEND=noninteractive

# Install necessary packages: git, curl, sudo, and ca-certificates
RUN apt-get update \
    && apt-get install -y --no-install-recommends \
        git \
        curl \
        sudo \
        ca-certificates \
    && rm -rf /var/lib/apt/lists/*

COPY scripts/install_vim.sh vimrc ./

# Run the installer script
RUN cp vimrc .vimrc \
    && ./install_vim.sh

# Keep container running for inspection
CMD ["vim"]
