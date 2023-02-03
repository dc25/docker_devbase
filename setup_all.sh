#! /bin/bash 
export DEBIAN_FRONTEND=noninteractive

sudo ./setup_sudo.sh $USER
./install_loggedsetup.sh 
~/logged_setup.sh ./install_basics.sh
~/logged_setup.sh ./build_ctags.sh
~/logged_setup.sh ./build_latest_neovim.sh
~/logged_setup.sh ./install_vscode.sh
~/logged_setup.sh ./setup_home.sh

