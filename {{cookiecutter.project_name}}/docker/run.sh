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
    --mount type=bind,source="/mnt/scratch/${USER_NAME}",target=/mnt/scratch \
    --mount type=bind,source="/mnt/persist/${USER_NAME}",target=/mnt/persist \
    --mount type=bind,source="/mnt/cache",target=/mnt/cache \
    -e CUDA_VISIBLE_DEVICES="${DEVICE}" \
    ${IMAGE_TAG} \
    "$@" || exit $?
