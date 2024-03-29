#!/bin/bash

# DOCKER_BUILDKIT=1 docker build \
#     --output amazonlinux \
#     --build-arg="OSO_VERSION=0.27.2" \
#     --file Dockerfile.amazonlinux \
#     --target runtime \
#     .

# DOCKER_BUILDKIT=1 docker build \
#     --output debian \
#     --build-arg="OSO_VERSION=0.27.2" \
#     --file Dockerfile.debian \
#     --target runtime \
#     .

DOCKER_BUILDKIT=1 docker build \
    --output . \
    --build-arg="OSO_VERSION=0.27.3" \
    --target runtime \
    .