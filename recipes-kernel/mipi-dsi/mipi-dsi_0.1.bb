SUMMARY = "Linux kernel module for reTerminal LCD&TP"
DESCRIPTION = "${SUMMARY}"
LICENSE = "GPLv2"
LIC_FILES_CHKSUM = "file://COPYING;md5=12f884d2ae1ff87c09e5b7ccc2c4ca7e"

inherit module

SRC_URI = "file://Makefile \
           file://mipi_dsi_drv.c \
           file://mipi_dsi.h \
           file://panel-ili9881d.c \
           file://panel-st7701s.c \
           file://README.md \
           file://touch_panel.c \
           file://COPYING \
          "

S = "${WORKDIR}"

# The inherit of module.bbclass will automatically name module packages with
# "kernel-module-" prefix as required by the oe-core build environment.

RPROVIDES_${PN} += "kernel-module-mipi-dsi"
