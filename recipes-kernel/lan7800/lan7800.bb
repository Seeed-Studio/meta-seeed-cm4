SUMMARY = "Linux kernel module for LAN7800"

LICENSE = "CLOSED"

inherit module

SRC_URI = "file://Makefile \
           file://lan78xx.c \
           file://lan78xx.h \
          "

S = "${WORKDIR}"

# The inherit of module.bbclass will automatically name module packages with
# "kernel-module-" prefix as required by the oe-core build environment.

RPROVIDES:${PN} += "kernel-module-lan7800"
