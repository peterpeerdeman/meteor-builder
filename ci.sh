#!/bin/bash

set -eu

docker build --pull -t partup/meteor-builder .

docker tag partup/meteor-builder partup/meteor-builder:1.3.2

docker tag partup/meteor-builder partup/meteor-builder:1.3

docker tag partup/meteor-builder partup/meteor-builder:1

docker push partup/meteor-builder
docker push partup/meteor-builder:1.3.2
docker push partup/meteor-builder:1.3
docker push partup/meteor-builder:1
