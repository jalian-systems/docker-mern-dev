FROM node as base

## for apt to be noninteractive
ARG DEBIAN_FRONTEND=noninteractive
ARG DEBCONF_NONINTERACTIVE_SEEN=true

ENV GLOBAL_NPM_PACKAGES webpack webpack-dev-server karma-cli protractor typescript @angular/cli gulpjs/gulp-cli grunt-cli yo generator-generator generator-node forever nodemon node-supervisor ava javascript-typescript-langserver

FROM base as development
RUN apt-get update && \
    apt-get upgrade -y && \
    apt-get install -y lynx tmux neovim curl locales-all \
            python-dev python-pip python3-dev python3-pip sudo cmake fonts-powerline && \
    npm install -g $GLOBAL_NPM_PACKAGES && \
    pip2 install --upgrade neovim && \
    pip3 install --upgrade neovim

RUN adduser --disabled-password --gecos '' dev
RUN adduser dev sudo
RUN echo '%sudo ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers

COPY ./_vim /home/dev/.config/nvim
COPY .tmux/.tmux.conf /home/dev
RUN chown -R dev:dev /home/dev/.config /home/dev/.tmux.conf

RUN echo 'export LANG=en_US.UTF-8' >> /home/dev/.profile && \
    echo 'export LC_CTYPE=en_US.UTF-8' >> /home/dev/.profile && \
    echo 'export PATH=$PATH:~/.config/nvim/.fzf/bin' >> /home/dev/.profile && \
    echo '[ -f ~/.additions/profile ] && source ~/.additions/profile' >> /home/dev/.profile

# install fixuid
RUN USER=dev && \
    GROUP=dev && \
    curl -SsL https://github.com/boxboat/fixuid/releases/download/v0.4/fixuid-0.4-linux-amd64.tar.gz | tar -C /usr/local/bin -xzf - && \
    chown root:root /usr/local/bin/fixuid && \
    chmod 4755 /usr/local/bin/fixuid && \
    mkdir -p /etc/fixuid && \
    printf "user: $USER\ngroup: $GROUP\npaths: [ '/home/dev' ]\n" > /etc/fixuid/config.yml
ENTRYPOINT ["fixuid"]

USER dev:dev

WORKDIR /home/dev

CMD [ "/bin/bash" ]
