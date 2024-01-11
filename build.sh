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
    --tag oso-aarch64:latest \
    --output . \
    --build-arg="OSO_VERSION=0.27.2" \
    --target runtime \
    .