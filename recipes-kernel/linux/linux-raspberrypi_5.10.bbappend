FILESEXTRAPATHS:prepend := "${THISDIR}/files:"

SRC_URI += " \
	file://0001-modify-makefile-for-reterminal.patch \
	file://0001-ASoC-hdmi-codec-Fix-return-value-in-hdmi_codec_set_j.patch \
	file://reTerminal-overlay.dts \
"

do_patch:prepend(){
	cp ${WORKDIR}/reTerminal-overlay.dts ${S}/arch/arm/boot/dts/overlays/	
}
