SUMMARY = "A QT5 demo for seeed reterminal"
DESCRIPTION = "This demo can display the information \
and control the device of the reterminal"
HOMEPAGE = "https://github.com/Seeed-Studio/Seeed_Python_ReTerminalQt5Examples"

LICENSE = "GPLv2"
LIC_FILES_CHKSUM = "file://COPYING;md5=00a27da7ac0f9bcd17320ec29ef4bbf6"

SRCREV_default = "bb32334f2a2964170d6c7b6ee78356ebd8f3e30a"

SRC_URI[sha256sum] = "f4bd3e2daee1f384683445282dea658f1081c7909ad4fc3d46d630f5be339158"

SRC_URI = "https://gitee.com/daxiong/buildroot-demo-app.git;branch=master \
	"

S = "${WORKDIR}/git"

BB_STRICT_CHECKSUM = "0"

do_install() {
	mkdir -p ${D}/home/root/test/
	install ${S}/* ${D}/home/root/test/
}
