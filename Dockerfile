FROM sshd

COPY --chown=$USER install_vim.sh /tmp
RUN sudo /tmp/install_vim.sh

COPY --chown=$USER build_latest_vim.sh /tmp
RUN sudo /tmp/build_latest_vim.sh

# COPY --chown=$USER install_neovim.sh /tmp
# RUN sudo /tmp/install_neovim.sh

# Building neovim because vim-lsp "signs" work better with later version.
# Saw this both in rust and haskell.
COPY --chown=$USER build_latest_neovim.sh /tmp
RUN sudo /tmp/build_latest_neovim.sh

COPY --chown=$USER setup_vimrc.sh /tmp
RUN sudo /tmp/setup_vimrc.sh

COPY --chown=$USER setup_neovimrc.sh /tmp
RUN sudo /tmp/setup_neovimrc.sh

COPY --chown=$USER build_ctags.sh /tmp
RUN sudo /tmp/build_ctags.sh

COPY --chown=$USER devbaseVimrc /tmp
RUN cp /tmp/devbaseVimrc ~
RUN echo so ~/devbaseVimrc | tee -a ~/vimrc

COPY --chown=$USER install_vscode.sh /tmp
RUN sudo /tmp/install_vscode.sh
