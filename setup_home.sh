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


function setup_devbaseBashrc
{
cat > ~/devbaseBashrc << 'DONE'
alias cdgit='cd $REPOS/git'
alias cdgnc='cd $REPOS/gitnc'
alias cdtmp='cd $REPOS/../tmp'

alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias .....='cd ../../../..'
alias ......='cd ../../../../..'
alias .......='cd ../../../../../..'

alias allup="sudo apt update -y; sudo apt upgrade -y; sudo apt autoremove -y"
alias gadsafe='git config --global --add safe.directory `pwd`'

# --no-xshm per: https://github.com/microsoft/vscode/issues/101069
function vsc
{
    /usr/bin/code --no-xshm "$@"
}

function code
{
    echo "code" will have problems in this environment.   Use "vsc" instead.
}

DONE
echo . ~/myBashrc | tee -a ~/.bashrc
echo . ~/devbaseBashrc | tee -a ~/myBashrc
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

map <F8> :'c,.w! $REPOS/../tmp/xxx
map <F9> :r $REPOS/../tmp/xxx

map <F11> :call lsp#enable_diagnostics_for_buffer()
map <F12> :call lsp#disable_diagnostics_for_buffer()

" per: https://superuser.com/questions/634326/how-can-i-get-a-block-cursor-in-vim-in-the-cygwin-terminal
" to get the cursor to be a block
let &t_ti.="\e[1 q"
let &t_SI.="\e[5 q"
let &t_EI.="\e[1 q"
let &t_te.="\e[0 q"

DONE

echo so ~/devbaseVimrc | tee -a ~/vimrc
}

setup_sshkey
setup_tmuxconf
setup_vimrc
setup_neovimrc
setup_devbaseBashrc
setup_devbaseVimrc
