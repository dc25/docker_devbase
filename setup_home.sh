#! /bin/bash

function setup_sshkey
{
    if  [ -e $HOME/.ssh/id_rsa ] 
    then
        echo $HOME/.ssh/id_rsa already exists.
    else 
        echo creating $HOME/.ssh/id_rsa 
        ssh-keygen -N '' -f ~/.ssh/id_rsa <<< y
    fi
}

function setup_tmuxconf
{
    cat > ~/.tmux.conf << 'DONE'

# added per https://github.com/tmux/tmux/issues/224
set -ag terminal-overrides ',*:cud1=\E[1B'

# suggested in : https://stackoverflow.com/questions/12312178/tmux-and-vim-escape-key-being-seen-as-and-having-long-delay
# took care of long delays after pressing esc in both nvim and vim
set -s escape-time 0

DONE

}



function setup_vimrc
{
    touch ~/vimrc
    touch ~/.vimrc

    echo so ~/vimrc | tee -a ~/.vimrc
}

function setup_neovimrc
{
    touch ~/vimrc
    mkdir -p ~/.config/nvim
    touch ~/.config/nvim/init.vim
    echo so ~/vimrc | tee -a ~/.config/nvim/init.vim
}


function setup_myBashrc
{
cat > ~/myBashrc << 'DONE'
alias cdgit='cd $REPOS/git'
alias cdgnc='cd $REPOS/gitnc'

alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias .....='cd ../../../..'
alias ......='cd ../../../../..'
alias .......='cd ../../../../../..'

# --no-xshm per: https://github.com/microsoft/vscode/issues/101069
function vsc
{
    /usr/bin/code --no-xshm "$@"
}

function code
{
    echo "code" will have problems in this environment.   Use "vsc" instead.
}

function gitid
{
  git config --global user.email "davecompton7@gmail.com"    
  git config --global user.name "Dave Compton"  
}

DONE
echo . ~/myBashrc | tee -a ~/.bashrc
}

function setup_devbaseVimrc
{
cat > ~/devbaseVimrc << 'DONE'
set sw=4
set ts=4
set expandtab
set ic
set fileformat=unix
set encoding=utf-8
DONE

echo so ~/devbaseVimrc | tee -a ~/vimrc
}

setup_sshkey
setup_tmuxconf
setup_vimrc
setup_neovimrc
setup_myBashrc
setup_devbaseVimrc
