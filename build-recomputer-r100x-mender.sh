#!/bin/bash

git clone -b scarthgap https://github.com/Seeed-Studio/meta-seeed-cm4.git layers/meta-seeed-cm4
git clone -b scarthgap git://git.yoctoproject.org/meta-raspberrypi layers/meta-raspberrypi
git clone -b scarthgap https://github.com/openembedded/meta-openembedded.git layers/meta-openembedded
git clone -b scarthgap https://github.com/mendersoftware/meta-mender layers/meta-mender
git clone -b scarthgap https://github.com/mendersoftware/meta-mender-community layers/meta-mender-community
git clone -b scarthgap git://git.yoctoproject.org/poky.git layers/poky

source layers/poky/oe-init-build-env # in build dir

bitbake-layers add-layer layers/meta-raspberrypi
bitbake-layers add-layer layers/meta-seeed-cm4
bitbake-layers add-layer layers/meta-openembedded/meta-oe
bitbake-layers add-layer layers/meta-openembedded/meta-python
bitbake-layers add-layer layers/meta-mender/meta-mender-core
bitbake-layers add-layer layers/meta-mender-community/meta-mender-raspberrypi
bitbake-layers add-layer layers/meta-mender/meta-mender-demo

# modify local.conf to build raspberrypi4 64-bit system
sed -i '/^MACHINE/s/= .*$/= "seeed-recomputer-r100x-mender"/g' conf/local.conf
sed -i 's/#SSTATE_DIR/SSTATE_DIR/g' conf/local.conf

# we don't run start the compile here. 
# because we need to copy the cache to build/ dir before we do that.