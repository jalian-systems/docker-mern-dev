# Docker image for MERN development

Run MERN stack along with fully loaded tmux and vim.

> Use this only for development purposes.

## Overview

This docker image is useful when you have a powerful server that can be shared among multiple
developers. A preloaded [fixuid] (https://github.com/boxboat/fixuid) is configured to handle
the file permissions issues within the container.

## Credentials

This image creates a `dev` user for your development projects.

Use your own uid and gid to execute the docker container. Share your source code by using docker volumes.

```
docker run --rm -it -u 1003:1003 <image name> sh
```

On linux:

```
docker run --rm -it -u $(id -u):$(id -g) -v ./Projects:/home/dev/Projects <image name> sh
```

You can append commands to the `.profile`, `.tmux.conf` and `init.vim` files by attaching a
folder to `/home/dev/.additions` volume.

* .profile .additions/profile
* .tmux.conf .additions/tmux.conf
* init.vim .additions/vimrc

## Docker hub tags

You can use following tags on Docker hub:

* `latest` - latest stable release

## Usage with docker-compose

Have a look at the companion composer file [docker-composer-mern-dev](https://github.com/jalian-systems/docker-composer-mern-dev)
to find how we use this docker image.

## Issues

Please report any issues with the Docker container to https://github.com/jalian-systems/docker-mern-dev/issues
