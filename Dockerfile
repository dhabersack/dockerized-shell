FROM ubuntu:17.10

# set locales
ENV LANGUAGE=en_US.UTF-8
ENV LANG=en_US.UTF-8

RUN apt-get update \
 # install applications and locales
 && apt-get install -y \
    curl \
    git \
    locales \
    nodejs \
    npm \
    tmux \
    vim \
    zsh \
 # set locales
 && locale-gen en_US.UTF-8 \
 # set default shell to be zsh
 && chsh -s /usr/bin/zsh \
 # create new user
 && useradd --create-home --shell /usr/bin/zsh dom \
 # change to home directory
 && cd /home/dom \
 # remove unnecessary config files
 && rm .bash_logout .bashrc .profile \
 # install plugin-manager and plugins for vim
 && mkdir -p .vim/autoload .vim/bundle \
 && curl -LSso .vim/autoload/pathogen.vim https://tpo.pe/pathogen.vim \
 && cd .vim/bundle \
 && git clone https://github.com/airblade/vim-gitgutter \
 && git clone https://github.com/ap/vim-css-color \
 && git clone https://github.com/ctrlpvim/ctrlp.vim \
 && git clone https://github.com/kshenoy/vim-signature \
 && git clone https://github.com/mattn/emmet-vim \
 && git clone https://github.com/mxw/vim-jsx \
 && git clone https://github.com/myusuf3/numbers.vim \
 && git clone https://github.com/pangloss/vim-javascript \
 && git clone https://github.com/scrooloose/nerdtree \
 && git clone https://github.com/tomtom/tcomment_vim \
 && git clone https://github.com/tpope/vim-fugitive \
 && git clone https://github.com/tpope/vim-surround

# switch to new user and their home directory
USER dom
WORKDIR /home/dom

# copy configuration files
COPY --chown=dom:dom gitconfig .gitconfig
COPY --chown=dom:dom gitignore_global .gitignore_global
COPY --chown=dom:dom ssh-install.sh ssh-install.sh
COPY --chown=dom:dom tmux.conf .tmux.conf
COPY --chown=dom:dom vimrc .vimrc
COPY --chown=dom:dom zshrc .zshrc

# Jump straight into tmux-session
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
