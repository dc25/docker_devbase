FROM docker.io/library/ubuntu:20.10

ENV DEBIAN_FRONTEND noninteractive


#########################################################################
#### Sometimes a badly set clock causes problems with apt-get
###  in this case, run on build machine:  sudo hwclock --hctosys 
#### Thank you: https://askubuntu.com/a/1169203/1176839

######################################################################

ARG id
ARG user=dev

RUN apt-get update && apt-get install -y \
    sudo 

# set up the user
RUN adduser --disabled-password --gecos '' --uid $id $user 

COPY setup_sudo.sh /tmp
RUN /tmp/setup_sudo.sh $user

USER $user

COPY install_basics.sh /tmp
RUN sudo /tmp/install_basics.sh

COPY build_ctags.sh /tmp
RUN sudo /tmp/build_ctags.sh

COPY install_vscode.sh /tmp
RUN sudo /tmp/install_vscode.sh

COPY --chown=$user setup_home.sh /tmp
RUN /tmp/setup_home.sh

# remember for future use; some scripts depend on USER being set
ENV USER $user
