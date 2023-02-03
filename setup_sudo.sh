#! /bin/bash

sudo apt-get update -y
sudo apt-get install -y sudo

echo '%sudo ALL=(ALL) NOPASSWD:ALL' | sudo tee -a /etc/sudoers
sudo adduser $1 sudo 
