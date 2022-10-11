#! /bin/bash

# required because vim-lsp needs a recent version of vim to work correctly.
# testing shows same to be true for neovim also

# see: https://github.com/prabirshrestha/vim-lsp/issues/320

export DEBIAN_FRONTEND=noninteractive

apt-get update 

# taken from vim installs
apt-get install -y \
    git  \
    make  \
    gcc  \
    libncurses-dev

# additionally needed by neovim
apt-get install -y        \
    ninja-build           \
    gettext               \
    libtool               \
    libtool-bin           \
    autoconf              \
    automake              \
    cmake                 \
    g++                   \
    pkg-config            \
    unzip                 \
    curl                  \
    doxygen

# additionally needed by neovim in the past - leaving here just in case
apt-get install -y      \
   libpthread-workqueue-dev  \

cd /tmp

git clone https://github.com/neovim/neovim.git

cd neovim
git checkout stable
make CMAKE_BUILD_TYPE=RelWithDebInfo
make install
