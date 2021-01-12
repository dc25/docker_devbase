FROM docker.io/library/ubuntu:20.10

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update && apt-get install -y \
    net-tools \
    sudo \
    tmux \
    vim

######################################################################
# install some generally useful dev utilities

COPY build_ctags.sh /tmp
RUN /tmp/build_ctags.sh

COPY install_vscode.sh /tmp
RUN /tmp/install_vscode.sh

######################################################################
# set up the user

ARG user
ARG id

# remember for future use; some scripts depend on USER being set
ENV USER $user

RUN echo '%sudo ALL=(ALL) NOPASSWD:ALL' | tee -a /etc/sudoers
RUN adduser --disabled-password --gecos '' --uid $id $USER 
RUN adduser $USER sudo 

USER $USER

COPY --chown=$user tmux.conf  /tmp
RUN cp /tmp/tmux.conf ~/.tmux.conf

COPY --chown=$USER setup_vimrc.sh /tmp
RUN /tmp/setup_vimrc.sh

COPY --chown=$USER devbaseVimrc /tmp
RUN cp /tmp/devbaseVimrc ~
RUN echo so ~/devbaseVimrc | tee -a ~/vimrc

