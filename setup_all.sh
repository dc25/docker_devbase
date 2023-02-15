#! /bin/bash 
export DEBIAN_FRONTEND=noninteractive

sudo ./setup_sudo.sh $USER
./install_loggedsetup.sh 
./install_basics.sh
./build_ctags.sh
./build_latest_neovim.sh
./install_vscode.sh
./setup_home.sh

