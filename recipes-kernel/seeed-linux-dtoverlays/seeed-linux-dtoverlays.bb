SUMMARY = "seeed reterminal device tree overlay"
DESCRIPTION = "include all the device dtoverlay of reterminal"
HOMEPAGE = "https://github.com/Seeed-Studio/seeed-linux-dtoverlays"

LICENSE = "GPL-2.0-only"
LIC_FILES_CHKSUM = "file://${WORKDIR}/git/COPYING;md5=bbea815ee2795b2f4230826c0c6b8814"

inherit linux-kernel-base module-base deploy

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
    install -d ${D}${nonarch_base_libdir}/modules/${KERNEL_VERSION}/extra/
    oe_runmake \
        ARCH=${ARCH} \
        KBUILD=${STAGING_KERNEL_DIR} \
        CROSS_COMPILE=${TARGET_PREFIX} \
        KO_DIR=${D}${nonarch_base_libdir}/modules/${KERNEL_VERSION}/extra/ \
        install_rpi
    
    # Install device tree overlay files to package
    install -d ${D}${DEPLOYDIR}
    # Also install to /boot directory for rootfs
    install -d ${D}/boot
    if [ -d overlays/rpi ]; then
        for dtbo in overlays/rpi/*.dtbo; do
            if [ -f "$dtbo" ]; then
                dtbo_name=$(basename "$dtbo")
                # Remove '-overlay' suffix if present for standard naming
                target_name=$(echo "$dtbo_name" | sed 's/-overlay\.dtbo$/.dtbo/')
                install -m 0644 "$dtbo" "${D}${DEPLOYDIR}/$target_name"
                install -m 0644 "$dtbo" "${D}/boot/$target_name"
            fi
        done
    fi
}

do_deploy() {
    # Deploy device tree overlay files to main deploy directory
    if [ -d overlays/rpi ]; then
        for dtbo in overlays/rpi/*.dtbo; do
            if [ -f "$dtbo" ]; then
                dtbo_name=$(basename "$dtbo")
                # Remove '-overlay' suffix if present for standard naming
                target_name=$(echo "$dtbo_name" | sed 's/-overlay\.dtbo$/.dtbo/')
                install -m 0644 "$dtbo" "${DEPLOYDIR}/$target_name"
            fi
        done
    fi
}

addtask deploy before do_build after do_compile

FILES:${PN} += "${nonarch_base_libdir}/modules/${KERNEL_VERSION}/extra/*"
FILES:${PN} += "${DEPLOYDIR}/*"
FILES:${PN} += "/boot/*"
