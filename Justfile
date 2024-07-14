build_deps := "build-essential git curl wget qemu-user-static "
dev_deps := "vim-tiny- vim-common- neovim strace"

_list:
    just --list

# Upgrade apt packages
apt_update:
    apt-get update
    apt-get upgrade -y

# Install build dependencies
install_build_deps:
    apt-get install -y

# Clean all .gitignore'd files
clean:
    git clean -Xf

# Build the image
image:
    bash -x ./create_kindle_alpine_image.sh

# Create release zipfile
release: image
    ./create_release.sh

# Run all the CI tasks: install_build_deps, clean, image, release
ci: install_build_deps clean image release