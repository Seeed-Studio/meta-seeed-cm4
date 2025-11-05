SUMMARY = "Semtech SX1302 LoRa concentrator HAL and packet forwarder"
DESCRIPTION = "Hardware Abstraction Layer and packet forwarder for SX1302 LoRa gateway"
LICENSE = "BSD-3-Clause"
LIC_FILES_CHKSUM = "file://LICENSE.TXT;md5=d2119120bd616e725f4580070bd9ee19"

SRC_URI = "git://github.com/Lora-net/sx1302_hal.git;protocol=https;branch=master \
           file://0003-use-reset-path.patch \
          "

SRC_URI:append:seeed-recomputer-r100x-mender = " \
           file://0001-change-i2c-device.patch \
           file://0002-change-spi-device.patch \
           file://reset_lgw.sh \
          "

SRCREV = "4b42025d1751e04632c0b04160e0d29dbbb222a5"

S = "${WORKDIR}/git"

DEPENDS = "libusb1"

inherit pkgconfig

INSANE_SKIP:${PN} = "ldflags already-stripped"

do_configure:append:seeed-recomputer-r100x-mender() {
    cp ${WORKDIR}/reset_lgw.sh ${S}/packet_forwarder/
}

do_compile() {
    oe_runmake CFLAGS="${CFLAGS} -I${S}/libtools/inc -I${S}/libloragw/inc -I${S}/packet_forwarder/inc"
}

do_install() {
    install -d ${D}${bindir}
    install -d ${D}${datadir}/sx1302/mcu_bin
    
    install -m 0755 ${S}/packet_forwarder/lora_pkt_fwd ${D}${bindir}/
    install -m 0755 ${S}/packet_forwarder/reset_lgw.sh ${D}${bindir}/sx1302_reset
    install -m 0644 ${S}/packet_forwarder/global_conf.json.* ${D}${datadir}/sx1302/
    
    if [ -d ${S}/mcu_bin ]; then
        install -m 0644 ${S}/mcu_bin/*.bin ${D}${datadir}/sx1302/mcu_bin/ || true
    fi
    
    install -m 0755 ${S}/util_boot/boot ${D}${bindir}/sx1302_boot
    install -m 0755 ${S}/util_chip_id/chip_id ${D}${bindir}/sx1302_chip_id
    install -m 0755 ${S}/util_spectral_scan/spectral_scan ${D}${bindir}/sx1302_spectral_scan
}

FILES:${PN} = "${bindir}/* ${datadir}/sx1302/*"
