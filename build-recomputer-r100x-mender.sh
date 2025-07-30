#!/bin/bash

git clone -b main https://github.com/Seeed-Studio/meta-seeed-reterminal.git
git clone -b scarthgap git://git.yoctoproject.org/meta-raspberrypi
git clone -b scarthgap https://github.com/openembedded/meta-openembedded.git
git clone -b scarthgap git://github.com/mendersoftware/meta-mender

source oe-init-build-env # in build dir

bitbake-layers add-layer ../meta-raspberrypi
bitbake-layers add-layer ../meta-seeed-reterminal
bitbake-layers add-layer ../meta-openembedded/meta-oe
bitbake-layers add-layer ../meta-openembedded/meta-python
bitbake-layers add-layer ../meta-mender/meta-mender-core
bitbake-layers add-layer ../meta-mender/meta-mender-raspberrypi
bitbake-layers add-layer ../meta-mender/meta-mender-demo

# modify local.conf to build raspberrypi4 64-bit system
sed -i '/^MACHINE/s/= .*$/= "seeed-recomputer-r100x-mender"/g' conf/local.conf
sed -i 's/#SSTATE_DIR/SSTATE_DIR/g' conf/local.conf

# we don't run start the compile here. 
# because we need to copy the cache to build/ dir before we do that.