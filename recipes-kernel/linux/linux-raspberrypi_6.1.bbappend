FILESEXTRAPATHS:prepend := "${THISDIR}/files:"

SRC_URI += " \
    file://0001-modify-makefile-for-reterminal.patch \
    file://enable-audio.cfg \
    "

do_configure[network] = "1"
do_configure:append(){
        if [ -d ${WORKDIR}/seeed/ ]; then
                rm -r ${WORKDIR}/seeed/
        fi
        mkdir -p ${WORKDIR}/seeed/
        if ${@bb.utils.contains('MACHINE', 'seeed-reterminal-plus', 'true', 'false', d)} \
            || ${@bb.utils.contains('MACHINE', 'seeed-reterminal-plus-mender', 'true', 'false', d)}; then
            wget -P ${WORKDIR}/seeed/ \
                https://raw.githubusercontent.com/Seeed-Studio/seeed-linux-dtoverlays/master/overlays/rpi/reTerminal-plus-overlay.dts
            cp ${WORKDIR}/seeed/reTerminal-plus-overlay.dts ${S}/arch/arm/boot/dts/overlays/
        elif ${@bb.utils.contains('MACHINE', 'seeed-reterminal', 'true', 'false', d)} \
            || ${@bb.utils.contains('MACHINE', 'seeed-reterminal-mender', 'true', 'false', d)} \
            || ${@bb.utils.contains('MACHINE', 'dual-gbe-cm4', 'true', 'false', d)} \
            || ${@bb.utils.contains('MACHINE', 'dual-gbe-cm4-mender', 'true', 'false', d)}; then
            wget -P ${WORKDIR}/seeed/ \
                https://raw.githubusercontent.com/Seeed-Studio/seeed-linux-dtoverlays/master/overlays/rpi/reTerminal-overlay.dts
            cp ${WORKDIR}/seeed/reTerminal-overlay.dts ${S}/arch/arm/boot/dts/overlays/
        elif ${@bb.utils.contains('MACHINE', 'seeed-recomputer-r100x-mender', 'true', 'false', d)} \
            || ${@bb.utils.contains('MACHINE', 'seeed-recomputer-r100x', 'true', 'false', d)}; then
            wget -P ${WORKDIR}/seeed/ \
                https://raw.githubusercontent.com/Seeed-Studio/seeed-linux-dtoverlays/master/overlays/rpi/reComputer-R100x-overlay.dts
            cp ${WORKDIR}/seeed/reComputer-R100x-overlay.dts ${S}/arch/arm/boot/dts/overlays/
        else
            bbdebug 1 "No target device tree specified, check your MACHINE config"
        fi
}

