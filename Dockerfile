FROM docker.io/library/ubuntu:21.10

## per https://stackoverflow.com/questions/8671308/non-interactive-method-for-dpkg-reconfigure-tzdata
## may need work.  refer back to so for details.
ENV DEBIAN_FRONTEND noninteractive
ENV DEBCONF_NONINTERACTIVE_SEEN=true


## per https://stackoverflow.com/questions/8671308/non-interactive-method-for-dpkg-reconfigure-tzdata


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
# remember for future use; some scripts depend on USER being set
ENV USER $user

COPY install_basics.sh /tmp
RUN sudo /tmp/install_basics.sh

COPY build_ctags.sh /tmp
RUN sudo /tmp/build_ctags.sh

COPY install_vscode.sh /tmp
RUN sudo /tmp/install_vscode.sh

COPY --chown=$USER setup_home.sh /tmp
RUN /tmp/setup_home.sh

