#!/bin/bash

git clone -b dunfell https://github.com/Seeed-Studio/meta-seeed-reterminal.git
git clone -b master git://git.yoctoproject.org/meta-raspberrypi
git clone -b dunfell https://github.com/meta-qt5/meta-qt5.git
git clone -b dunfell https://github.com/openembedded/meta-openembedded.git

# modify the meta-raspberrypi to avoid compile error
cd meta-raspberrypi/
rm dynamic-layers/meta-python/recipes-connectivity/lirc/*.bbappend
sed -i '/^LAYERSERIES_COMPAT_raspberrypi/s/= .*$/= "honister dunfell"/g' conf/layer.conf
sed -i 's/arm\/armv8a\///g' conf/machine/raspberrypi4-64.conf
cd ..

source oe-init-build-env # in build dir

bitbake-layers add-layer ../meta-raspberrypi
bitbake-layers add-layer ../meta-seeed-reterminal
bitbake-layers add-layer ../meta-qt5
bitbake-layers add-layer ../meta-openembedded/meta-oe
bitbake-layers add-layer ../meta-openembedded/meta-python

# modify local.conf to build raspberrypi4 64-bit system
sed -i '/^MACHINE/s/= .*$/= "raspberrypi4-64"/g' conf/local.conf
sed -i 's/#SSTATE_DIR/SSTATE_DIR/g' conf/local.conf
echo "RPI_KERNEL_DEVICETREE_OVERLAYS_append = \" overlays/reTerminal.dtbo overlays/i2c3.dtbo\"" >> conf/local.conf
echo "PACKAGECONFIG_append_pn-qtbase = \" eglfs \"" >> conf/local.conf
echo "DISTRO_FEATURES_remove = \" x11 wayland vulkan\"" >> conf/local.conf
echo "KERNEL_MODULE_AUTOLOAD:rpi = \"i2c-dev\"" >> conf/local.conf
echo "ENABLE_I2C = \"1\"" >> conf/local.conf

# we don't run start the compile here. 
# because we need to copy the cache to build/ dir before we do that.
