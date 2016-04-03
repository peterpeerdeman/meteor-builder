#!/bin/bash

set -eu

mkdir -p /swp/{code,build}

echo "Copying the code to /swp/code.."

cp -R /code /swp/

cd /swp/code

echo "Building the meteor app, this might take a while.. (and isn't chatty)"

meteor build /swp/build --directory

cd /swp/build/bundle/programs/server

echo "Running npm install.."

npm install

cd /swp/build/bundle

echo "Packaging up the app.."

tar cfz /out/meteor-app.tgz *

chmod a+rwx /out/meteor-app.tgz

