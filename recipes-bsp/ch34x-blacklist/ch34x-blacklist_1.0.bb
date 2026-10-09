SUMMARY = "Blacklist the seeed ch34x USB serial driver on reComputer R110x"
DESCRIPTION = "The CH348 quad serial on reComputer R110x operates in CDC mode and is driven by the in-kernel cdc_acm driver, exporting the four RS485/RS232 ports as ttyACM0-3. The out-of-tree ch34x module shipped via seeed-linux-dtoverlays claims two of the CH348's USB interfaces, leaving only three ttyACM ports. Blacklist it for this machine."
LICENSE = "MIT"
LIC_FILES_CHKSUM = "file://${COMMON_LICENSE_DIR}/MIT;md5=0835ade698e0bcf8506ecda2f7b4f302"

do_install() {
    install -d ${D}${sysconfdir}/modprobe.d
    printf 'blacklist ch34x\n' > ${D}${sysconfdir}/modprobe.d/blacklist-ch34x.conf
}

FILES:${PN} = "${sysconfdir}/modprobe.d/blacklist-ch34x.conf"
