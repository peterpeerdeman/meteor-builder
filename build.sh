#!/bin/bash

set -eu

mkdir -p /swp/{code,build}

echo "Copying the code to /swp/code.."

cp -R /code /swp/

cd /swp/code

echo "Installing meteor npm dependencies (since meteor 1.3.2.4)"

meteor npm install --production

echo "Building the meteor app, this might take a while.."

meteor build --verbose /swp/build --directory

cd /swp/build/bundle/programs/server

echo "Running meteor npm install.. (for npm-packages before meteor 1.3.2.4)"

npm install

cd /swp/build/bundle

echo "Packaging up the app.."

tar cfz /out/meteor-app.tgz *

chmod a+rwx /out/meteor-app.tgz
