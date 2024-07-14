build_deps := "git curl wget qemu-user-static zip"
dev_deps := "vim-tiny- vim-common- neovim strace qemu-guest-agent"

_list:
    just --list

# Upgrade apt packages
apt_update:
    sudo apt-get update
    sudo apt-get upgrade -y

# Install build dependencies
install_build_deps: apt_update
    sudo apt-get install -y {{build_deps}}

# Install dev dependencies
install_dev_deps: apt_update
    apt-get install -y {{dev_deps}}

# Clean all .gitignore'd files
clean:
    git clean -Xf

# Build the image
image:
    bash -x ./create_kindle_alpine_image.sh

# Create release zipfile
release: #image
    ./create_release.sh

# Run all the CI tasks: install_build_deps, clean, image, release
ci: install_build_deps clean image release