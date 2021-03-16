#! /bin/bash 
export DEBIAN_FRONTEND=noninteractive

sudo ./setup_sudo.sh $USER
sudo ./install_basics.sh
sudo ./build_ctags.sh
sudo ./install_vscode.sh
./setup_home.sh

