#!/bin/bash

git clone -b master git://git.yoctoproject.org/meta-raspberrypi

# modify the meta-raspberrypi to avoid compile error
cd meta-raspberrypi/
rm dynamic-layers/meta-python/recipes-connectivity/lirc/*.bbappend
sed -i '/^LAYERSERIES_COMPAT_raspberrypi/s/= .*$/= "honister dunfell"/g' conf/layer.conf
sed -i 's/arm\/armv8a\///g' conf/machine/raspberrypi4-64.conf
git diff .
cd ..

source oe-init-build-env # in build dir

bitbake-layers add-layer ../meta-raspberrypi

# modify local.conf to build raspberrypi4 64-bit system
sed -i '/^MACHINE/s/= .*$/= "raspberrypi4-64"/g' conf/local.conf

# building image
bitbake rpi-test-image
