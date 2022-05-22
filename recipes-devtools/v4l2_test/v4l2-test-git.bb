SUMMARY = "A camera test demo for seeed reTerminal"
DESCRIPTION = "This demo use the Raspberry Pi Camera"
HOMEPAGE = "https://github.com/bigbearishappy/v4l2_test"

LICENSE = "MIT"
LIC_FILES_CHKSUM = "file://${WORKDIR}/git/LICENSE;md5=9066664d7f93c1baec4a6e23f5c1a64f"

SRCREV = "c16009ace9fd53bf7cf6d3ba465331466a47cf3e"

SRC_URI = "\
	git://github.com/bigbearishappy/v4l2_test.git;protocol=https;branch=main \
	"

DEPENDS += "glibc"

S = "${WORKDIR}/git"

do_compile() {
		${CC} v4l2_test.c -o v4l2test ${CFLAGS} ${LDFLAGS}
}

MY_DESTINATION1 = "/usr/bin"
do_install() {
	install -d ${D}${MY_DESTINATION1}
	install -m 0755 ${WORKDIR}/git/v4l2test ${D}${MY_DESTINATION1}/v4l2test
}

FILES:${PN} += "${MY_DESTINATION1}/*"
