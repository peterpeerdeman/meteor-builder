# meteor-builder
Builds a meteor package on linux x64 that can be put onto a nodejs image.

Running this image lets you end up with a `meteor-app.tgz` that you can unpack onto the node:0.10-slim image.
This way, you don't have the meteor distribution sitting in your production container.

## Usage

The container has 3 volumes:
- `/code`, which contains the source code.
- `/swp`, which is used as a place to build the app. Going around the union file system speeds things up loads.
- `/out`, which will contain the meteor-app.tgz that gets generated.

From your meteor app folder, do something like the following:
```
set -eu
container_id=$(docker create -v $(pwd):/code $(pwd)/../build:/out partup/meteor-builder)
docker start -a $container_id
docker rm -f -v $container_id
```

You will then have a meteor-app.tgz in your build folder next to your meteor app folder. You can unpack this tgz in another node image and create a minimal meteor docker container:

Example Dockerfile:
```
FROM node:0.10-slim

EXPOSE 3000

RUN apt-get update && \
    apt-get install -y imagemagick --no-install-recommends && \
    rm -rf /var/lib/apt/lists/* && \
    apt-get autoclean && \
    apt-get clean

ADD app-build/meteor-app.tgz /app

CMD node /app/main.js
```

