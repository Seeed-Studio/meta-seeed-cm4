SUMMARY = "ATECC608 utility with proxychains"
DESCRIPTION = "Pre-built atecc-util and proxychains-ng"
LICENSE = "MIT & GPL-2.0-only"
LIC_FILES_CHKSUM = "file://${COMMON_LICENSE_DIR}/MIT;md5=0835ade698e0bcf8506ecda2f7b4f302"

SRC_URI = "git://github.com/rofl0r/proxychains-ng.git;protocol=https;branch=master;name=proxychains;destsuffix=proxychains-ng \
           git://github.com/wirenboard/atecc-util.git;protocol=https;branch=master;name=atecc;destsuffix=atecc-util \
           git://github.com/wirenboard/cryptoauthlib.git;protocol=https;branch=master;name=crypto;destsuffix=atecc-util/cryptoauthlib"

SRCREV_proxychains = "${AUTOREV}"
SRCREV_atecc = "${AUTOREV}"
SRCREV_crypto = "${AUTOREV}"

SRCREV_FORMAT = "proxychains_atecc_crypto"

S = "${WORKDIR}"

DEPENDS = "i2c-tools"

INSANE_SKIP:${PN} = "ldflags already-stripped"
INSANE_SKIP:${PN}-dev = "dev-elf"

do_configure() {
    # Configure proxychains-ng
    cd ${S}/proxychains-ng
    ./configure --prefix=/usr --sysconfdir=/etc
}

do_compile() {
    # Build proxychains-ng
    cd ${S}/proxychains-ng
    oe_runmake
    
    # Build atecc-util
    cd ${S}/atecc-util
    oe_runmake
}

do_install() {
    # Manually install proxychains files to avoid pseudo issues
    install -d ${D}${bindir}
    install -d ${D}${libdir}
    install -d ${D}${sysconfdir}
    
    # Install proxychains binaries
    install -m 0755 ${S}/proxychains-ng/proxychains4 ${D}${bindir}/
    install -m 0755 ${S}/proxychains-ng/proxychains4-daemon ${D}${bindir}/
    
    # Install proxychains library
    install -m 0755 ${S}/proxychains-ng/libproxychains4.so ${D}${libdir}/
    
    # Install proxychains config
    install -m 0644 ${S}/proxychains-ng/src/proxychains.conf ${D}${sysconfdir}/
    
    # Install atecc-util
    install -m 0755 ${S}/atecc-util/atecc ${D}${bindir}/
}

FILES:${PN} = "${bindir}/* ${libdir}/libproxychains4.so ${sysconfdir}/*"