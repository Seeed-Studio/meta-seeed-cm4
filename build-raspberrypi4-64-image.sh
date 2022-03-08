#!/bin/bash

git clone -b master https://github.com/agherzan/meta-raspberrypi.git
#git clone -b master https://github.com/meta-qt5/meta-qt5.git
#git clone -b master https://github.com/openembedded/meta-openembedded.git
#git clone -b master https://github.com/openembedded/openembedded-core.git
cd meta-raspberrypi/
git reset --hard 8dc3a310883ea87cd9900442f46f20bb08e57583
cd ..

source oe-init-build-env # in build dir

bitbake-layers add-layer ../meta-raspberrypi
#bitbake-layers add-layer ../meta-seeed-reterminal
#bitbake-layers add-layer ../meta-qt5
#bitbake-layers add-layer ../meta-openembedded/meta-oe
#bitbake-layers add-layer ../meta-openembedded/meta-python

# modify local.conf to build raspberrypi4 64-bit system
sed -i '/^MACHINE/s/= .*$/= "raspberrypi4-64"/g' conf/local.conf
#grep -q "^DL_DIR ?= \"/home/xiongjian/cache/yocto_cache/share/downloads\"$" conf/local.conf || \
#echo "DL_DIR ?= \"/home/xiongjian/cache/yocto_cache/share/downloads\"" >> conf/local.conf
#grep -q "^SSTATE_DIR ?= \"/home/xiongjian/compile/build_cache/sstate-cache\"$" conf/local.conf || \
#echo "SSTATE_DIR ?= \"/home/xiongjian/compile/build_cache/sstate-cache\"" >> conf/local.conf
#grep -q "^RPI_KERNEL_DEVICETREE_OVERLAYS_append = \" overlays/reTerminal.dtbo\"$" conf/local.conf || \
#echo "RPI_KERNEL_DEVICETREE_OVERLAYS:append = \" overlays/reTerminal.dtbo\"" >> conf/local.conf
#grep -q "^PACKAGECONFIG_append_pn-qtbase = \" eglfs \"$" conf/local.conf || \
#echo "PACKAGECONFIG:append:pn-qtbase = \" eglfs \"" >> conf/local.conf

# building image
bitbake rpi-test-image
