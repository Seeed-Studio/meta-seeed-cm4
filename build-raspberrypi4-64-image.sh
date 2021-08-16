#!/bin/bash

git clone -b gatesgarth git://git.openembedded.org/meta-openembedded
git clone -b gatesgarth git://git.yoctoproject.org/meta-raspberrypi
#git clone -b gatesgarth https://github.com/meta-qt5/meta-qt5

source oe-init-build-env # in build dir

bitbake-layers add-layer ../meta-raspberrypi
#bitbake-layers add-layer ../meta-qt5

# modify local.conf to build raspberrypi3 64-bit system
sed -i '/^MACHINE/s/= .*$/= "raspberrypi3-64"/g' conf/local.conf
sed -i '/^#SDKMA/s/#\(.*\)=.*$/\1= "x86_64"/g'  conf/local.conf
#sed -i '/SDKMACHINE/aTOOLCHAIN_TARGET_TASK_append = "libc-staticdev"' conf/local.conf
#sed -i '/qt5-ptest/aPACKAGECONFIG_remove = "tslib"' ../meta-qt5/recipes-qt/qt5/qtbase_git.bb

# building image
bitbake core-image-base
#bitbake qtbase
#bitbake core-image-base -c populate_sdk_ext
