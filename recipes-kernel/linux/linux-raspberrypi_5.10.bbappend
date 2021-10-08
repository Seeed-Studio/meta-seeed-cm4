FILESEXTRAPATHS_prepend := "${THISDIR}/files:"

SRC_URI += " \
	file://0001-modify-makefile-for-reterminal.patch \
	"

do_configure_append(){
	if [ -d ${WORKDIR}/seeed/ ]; then
		rm -r ${WORKDIR}/seeed/
	fi
	mkdir -p ${WORKDIR}/seeed/
	git clone https://github.com/Seeed-Studio/seeed-linux-dtoverlays.git ${WORKDIR}/seeed/
	cp ${WORKDIR}/seeed/overlays/rpi/reTerminal-overlay.dts ${S}/arch/arm/boot/dts/overlays/	
}
