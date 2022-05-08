SUMMARY = "seeed reterminal device tree overlay"
DESCRIPTION = "include all the device dtoverlay of reterminal"
HOMEPAGE = "https://github.com/Seeed-Studio/seeed-linux-dtoverlays"

LICENSE = "GPLv3"
LIC_FILES_CHKSUM = "file://${WORKDIR}/git/COPYING;md5=bbea815ee2795b2f4230826c0c6b8814"

inherit linux-kernel-base module-base

KERNEL_VERSION = "${@get_kernelversion_file("${STAGING_KERNEL_BUILDDIR}")}"

SRCREV = "${AUTOREV}"

SRC_URI = "git://github.com/Seeed-Studio/seeed-linux-dtoverlays.git;protocol=https;branch=master \
	file://0001-compatible-for-yocto.patch \
	"

DEPENDS += " dtc-native"

S = "${WORKDIR}/git"

INSANE_SKIP:${PN} = "file-rdeps"

do_compile() {
	oe_runmake \
		ARCH=${ARCH} \
		KBUILD=${STAGING_KERNEL_DIR} \
		O=${STAGING_KERNEL_BUILDDIR} \
		CROSS_COMPILE=${TARGET_PREFIX} \
		all_rpi
}

do_install() {
	install -d ${D}/lib/modules/${KERNEL_VERSION}/extra/
	oe_runmake \
		ARCH=${ARCH} \
		KBUILD=${STAGING_KERNEL_DIR} \
		CROSS_COMPILE=${TARGET_PREFIX} \
		KO_DIR=${D}/lib/modules/${KERNEL_VERSION}/extra/ \
		install_rpi
}

FILES:${PN} += "/lib/modules/${KERNEL_VERSION}/extra/*"
