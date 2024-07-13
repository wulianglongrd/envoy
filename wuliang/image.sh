#!/usr/bin/env bash

cd ../ci

# see ci/run_envoy_docker.sh

. "$(dirname "$0")"/envoy_build_sha.sh

IMAGE_NAME="envoyproxy/envoy-build-ubuntu"
IMAGE_ID="${ENVOY_BUILD_SHA}@sha256:${ENVOY_BUILD_CONTAINER_SHA}"
ENVOY_BUILD_IMAGE="${IMAGE_NAME}:${IMAGE_ID}"

echo "$ENVOY_BUILD_IMAGE"