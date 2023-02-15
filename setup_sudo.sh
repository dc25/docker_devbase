#! /bin/bash

apt-get update -y
apt-get install -y sudo

echo '%sudo ALL=(ALL) NOPASSWD:ALL' | sudo tee -a /etc/sudoers
adduser $1 sudo 
