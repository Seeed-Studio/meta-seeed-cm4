FILESEXTRAPATHS:prepend := "${THISDIR}/${PN}:"

SRC_URI:append:rpi = " file://rpi-enable-bootscr.cfg"

# The 8de24e226d7 backport (bcmstb non-removable fix needed for R22 eMMC)
# is no longer carried here: meta-raspberrypi wrynose ships the same
# upstream commit as recipes-bsp/u-boot/files/8de24e226d7.patch via
# u-boot_2026.01.bbappend, and applying it twice fails do_patch with
# "can be reverse-applied".

