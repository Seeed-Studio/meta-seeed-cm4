SUMMARY = "Python Library for reTerminal"
DESCRIPTION = "you can use the onboard hardware on the reterminal via this \
library"
HOMEPAGE = "https://github.com/Seeed-Studio/Seeed_Python_ReTerminal"

LICENSE = "MIT"
LIC_FILES_CHKSUM = "file://LICENSE;md5=6a91c33fdb9c2f0d4aeab7a112beca27"

SRCREV = "${AUTOREV}"

SRC_URI = "git://github.com/Seeed-Studio/Seeed_Python_ReTerminal.git;protocol=https;branch=main \
	file://S53python_symlink \
	"


inherit setuptools3

INSANE_SKIP:${PN} = "file-rdeps"

MY_DESTINATION = "/home/root/Seeed_Python_ReTerminal"

do_install:append() {
	install -d ${D}${MY_DESTINATION}
	cp -r ${S}/* ${D}${MY_DESTINATION}	
	install -d ${D}/etc/rc5.d/
	cp ${UNPACKDIR}/S53python_symlink ${D}/etc/rc5.d/
}

FILES:${PN} += "${MY_DESTINATION}/*"
