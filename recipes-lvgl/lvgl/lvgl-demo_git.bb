SUMMARY = "A lvgl demo for seeed reTerminal"
DESCRIPTION = "This demo can display on reterminal's lcd"
HOMEPAGE = "https://github.com/lvgl/lv_port_linux_frame_buffer"

LICENSE = "MIT"
LIC_FILES_CHKSUM = "file://${WORKDIR}/git/LICENSE;md5=802d3d83ae80ef5f343050bf96cce3a4"

SRCREV = "245161f37d63a538499c61f574c7943d29a89a5a"

SRC_URI = "\
	gitsm://github.com/lvgl/lv_port_linux_frame_buffer.git;protocol=https;branch=master \
	file://0001-yocto-lvgl-display-input-rotate.patch \
	file://0002-fix-the-TP-point-rotation-of-reTerminal.patch \
	"

DEPENDS += "libinput"

S = "${WORKDIR}/git"

CFLAGS:prepend = "-I${S} "

LDFLAGS:prepend = "-linput "

do_compile() {
	oe_runmake
}

MY_DESTINATION1 = "/usr/bin"
do_install() {
	install -d ${D}${MY_DESTINATION1}
	cp ${WORKDIR}/git/demo ${D}${MY_DESTINATION1}/lvgl_demo
}

FILES:${PN} += "${MY_DESTINATION1}/*"
