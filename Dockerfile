FROM node:0.10

VOLUME /code

VOLUME /out

VOLUME /swp

ENTRYPOINT /build.sh

ENV METEOR_VERSION 1.2.1

ENV METEOR_DOWNLOAD https://d3sqy0vbqsdhku.cloudfront.net/packages-bootstrap/${METEOR_VERSION}/meteor-bootstrap-os.linux.x86_64.tar.gz

RUN cd /root && \
    curl $METEOR_DOWNLOAD | tar xvz && \
    METEOR_SYMLINK_TARGET="$(readlink "/root/.meteor/meteor")" && \
    METEOR_TOOL_DIRECTORY="$(dirname "$METEOR_SYMLINK_TARGET")" && \
    LAUNCHER="/root/.meteor/$METEOR_TOOL_DIRECTORY/scripts/admin/launch-meteor" && \
    cp $LAUNCHER /usr/bin/meteor

ADD build.sh /

