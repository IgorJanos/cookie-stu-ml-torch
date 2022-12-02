#!/usr/bin/env bash

# Fail on error and unset variables.
set -eu -o pipefail

CWD=$(readlink -e "$(dirname "$0")")
cd "${CWD}/.." || exit $?
source ./docker/common.sh

DEVICE=0
echo "Using GPU devices: ${DEVICE}"

export USER_NAME=$(whoami)

docker run \
    -it --rm \
    --name "{{cookiecutter.project_name}}" \
    --gpus all \
    --privileged \
    --shm-size 8g \
    -v "${CWD}/..":/workspace \
    -v "/mnt/scratch/${USER_NAME}":/mnt/scratch \
    -v "/mnt/persist/${USER_NAME}":/mnt/persist \
    -v "/mnt/cache":/mnt/cache \
    -e CUDA_VISIBLE_DEVICES="${DEVICE}" \
    ${IMAGE_TAG} \
    "$@" || exit $?
