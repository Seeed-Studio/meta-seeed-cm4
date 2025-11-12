FILESEXTRAPATHS:prepend := "${THISDIR}/files:"

KBUILD_DEFCONFIG:seeed-recomputer-r2x ?= "bcm2712_defconfig"

do_configure[network] = "1"
do_configure:append(){
        if [ -d ${WORKDIR}/seeed/ ]; then
                rm -r ${WORKDIR}/seeed/
        fi
        mkdir -p ${WORKDIR}/seeed/
        if ${@bb.utils.contains('MACHINE', 'seeed-recomputer-r2x', 'true', 'false', d)}; then
            wget -P ${WORKDIR}/seeed/ \
                https://raw.githubusercontent.com/Seeed-Studio/seeed-linux-dtoverlays/master/overlays/rpi/reComputer-R2x-base-overlay.dts
            cp ${WORKDIR}/seeed/reComputer-R2x-base-overlay.dts ${S}/arch/arm/boot/dts/overlays/

            wget -P ${WORKDIR}/seeed/ \
                https://raw.githubusercontent.com/Seeed-Studio/seeed-linux-dtoverlays/master/overlays/rpi/reComputer-R21-overlay.dts
            cp ${WORKDIR}/seeed/reComputer-R21-overlay.dts ${S}/arch/arm/boot/dts/overlays/
        else
            bbdebug 1 "No target device tree specified, check your MACHINE config"
        fi
}
