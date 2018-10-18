#!/bin/sh
set -e

BUILD_DIR=$(mktemp -d -p .)
REPO_DIR=$(pwd)

echo "Building in $BUILD_DIR"

# prepare
cd "$BUILD_DIR"
apt-get source libnfc
sudo apt-get build-dep libnfc
cd "$REPO_DIR"
$REPO_DIR/patch_deb_rules.sh "$BUILD_DIR/libnfc-1.7.1/"

# build
cd "$BUILD_DIR/libnfc-1.7.1/debian"
debuild -b -uc -us

# install
sudo dpkg -i ../../libnfc*.deb
