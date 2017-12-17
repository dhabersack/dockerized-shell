FROM ubuntu:17.10

# Install main packages
RUN apt-get update && apt-get install -y \
    git \
    tmux \
    vim \
    zsh
RUN chsh -s /usr/bin/zsh

COPY tmux.conf /etc/tmux.conf
copy zshrc /etc/zsh/zshrc

ENTRYPOINT ["tmux", "new-session", "-s", "islovely"]

# Install docker
# RUN apt-get update && apt-get install -y \
#     apt-transport-https \
#     ca-certificates \
#     curl \
#     software-properties-common
# RUN curl -fsSL https://download.docker.com/linux/ubuntu/gpg | apt-key add -
# RUN add-apt-repository \
#    "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
#    $(lsb_release -cs) \
#    stable"
# RUN apt-get update && apt-get install -y docker-ce
