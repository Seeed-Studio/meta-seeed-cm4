SUMMARY = "Linux kernel module for reTerminal LCD&TP"
DESCRIPTION = "${SUMMARY}"
LICENSE = "GPLv2"
LIC_FILES_CHKSUM = "file://COPYING;md5=12f884d2ae1ff87c09e5b7ccc2c4ca7e"

inherit module

SRC_URI = "file://Makefile \
           file://lis3lv02d.c \
           file://lis3lv02d.h \
           file://lis3lv02d_i2c.c \
           file://lis3lv02d_spi.c \
           file://README.md \
           file://COPYING \
          "

S = "${WORKDIR}"

# The inherit of module.bbclass will automatically name module packages with
# "kernel-module-" prefix as required by the oe-core build environment.

RPROVIDES_${PN} += "kernel-module-lis3lv02d"
