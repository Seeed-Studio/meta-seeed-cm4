#!/bin/bash

git clone -b dunfell https://github.com/Seeed-Studio/meta-seeed-reterminal.git
git clone -b kirkstone git://git.yoctoproject.org/meta-raspberrypi
git clone -b dunfell https://github.com/meta-qt5/meta-qt5.git
git clone -b dunfell https://github.com/openembedded/meta-openembedded.git

#backup the files we need to change in dunfell
cd meta-raspberrypi/
cp -r recipes-bsp/bootfiles/ ../
cp -r recipes-kernel/linux/ ../
git checkout dunfell

#copy the rpi-bootfiles to dunfell
rm -r recipes-bsp/bootfiles/
mv -f ../bootfiles/ recipes-bsp/
mv recipes-bsp/bootfiles/rpi-bootfiles.bb recipes-bsp/bootfiles/bootfiles.bb

#change the kernel version to 5.10+
rm -r recipes-kernel/linux/
mv -f ../linux/ recipes-kernel/
echo "PREFERRED_VERSION_linux-raspberrypi ?= \"5.10.%\"" >> conf/machine/raspberrypi4-64.conf
cd ..

source oe-init-build-env # in build dir

bitbake-layers add-layer ../meta-raspberrypi
bitbake-layers add-layer ../meta-seeed-reterminal
bitbake-layers add-layer ../meta-qt5
bitbake-layers add-layer ../meta-openembedded/meta-oe
bitbake-layers add-layer ../meta-openembedded/meta-python

# modify local.conf to build raspberrypi4 64-bit system
sed -i '/^MACHINE/s/= .*$/= "seeed-reterminal"/g' conf/local.conf
sed -i 's/#SSTATE_DIR/SSTATE_DIR/g' conf/local.conf

# we don't run start the compile here. 
# because we need to copy the cache to build/ dir before we do that.
