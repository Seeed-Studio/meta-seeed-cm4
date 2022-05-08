FILESEXTRAPATHS:prepend := "${THISDIR}/files:"

SRC_URI += " \
        file://0001-modify-makefile-for-reterminal.patch \
        file://0001-ASoC-hdmi-codec-Fix-return-value-in-hdmi_codec_set_j.patch \
        "

do_configure:append(){
        if [ -d ${WORKDIR}/seeed/ ]; then
                rm -r ${WORKDIR}/seeed/
        fi
        mkdir -p ${WORKDIR}/seeed/
        wget -P ${WORKDIR}/seeed/ https://raw.githubusercontent.com/Seeed-Studio/seeed-linux-dtoverlays/master/overlays/rpi/reTerminal-overlay.dts
        cp ${WORKDIR}/seeed/reTerminal-overlay.dts ${S}/arch/arm/boot/dts/overlays/
}
