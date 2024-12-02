#!/bin/bash

set -eu

ARCH=$1
RUN_CMDS=$2
DEBIAN_FRONTEND=noninteractive

install_docker() {
    apt-get update -y
    apt-get install -y curl
    curl -sSL https://get.docker.com/ | sh
}

install_qemu() {
    apt-get update -y
    apt-get -qq install -y qemu-system qemu-user-static
    docker run --rm --privileged multiarch/qemu-user-static --reset -p yes
}

run_on_rhino_linux() {

    docker run --rm --privileged \
        --user root \
        --platform linux/${ARCH} \
        -e DEBIAN_FRONTEND=noninteractive \
        -v "/var/run/docker.sock:/var/run/docker.sock" \
        --entrypoint /bin/bash \
        --tty \
        ghcr.io/rhino-linux/docker:latest -c $RUN_CMDS

}

install_docker

install_qemu

run_on_rhino_linux
