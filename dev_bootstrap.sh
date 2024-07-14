#!/usr/bin/env bash
set -euxo pipefail
if [[ ${UID} != 0 ]] ; then
    echo "re-executing with sudo"
    sudo "$0" "$@"
else
    # we are root!
    apt-get update
    apt-get upgrade -y
    apt-get install just
    just install_build_deps
    just install_dev_deps
fi