# Using PN71XX with libnfc on Debian
This repository contains instructions for PN71XX support in libnfc on Debian.

## Contents
* `debian/changelog`: Additional entry to Debian's `changelog` file in source package
* `debian/patches/`: The raw patches that are being applied by the Debian patch
* `debian/rules.patch`: Patch for Debian package `rules`
* `build_deb.sh`: Automatically builds and installs patched libnfc version
* `patch_deb_rules.sh`: Applies patches to Debian build system (changelog, patch series, rules, ...)

## How-To
To use the PN71XX with libnfc, one must first install `libnfc-nci` and then install a patched `libnfc` version.

### libnfc-nci
1. Download [the libnfc-nci source code](https://github.com/NXPNFCLinux/linux_libnfc-nci)
2. Install build dependencies: `$ apt install autotools aclocal automake libtool`
3. `$ ./bootstrap`
4. `$ ./configure --enable-alt`
5. `$ make`
6. `$ make install`. This installs the library to `/usr/local/`.

### libnfc
`build_deb.sh` performs the following steps automatically:
1. Download `libnfc` source package: `$ apt-get source libnfc`
2. Install build dependencies: `$ apt build-dep libnfc`
3. Apply patches to Debian build system: `$ ./patch_deb_rules.sh {path-to-downloaded-libnfc}`
4. Change to `libnfc-1.7.1/debian` directory
5. Building: `$ debuild -b -uc -us`
6. Install packages using `$ dpkg -i`


## Usage
1. Define connection string in `/etc/nfc/libnfc.conf`. For example on RaspberryPI: `device.connstring = "pn71xx:/dev/i2c-1"`
2. Use `libnfc` as usual
