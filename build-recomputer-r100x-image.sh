#!/bin/bash

git clone -b main https://github.com/Seeed-Studio/meta-seeed-reterminal.git
git clone -b kirkstone git://git.yoctoproject.org/meta-raspberrypi
git clone -b kirkstone https://github.com/meta-qt5/meta-qt5.git
git clone -b kirkstone https://github.com/openembedded/meta-openembedded.git

source oe-init-build-env # in build dir

bitbake-layers add-layer ../meta-raspberrypi
bitbake-layers add-layer ../meta-seeed-reterminal
bitbake-layers add-layer ../meta-qt5
bitbake-layers add-layer ../meta-openembedded/meta-oe
bitbake-layers add-layer ../meta-openembedded/meta-python

# modify local.conf to build raspberrypi4 64-bit system
sed -i '/^MACHINE/s/= .*$/= "seeed-recomputer-r100x"/g' conf/local.conf
sed -i 's/#SSTATE_DIR/SSTATE_DIR/g' conf/local.conf

# we don't run start the compile here. 
# because we need to copy the cache to build/ dir before we do that.