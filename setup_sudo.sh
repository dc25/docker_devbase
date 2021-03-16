#! /bin/bash

echo '%sudo ALL=(ALL) NOPASSWD:ALL' | tee -a /etc/sudoers
adduser $1 sudo 
