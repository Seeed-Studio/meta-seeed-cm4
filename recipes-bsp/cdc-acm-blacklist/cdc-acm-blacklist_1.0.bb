SUMMARY = "Blacklist the in-kernel cdc_acm driver on reComputer R2x"
DESCRIPTION = "The WCH CH344L quad serial and CH343P single serial on reComputer R2x (R2000) are USB CDC devices. The in-kernel cdc_acm driver mishandles them: bulk transfers that are full USB packets (64 bytes) or contain NUL bytes stall, and sustained traffic wedges the data path, which breaks the RS485 ports in real Modbus-style use. The out-of-tree ch34x driver shipped via seeed-linux-dtoverlays (WCH V2.1) drives them correctly and exports the ports as ttyCH343USB0-4 (COM1=RS232, COM2/3/4=RS485). Without this blacklist cdc_acm and ch34x race at enumeration and cdc_acm often wins, so blacklist cdc_acm to make the ch34x binding deterministic. Note: an optional CDC-ACM modem on the M.2 slot would also need cdc_acm; remove this file if such a modem is added. Verified on hardware: with this blacklist all three RS485 ports pass bidirectional loopback and Modbus-style transaction tests."
LICENSE = "MIT"
LIC_FILES_CHKSUM = "file://${COMMON_LICENSE_DIR}/MIT;md5=0835ade698e0bcf8506ecda2f7b4f302"

do_install() {
    install -d ${D}${sysconfdir}/modprobe.d
    printf 'blacklist cdc_acm\n' > ${D}${sysconfdir}/modprobe.d/blacklist-cdc-acm.conf
}

FILES:${PN} = "${sysconfdir}/modprobe.d/blacklist-cdc-acm.conf"
