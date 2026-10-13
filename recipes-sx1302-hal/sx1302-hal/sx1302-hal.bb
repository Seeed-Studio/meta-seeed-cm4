SUMMARY = "Semtech SX1302 LoRa concentrator HAL and packet forwarder"
DESCRIPTION = "Hardware Abstraction Layer and packet forwarder for SX1302 LoRa gateway"
LICENSE = "BSD-3-Clause"
LIC_FILES_CHKSUM = "file://LICENSE.TXT;md5=d2119120bd616e725f4580070bd9ee19"

SRC_URI = "git://github.com/Lora-net/sx1302_hal.git;protocol=https;branch=master \
           file://0001-change-reset-path.patch \
           file://0002-change-i2c-device.patch \
           file://0003-r100x-v1.1-expander-gpios.patch \
           file://0004-r100x-v1.1-spidev.patch \
           file://99-i2c-lora.rules \
          "

# reComputer R2x (R2000) routes the concentrator to /dev/spidev2.0 with the
# reset lines on the pca9535 expander (sysfs 632/633/634) and the module I2C
# on /dev/i2c-2; the r100x v1.1 patches above target different hardware, so
# replace them with the R2000 set on that machine.
SRC_URI:remove:seeed-recomputer-r2x-mender = "file://0002-change-i2c-device.patch file://0003-r100x-v1.1-expander-gpios.patch file://0004-r100x-v1.1-spidev.patch"
SRC_URI:append:seeed-recomputer-r2x-mender = " file://0005-r2000-reset-gpios.patch file://0006-r2000-spi-i2c-paths.patch"
SRC_URI:remove:seeed-recomputer-r2x = "file://0002-change-i2c-device.patch file://0003-r100x-v1.1-expander-gpios.patch file://0004-r100x-v1.1-spidev.patch"
SRC_URI:append:seeed-recomputer-r2x = " file://0005-r2000-reset-gpios.patch file://0006-r2000-spi-i2c-paths.patch"

# reComputer R22: WM1302 (SPI) in the mini-PCIe slot on RP1 SPI2
# (/dev/spidev2.0); resets are pca9535 expander lines resolved by name at
# runtime because their sysfs numbers shift between boots.
SRC_URI:remove:seeed-recomputer-r22-mender = "file://0002-change-i2c-device.patch file://0003-r100x-v1.1-expander-gpios.patch file://0004-r100x-v1.1-spidev.patch"
SRC_URI:append:seeed-recomputer-r22-mender = " file://0007-r22-reset-gpios.patch file://0008-r22-spi-paths.patch"
SRC_URI:remove:seeed-recomputer-r22 = "file://0002-change-i2c-device.patch file://0003-r100x-v1.1-expander-gpios.patch file://0004-r100x-v1.1-spidev.patch"
SRC_URI:append:seeed-recomputer-r22 = " file://0007-r22-reset-gpios.patch file://0008-r22-spi-paths.patch"

          
SRCREV = "4b42025d1751e04632c0b04160e0d29dbbb222a5"


DEPENDS = "libusb1"

# reset_lgw.sh is #!/bin/bash and the target is busybox-sh by default
RDEPENDS:${PN} += "bash"

inherit pkgconfig

INSANE_SKIP:${PN} = "ldflags already-stripped"

do_compile() {
    oe_runmake CFLAGS="${CFLAGS} -I${S}/libtools/inc -I${S}/libloragw/inc -I${S}/packet_forwarder/inc"
}

do_install() {
    install -d ${D}${bindir}
    install -d ${D}${datadir}/sx1302/mcu_bin
    
    install -m 0755 ${S}/packet_forwarder/lora_pkt_fwd ${D}${bindir}/
    install -m 0755 ${S}/tools/reset_lgw.sh ${D}${bindir}/sx1302_reset
    install -m 0644 ${S}/packet_forwarder/global_conf.json.* ${D}${datadir}/sx1302/

    # lora_pkt_fwd invokes the reset script as ./reset_lgw.sh relative to its
    # CWD (system("./reset_lgw.sh start"), src/lora_pkt_fwd.c), so the script
    # must live next to the configs: run the forwarder from /usr/share/sx1302
    # (cd /usr/share/sx1302 && lora_pkt_fwd -c global_conf.json.sx1250.US915).
    install -m 0755 ${S}/tools/reset_lgw.sh ${D}${datadir}/sx1302/reset_lgw.sh
    
    if [ -d ${S}/mcu_bin ]; then
        install -m 0644 ${S}/mcu_bin/*.bin ${D}${datadir}/sx1302/mcu_bin/ || true
    fi
    
    install -m 0755 ${S}/util_boot/boot ${D}${bindir}/sx1302_boot
    install -m 0755 ${S}/util_chip_id/chip_id ${D}${bindir}/sx1302_chip_id
    install -m 0755 ${S}/util_spectral_scan/spectral_scan ${D}${bindir}/sx1302_spectral_scan

    # udev rule providing /dev/i2c-lora for the V1.1 i2c bus of the
    # concentrator module (the HAL opens /dev/i2c-lora, see 0002)
    install -d ${D}${sysconfdir}/udev/rules.d
    install -m 0644 ${UNPACKDIR}/99-i2c-lora.rules ${D}${sysconfdir}/udev/rules.d/
}

FILES:${PN} = "${bindir}/* ${datadir}/sx1302/* ${sysconfdir}/udev/rules.d/99-i2c-lora.rules"
