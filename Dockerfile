## FROM docker.io/library/ubuntu:21.10
# FROM docker.io/library/ubuntu:22.04
## FROM docker.io/library/ubuntu:23.04

# this hack suggested here: https://askubuntu.com/questions/1513927/ubuntu-24-04-docker-images-now-includes-user-ubuntu-with-uid-gid-1000
FROM docker.io/library/ubuntu:24.04 
RUN touch /var/mail/ubuntu && chown ubuntu /var/mail/ubuntu && userdel -r ubuntu
# FROM docker.io/library/ubuntu:24.04

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

# Added this locale execution and environment to get around some warnings that were showing in nvim checkhealth.
# Tried moving them into setup_home.sh but (for some reason (?)) that didn't work.
RUN apt-get update -y 

RUN apt-get install -y \
    locales

RUN locale-gen en_US.UTF-8  
ENV LANG en_US.UTF-8  
ENV LANGUAGE en_US:en  
ENV LC_ALL en_US.UTF-8  


# set up the user
RUN apt-get install -y \
    adduser

RUN adduser --disabled-password --gecos '' --uid $id $user 

COPY setup_sudo.sh /tmp
RUN /tmp/setup_sudo.sh $user

USER $user
# remember for future use; some scripts depend on USER being set
ENV USER $user

COPY --chown=$USER install_loggedsetup.sh /tmp
RUN /tmp/install_loggedsetup.sh

COPY --chown=$USER install_basics.sh /tmp
RUN /tmp/install_basics.sh

COPY --chown=$USER build_ctags.sh /tmp
RUN /tmp/build_ctags.sh

COPY --chown=$USER install_vscode.sh /tmp
RUN /tmp/install_vscode.sh

COPY --chown=$USER build_latest_neovim.sh /tmp
RUN /tmp/build_latest_neovim.sh

COPY --chown=$USER setup_home.sh /tmp
RUN /tmp/setup_home.sh

