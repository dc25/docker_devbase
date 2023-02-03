#! /bin/bash

sudo apt-get update 

# On ubuntu 20.04 (not 18.04, 20.10) pkg-config install has tz related problems unless tzdata is installed first
# "solution" is combination of so information (https://stackoverflow.com/questions/44331836/apt-get-install-tzdata-noninteractive) and trial and error.
# happened both on docker and podman

sudo apt install -y tzdata

# from https://docs.ctags.io/en/latest/autotools.html#gnu-linux-distributions

sudo apt install -y \
    git gcc make \
    pkg-config autoconf automake \
    python3-docutils \
    libseccomp-dev \
    libjansson-dev \
    libyaml-dev \
    libxml2-dev

cd /tmp

git clone https://github.com/universal-ctags/ctags.git

cd ctags

./autogen.sh
./configure 
make
sudo make install # may require extra privileges depending on where to install
