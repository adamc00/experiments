#!/usr/bin/env bash

set -e

IMAGE=docker.sdlocal.net/devel/stratperldancer

docker pull ${IMAGE}:latest
docker tag ${IMAGE}:latest ${IMAGE}:latest-amd64
docker push ${IMAGE}:latest-amd64

docker pull ${IMAGE}:aarch64
docker tag ${IMAGE}:aarch64 ${IMAGE}:latest-arm64-v8
docker push ${IMAGE}:latest-arm64-v8

docker manifest create ${IMAGE}:latest-multi-arch \
--amend ${IMAGE}:latest-amd64 \
--amend ${IMAGE}:latest-arm64-v8

docker manifest push ${IMAGE}:latest-multi-arch
