SUMMARY = "A QT5 demo for seeed reterminal"
DESCRIPTION = "This demo can display the information \
and control the device of the reterminal"
HOMEPAGE = "https://github.com/Seeed-Studio/Seeed_Python_ReTerminalQt5Examples"

LICENSE = "GPLv3"
LIC_FILES_CHKSUM = "file://${WORKDIR}/git/LICENSE;md5=1ebbd3e34237af26da5dc08a4e440464"

SRCREV = "${AUTOREV}"

inherit systemd

SRC_URI = "git://github.com/Seeed-Studio/Seeed_Python_ReTerminalQt5Examples.git;protocol=https;branch=main \
	file://S52qtdemo \
	file://S51expand_file_system \
	file://seeed_qtdemo.service \
	"

S = "${WORKDIR}/git"

INSANE_SKIP:${PN} = "file-rdeps"

MY_DESTINATION = "/home/root/Seeed_Python_ReTerminalQt5Examples"
do_install() {
	install -d ${D}${MY_DESTINATION}
	if [ -d ${S}/imports/armv7l ]; then
		rm -r ${S}/imports/armv7l
	fi
	cp -r ${WORKDIR}/git/* ${D}${MY_DESTINATION}

	# install qtdemo start script for systemd
	install -d ${D}/var
	install -m 0755 ${WORKDIR}/S52qtdemo ${D}/var
	install -m 0755 ${WORKDIR}/S51expand_file_system ${D}/var

	# install qtdemo start service
	install -d ${D}${systemd_unitdir}/system/
        install -m 0644 ${WORKDIR}/seeed_qtdemo.service ${D}${systemd_unitdir}/system/

	# install qtdemo start script for sysvinit
	install -d ${D}/etc/rc5.d/
	cp ${WORKDIR}/S52qtdemo ${D}/etc/rc5.d/
	cp ${WORKDIR}/S51expand_file_system ${D}/etc/rc5.d/
}

FILES:${PN} += "${MY_DESTINATION}/*"

SYSTEMD_SERVICE:${PN} = "seeed_qtdemo.service"
SYSTEMD_AUTO_ENABLE:${PN} = "enable"
