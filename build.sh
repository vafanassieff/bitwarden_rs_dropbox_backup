#!/usr/bin/env bash

set -e

NAME="bitwarden_rs_dropbox"

cd ./docker

if [ ! -z "$registry" ]; then
    # For docker hub ...
    IMAGE_NAME="vafanassieff/$NAME"
    docker build -t $IMAGE_NAME:latest .
    docker push $IMAGE_NAME:$VERSION

    # For my personal registry ...
    IMAGE_NAME="registry.afa.ovh/$NAME"
    docker build -t $IMAGE_NAME:latest .
    docker push $IMAGE_NAME:$VERSION
else
    IMAGE_NAME="$NAME"
    docker build -t $IMAGE_NAME:dev .
fi
