SUMMARY = "Default DHCP network configuration (eth0) for Seeed images"
DESCRIPTION = "core-image-base ships no network configuration by default; enable systemd-networkd DHCP on eth0 so boards get an address on first boot."
LICENSE = "MIT"
LIC_FILES_CHKSUM = "file://${COMMON_LICENSE_DIR}/MIT;md5=0835ade698e0bcf8506ecda2f7b4f302"


do_install() {
    install -d ${D}${systemd_unitdir}/network
    printf '[Match]\nType=ether\n\n[Network]\nDHCP=yes\n' \
        > ${D}${systemd_unitdir}/network/10-dhcp.network

    install -d ${D}${sysconfdir}/systemd/system/multi-user.target.wants
    ln -sf /lib/systemd/system/systemd-networkd.service \
        ${D}${sysconfdir}/systemd/system/multi-user.target.wants/systemd-networkd.service
    ln -sf /lib/systemd/system/systemd-resolved.service \
        ${D}${sysconfdir}/systemd/system/multi-user.target.wants/systemd-resolved.service
    ln -sf /run/systemd/resolve/stub-resolv.conf ${D}${sysconfdir}/resolv.conf
}

FILES:${PN} = "${systemd_unitdir}/network/10-dhcp.network ${sysconfdir}/systemd/system/multi-user.target.wants/ ${sysconfdir}/resolv.conf"
